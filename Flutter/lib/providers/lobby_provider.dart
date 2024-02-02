import 'dart:math';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/database_models/lobby_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lobby_provider.g.dart';

class LobbyAlreadyExistsException implements Exception {}

@riverpod
class LobbyNotifier extends _$LobbyNotifier {

  @override
  Future<LobbyModel?> build(String lobbyCode, {int? seed}) async {
    final db = ref.read(databaseRepositoryProvider);

    db.watchLobby(lobbyCode).listen((event) {
      if (event == null) {
        state = AsyncError(GameDeletedException(), StackTrace.current);
      } else {
        state = AsyncData(event);
      }
    });

    return await db.getLobby(lobbyCode);
  }

  Future<void> createNewLobby(GameType gameType) async {
    final db = ref.read(databaseRepositoryProvider);
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final possibleLobby = await db.getLobby(lobbyCode);

    if (possibleLobby != null) {
      throw LobbyAlreadyExistsException();
    } else if (user == null) {
      throw UserRequiredError();
    }

    final newGame = LobbyModel.newLobby(gameType,
        lobbyCode, User.fromFirebaseUser(user), Random(seed));
    await _optimisticStateUpdate(newGame);
  }

  Future<LobbyModel> joinGame() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final db = ref.read(databaseRepositoryProvider);

    final lobby = await db.getLobby(lobbyCode);
    if (lobby == null) {
      throw GameNotFoundException();
    } else if (user == null) {
      throw UserRequiredError();
    } else if (lobby.players.contains(User.fromFirebaseUser(user))) {
      return lobby;
    }

    await _optimisticStateUpdate(lobby.addPlayer(User.fromFirebaseUser(user)));
    return lobby;
  }

  Future<void> startGame() async {
    final lobby = state.asData?.value;

    if (lobby == null) {
      throw GameNotFoundException();
    }

    await _optimisticStateUpdate(lobby.startGame());
  }

  Future<void> _optimisticStateUpdate(LobbyModel lobby) async {
    final previous = state;
    final db = ref.read(databaseRepositoryProvider);

    state = AsyncData(lobby);

    try {
      await db.updateLobby(lobby);
    } catch (e) {
      state = previous;
      rethrow;
    }
  }
}