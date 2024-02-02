import 'dart:math';

import 'package:ripple/app/router.dart';
import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/cheat_game_model.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/game_providers/cheat_notifier.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/lobby/lobby.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cheat_notifier_online.g.dart';

const _cheatCalledDelay = Duration(seconds: 3);

@riverpod
class CheatOnlineNotifier extends _$CheatOnlineNotifier
    implements CheatNotifier<CheatGameModel?> {
  @override
  Future<CheatGameModel?> build(String lobbyCode, {int? seed}) async {
    final db = ref.read(databaseRepositoryProvider);

    db.watchCheatGame(lobbyCode).listen((event) {
      if (event == null) {
        state = AsyncError(GameDeletedException(), StackTrace.current);
      } else {
        state = AsyncData(event);
      }
    });

    return await db.getCheatGame(lobbyCode);
  }

  @override
  Future<void> createNewGame() async {
    final db = ref.read(databaseRepositoryProvider);
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final possibleGame = await db.getCheatGame(lobbyCode);

    if (possibleGame != null) {
      throw GameAlreadyExistsException();
    } else if (user == null) {
      throw UserRequiredError();
    }

    final newGame = CheatGameModel.newGame(
        lobbyCode, User.fromFirebaseUser(user), Random(seed));
    await _optimisticStateUpdate(newGame);
  }

  @override
  Future<void> discardCards(User user, List<Card> cards) async {
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    }

    var updatedGame = game.discardCards(cards, user);
    await _optimisticStateUpdate(updatedGame);

    if (updatedGame.isRoundEnd) {
      await Future.delayed(const Duration(seconds: 3));
      await _optimisticStateUpdate(updatedGame.roundEnd());
    }
  }

  @override
  Future<void> callCheat(User user) async {
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    }

    var updatedGame = game.callCheat(user);
    await _optimisticStateUpdate(updatedGame);

    await Future.delayed(_cheatCalledDelay);

    await _optimisticStateUpdate(updatedGame.updateAfterCheatCalled(user));
  }

  Future<void> shuffleCards() async {
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    }

    await _optimisticStateUpdate(game.shuffleCards(rng: Random(seed)));
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

  Future<void> updateAtomically(
      String lobbyCode, User user, UpdateType update) async {
    final previous = state;
    final db = ref.read(databaseRepositoryProvider);

    try {
      state = AsyncData((await db.updateCheatLobby(lobbyCode, user, update)));
    } catch (e) {
      state = previous;
      rethrow;
    }
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

  @override
  Future<void> joinGame() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final db = ref.read(databaseRepositoryProvider);

    final game = await db.getCheatGame(lobbyCode);
    if (game == null) {
      throw GameNotFoundException();
    } else if (user == null) {
      throw UserRequiredError();
    } else if (game.players.contains(User.fromFirebaseUser(user))) {
      return;
    } else if (game.players.length == 8) {
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

  Future<void> _optimisticStateUpdate(CheatGameModel game) async {
    final previous = state;
    final db = ref.read(databaseRepositoryProvider);

    state = AsyncData(game);

    try {
      await db.updateCheatGame(game);
    } catch (e) {
      state = previous;
      rethrow;
    }
  }

  @override
  (String, Map<String, String>) getGameRoutingInfo() {
    return (GameType.cheat.onlineRouteName, {"lobbyCode": lobbyCode});
  }

  @override
  (String, Map<String, String>) getLobbyRoutingInfo() {
    return (
      LobbyPage.routeName,
      {"gameType": GameType.cheat.toString(), "lobbyCode": lobbyCode}
    );
  }
}
