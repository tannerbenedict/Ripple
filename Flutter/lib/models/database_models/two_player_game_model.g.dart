// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_player_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TwoPlayerGameStateImpl _$$TwoPlayerGameStateImplFromJson(
        Map<String, dynamic> json) =>
    _$TwoPlayerGameStateImpl(
      currentPlayer: json['currentPlayer'] == null
          ? null
          : User.fromJson(json['currentPlayer'] as Map<String, dynamic>),
      isFirstTurn: json['isFirstTurn'] as bool,
      isSecondTurn: json['isSecondTurn'] as bool,
      drawPile: (json['drawPile'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
      discardPile: (json['discardPile'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
      playerHands: (json['playerHands'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => Card.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      drawnCard: json['drawnCard'] == null
          ? null
          : Card.fromJson(json['drawnCard'] as Map<String, dynamic>),
      playerScores: Map<String, int>.from(json['playerScores'] as Map),
      lobbyCode: json['lobbyCode'] as String,
      players: (json['players'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      playersNotPlaying: (json['playersNotPlaying'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      playersPlaying: (json['playersPlaying'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      gameStatus: $enumDecode(_$GameStatusEnumMap, json['gameStatus']),
      host: User.fromJson(json['host'] as Map<String, dynamic>),
      winner: json['winner'] == null
          ? null
          : User.fromJson(json['winner'] as Map<String, dynamic>),
      roundWinner: json['roundWinner'] == null
          ? null
          : User.fromJson(json['roundWinner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TwoPlayerGameStateImplToJson(
        _$TwoPlayerGameStateImpl instance) =>
    <String, dynamic>{
      'currentPlayer': instance.currentPlayer?.toJson(),
      'isFirstTurn': instance.isFirstTurn,
      'isSecondTurn': instance.isSecondTurn,
      'drawPile': instance.drawPile.map((e) => e.toJson()).toList(),
      'discardPile': instance.discardPile.map((e) => e.toJson()).toList(),
      'playerHands': instance.playerHands
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
      'drawnCard': instance.drawnCard?.toJson(),
      'playerScores': instance.playerScores,
      'lobbyCode': instance.lobbyCode,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'playersNotPlaying':
          instance.playersNotPlaying.map((e) => e.toJson()).toList(),
      'playersPlaying': instance.playersPlaying.map((e) => e.toJson()).toList(),
      'gameStatus': instance.gameStatus.toJson(),
      'host': instance.host.toJson(),
      'winner': instance.winner?.toJson(),
      'roundWinner': instance.roundWinner?.toJson(),
    };

const _$GameStatusEnumMap = {
  GameStatus.cancelled: 'cancelled',
  GameStatus.pending: 'pending',
  GameStatus.inLobby: 'inLobby',
  GameStatus.playing: 'playing',
  GameStatus.roundEnded: 'roundEnded',
  GameStatus.finished: 'finished',
};
