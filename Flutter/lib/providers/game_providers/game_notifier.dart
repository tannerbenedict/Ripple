import 'dart:math';

import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/providers/game_providers/two_player_notifier_online.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

class UserRequiredError extends Error {
  dynamic message;
  UserRequiredError({this.message});
}

class GameAlreadyExistsException implements Exception {}

class GameNotFoundException implements Exception {}

class GameFullException implements Exception {}

class GameDeletedException implements Exception {}

class GameEndedException implements Exception {}

class GameNotStartableException implements Exception {}

class RoundNotStartableException implements Exception {}

class InvalidCardDiscardedException implements Exception {}

class GameAlreadyJoinedException implements Exception {}

class OnlyHostCanStartGameException implements Exception {}

class GameNotJoinableException implements Exception {}

class NotPlayerTurnException implements Exception {}

class NotAPlayerException implements Exception {}

class DrawNotAllowedException implements Exception {}

class CannotPassException implements Exception {}

class CannotKnockException implements Exception {}

class CannotDiscardException implements Exception {}

class InvalidGameStateError implements Error {
  dynamic message;

  InvalidGameStateError(this.message);
  @override
  StackTrace? get stackTrace => StackTrace.current;

  @override
  String toString() => "InvalidGameStateError: $message";
}

typedef GameNotifierProvider<T extends GameNotifier<GameModel?>>
    // ignore: invalid_use_of_internal_member
    = AutoDisposeAsyncNotifierProviderImpl<T, GameModel?> Function(String,
        {int? seed});

extension GameTypeNotiferProvider on GameType {
  GameNotifierProvider get provider {
    switch (this) {
      case GameType.twoPlayer:
        return twoPlayerNotifierOnlineProvider.call;
    }
  }
}

abstract class GameNotifier<T extends GameModel?>
    // ignore: invalid_use_of_internal_member
    extends BuildlessAutoDisposeAsyncNotifier<T> {
  FutureOr<T> build(String lobbyCode, {int? seed});
  Future<void> createNewGame();

  Future<void> joinGame();

  Future<void> startGame();

  Future<void> playingAgain();

  Future<void> notPlayingAgain();

  Future<void> updateHost();

  (String, Map<String, String>) getLobbyRoutingInfo();

  (String, Map<String, String>) getGameRoutingInfo();
}

String generateLobbyCode({int length = 6}) {
  final chars = <int>[];
  final rand = Random();

  for (var i = 0; i < length; i++) {
    chars.add(rand.nextInt(26) + 65);
  }

  return String.fromCharCodes(chars);
}
