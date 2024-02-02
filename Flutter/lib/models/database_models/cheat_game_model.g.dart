// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cheat_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheatGameModelImpl _$$CheatGameModelImplFromJson(Map<String, dynamic> json) =>
    _$CheatGameModelImpl(
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
      turnOrder: (json['turnOrder'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      playerScores: Map<String, int>.from(json['playerScores'] as Map),
      lobbyCode: json['lobbyCode'] as String,
      firstPlayer: json['firstPlayer'] == null
          ? null
          : User.fromJson(json['firstPlayer'] as Map<String, dynamic>),
      handWinner: json['handWinner'] == null
          ? null
          : User.fromJson(json['handWinner'] as Map<String, dynamic>),
      currentIndex: json['currentIndex'] as int,
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
      playerWhoPlayed: json['playerWhoPlayed'] == null
          ? null
          : User.fromJson(json['playerWhoPlayed'] as Map<String, dynamic>),
      potentialWinner: json['potentialWinner'] == null
          ? null
          : User.fromJson(json['potentialWinner'] as Map<String, dynamic>),
      playerWhoCalledCheat: json['playerWhoCalledCheat'] == null
          ? null
          : User.fromJson(json['playerWhoCalledCheat'] as Map<String, dynamic>),
      playerWhoGotCards: json['playerWhoGotCards'] == null
          ? null
          : User.fromJson(json['playerWhoGotCards'] as Map<String, dynamic>),
      calledCheat: json['calledCheat'] as bool,
      numPlayedPrevious: json['numPlayedPrevious'] as int,
      currentFaceValue: json['currentFaceValue'] as int,
      isRoundEnd: json['isRoundEnd'] as bool,
    );

Map<String, dynamic> _$$CheatGameModelImplToJson(
        _$CheatGameModelImpl instance) =>
    <String, dynamic>{
      'playerHands': instance.playerHands
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
      'cardsPlayed': instance.cardsPlayed.map((e) => e.toJson()).toList(),
      'turnOrder': instance.turnOrder.map((e) => e.toJson()).toList(),
      'playerScores': instance.playerScores,
      'lobbyCode': instance.lobbyCode,
      'firstPlayer': instance.firstPlayer?.toJson(),
      'handWinner': instance.handWinner?.toJson(),
      'currentIndex': instance.currentIndex,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'playersNotPlaying':
          instance.playersNotPlaying.map((e) => e.toJson()).toList(),
      'playersPlaying': instance.playersPlaying.map((e) => e.toJson()).toList(),
      'gameStatus': instance.gameStatus.toJson(),
      'host': instance.host.toJson(),
      'playerWhoPlayed': instance.playerWhoPlayed?.toJson(),
      'potentialWinner': instance.potentialWinner?.toJson(),
      'playerWhoCalledCheat': instance.playerWhoCalledCheat?.toJson(),
      'playerWhoGotCards': instance.playerWhoGotCards?.toJson(),
      'calledCheat': instance.calledCheat,
      'numPlayedPrevious': instance.numPlayedPrevious,
      'currentFaceValue': instance.currentFaceValue,
      'isRoundEnd': instance.isRoundEnd,
    };

const _$GameStatusEnumMap = {
  GameStatus.cancelled: 'cancelled',
  GameStatus.pending: 'pending',
  GameStatus.inLobby: 'inLobby',
  GameStatus.playing: 'playing',
  GameStatus.roundEnded: 'roundEnded',
  GameStatus.finished: 'finished',
};
