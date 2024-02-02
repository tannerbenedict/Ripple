import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/scum_game_model.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/game_providers/scum_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/lobby/lobby.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ripple/app/router.dart';

part 'scum_notifier_online.g.dart';

@riverpod
class ScumOnlineNotifier extends _$ScumOnlineNotifier
    implements ScumNotifier<ScumGameModel?> {
  @override
  Future<ScumGameModel?> build(String lobbyCode, {int? seed}) async {
    final db = ref.read(databaseRepositoryProvider);

    db.watchScumGame(lobbyCode).listen((event) {
      if (event == null) {
        state = AsyncError(GameDeletedException(), StackTrace.current);
      } else {
        state = AsyncData(event);
      }
    });

    return await db.getScumGame(lobbyCode);
  }

  @override
  Future<void> notPlayingAgain() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    } else if (user == null) {
      throw UserRequiredError();
    }

    await updateAtomically(
        lobbyCode, User.fromFirebaseUser(user), UpdateType.notPlaying);
  }

  @override
  Future<void> playingAgain() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    } else if (user == null) {
      throw UserRequiredError();
    }

    await updateAtomically(
        lobbyCode, User.fromFirebaseUser(user), UpdateType.replaying);
  }

  @override
  Future<void> createNewGame() async {
    final db = ref.read(databaseRepositoryProvider);
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final possibleGame = await db.getScumGame(lobbyCode);

    if (possibleGame != null) {
      throw GameAlreadyExistsException();
    } else if (user == null) {
      throw UserRequiredError();
    }

    final newGame = ScumGameModel.newGame(
        lobbyCode, User.fromFirebaseUser(user), Random(seed));
    await _optimisticStateUpdate(newGame);
  }

  @override
  Future<void> discardCards(List<Card> cards, User user) async {
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    }

    await _optimisticStateUpdate(game.discardCards(cards, user));
  }

  @override
  Future<void> pass(User user) async {
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    }

    await _optimisticStateUpdate(game.pass(user));
  }

  @override
  Future<void> shuffleCards() async {
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    }

    await _optimisticStateUpdate(game.shuffleCards(rng: Random(seed)));
  }

  @override
  Future<void> roundEnd() async {
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    }

    await _optimisticStateUpdate(game.roundEnd());
  }

  @override
  Future<void> startGame() async {
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    }

    await _optimisticStateUpdate(game.startGame().shuffleCards());
  }

  @override
  Future<void> joinGame() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final db = ref.read(databaseRepositoryProvider);

    final game = await db.getScumGame(lobbyCode);
    if (game == null) {
      throw GameNotFoundException();
    } else if (user == null) {
      throw UserRequiredError();
    } else if (game.players.contains(User.fromFirebaseUser(user))) {
      return;
    } else if (game.players.length == 6) {
      throw GameFullException();
      // Technically, we'll hit the exception case above first, as
      // a non-pending game must, by our definition, have two players.
      // Pays to be thorough though, especially later on when we add
      // Crashalytics.
    }
    // else if (game.gameStatus != GameStatus.pending) {
    //   throw GameNotJoinableException();
    // }

    await updateAtomically(
        lobbyCode, User.fromFirebaseUser(user), UpdateType.newPlayer);
  }

  @override
  Future<void> updateHost() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    } else if (user == null) {
      throw UserRequiredError();
    }

    await updateAtomically(
        lobbyCode, User.fromFirebaseUser(user), UpdateType.updateHost);
  }

  Future<void> _optimisticStateUpdate(ScumGameModel game) async {
    final previous = state;
    final db = ref.read(databaseRepositoryProvider);

    state = AsyncData(game);

    try {
      await db.updateScumGame(game);
    } catch (e) {
      state = previous;
      rethrow;
    }
  }

  Future<void> updateAtomically(
      String lobbyCode, User user, UpdateType update) async {
    final previous = state;
    final db = ref.read(databaseRepositoryProvider);

    try {
      state = AsyncData((await db.updateScumLobby(lobbyCode, user, update)));
    } catch (e) {
      state = previous;
      rethrow;
    }
  }

  @override
  (String, Map<String, String>) getGameRoutingInfo() {
    return (GameType.scum.onlineRouteName, {"lobbyCode": lobbyCode});
  }

  @override
  (String, Map<String, String>) getLobbyRoutingInfo() {
    return (
      LobbyPage.routeName,
      {"gameType": GameType.scum.toString(), "lobbyCode": lobbyCode}
    );
  }
}
