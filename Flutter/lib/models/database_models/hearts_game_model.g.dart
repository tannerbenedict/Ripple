// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hearts_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HeartsGameModelImpl _$$HeartsGameModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HeartsGameModelImpl(
      playerHands: (json['playerHands'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => Card.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      cardsPlayed: (json['cardsPlayed'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
      playerDiscards: (json['playerDiscards'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, e == null ? null : Card.fromJson(e as Map<String, dynamic>)),
      ),
      cardLed: json['cardLed'] == null
          ? null
          : Card.fromJson(json['cardLed'] as Map<String, dynamic>),
      turnOrder: (json['turnOrder'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      playerScores: Map<String, int>.from(json['playerScores'] as Map),
      playerWins: (json['playerWins'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => Card.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      lobbyCode: json['lobbyCode'] as String,
      firstPlayer: json['firstPlayer'] == null
          ? null
          : User.fromJson(json['firstPlayer'] as Map<String, dynamic>),
      handWinner: json['handWinner'] == null
          ? null
          : User.fromJson(json['handWinner'] as Map<String, dynamic>),
      currentIndex: json['currentIndex'] as int,
      roundEnded: json['roundEnded'] as bool,
      heartsBroken: json['heartsBroken'] as bool,
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
    );

Map<String, dynamic> _$$HeartsGameModelImplToJson(
        _$HeartsGameModelImpl instance) =>
    <String, dynamic>{
      'playerHands': instance.playerHands
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
      'cardsPlayed': instance.cardsPlayed.map((e) => e.toJson()).toList(),
      'playerDiscards':
          instance.playerDiscards.map((k, e) => MapEntry(k, e?.toJson())),
      'cardLed': instance.cardLed?.toJson(),
      'turnOrder': instance.turnOrder.map((e) => e.toJson()).toList(),
      'playerScores': instance.playerScores,
      'playerWins': instance.playerWins
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
      'lobbyCode': instance.lobbyCode,
      'firstPlayer': instance.firstPlayer?.toJson(),
      'handWinner': instance.handWinner?.toJson(),
      'currentIndex': instance.currentIndex,
      'roundEnded': instance.roundEnded,
      'heartsBroken': instance.heartsBroken,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'playersNotPlaying':
          instance.playersNotPlaying.map((e) => e.toJson()).toList(),
      'playersPlaying': instance.playersPlaying.map((e) => e.toJson()).toList(),
      'gameStatus': instance.gameStatus.toJson(),
      'host': instance.host.toJson(),
      'winner': instance.winner?.toJson(),
    };

const _$GameStatusEnumMap = {
  GameStatus.cancelled: 'cancelled',
  GameStatus.pending: 'pending',
  GameStatus.inLobby: 'inLobby',
  GameStatus.playing: 'playing',
  GameStatus.roundEnded: 'roundEnded',
  GameStatus.finished: 'finished',
};
