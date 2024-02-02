import 'dart:math';

import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lobby_model.freezed.dart';
part 'lobby_model.g.dart';

typedef PlayerID = String;

@freezed
class LobbyModel with _$LobbyModel {
  LobbyModel._();

  factory LobbyModel({
    required GameType gameType,
    required String lobbyCode,
    required List<User> players,
    required GameStatus gameStatus,
  }) = _LobbyModel;

  factory LobbyModel.fromJson(Map<String, dynamic> json) =>
      _$LobbyModelFromJson(json);

  factory LobbyModel.newLobby(
      GameType gameType, String lobbyCode, User user, Random rng) {
    return LobbyModel(
        gameType: gameType,
        lobbyCode: lobbyCode,
        players: [user],
        gameStatus: GameStatus.pending);
  }

  LobbyModel addPlayer(User user) =>
      copyWith(players: [...players, user], gameStatus: GameStatus.inLobby);

  LobbyModel startGame() {
    return copyWith(gameStatus: GameStatus.playing);
  }
}
