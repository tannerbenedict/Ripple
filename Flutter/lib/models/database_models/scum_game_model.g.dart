// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scum_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardPlayEntryImpl _$$CardPlayEntryImplFromJson(Map<String, dynamic> json) =>
    _$CardPlayEntryImpl(
      playerID: json['playerID'] as String,
      cards: (json['cards'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CardPlayEntryImplToJson(_$CardPlayEntryImpl instance) =>
    <String, dynamic>{
      'playerID': instance.playerID,
      'cards': instance.cards.map((e) => e.toJson()).toList(),
    };

_$ScumGameModelImpl _$$ScumGameModelImplFromJson(Map<String, dynamic> json) =>
    _$ScumGameModelImpl(
      playerHands: (json['playerHands'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => Card.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      playerPassed: Map<String, bool>.from(json['playerPassed'] as Map),
      cardsPlayed: (json['cardsPlayed'] as List<dynamic>)
          .map((e) => CardPlayEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      turnOrder: (json['turnOrder'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      playerScores: Map<String, int>.from(json['playerScores'] as Map),
      lobbyCode: json['lobbyCode'] as String,
      firstPlayer: json['firstPlayer'] == null
          ? null
          : User.fromJson(json['firstPlayer'] as Map<String, dynamic>),
      roundWinner: json['roundWinner'] == null
          ? null
          : User.fromJson(json['roundWinner'] as Map<String, dynamic>),
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
      isRoundEnd: json['isRoundEnd'] as bool,
      isTrickEnd: json['isTrickEnd'] as bool,
      trickWinner: json['trickWinner'] == null
          ? null
          : User.fromJson(json['trickWinner'] as Map<String, dynamic>),
      finishedOrder: (json['finishedOrder'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      roundNumber: json['roundNumber'] as int,
      positions: (json['positions'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, $enumDecode(_$PlayerPositionEnumMap, e)),
      ),
      lastPlayed: (json['lastPlayed'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ScumGameModelImplToJson(_$ScumGameModelImpl instance) =>
    <String, dynamic>{
      'playerHands': instance.playerHands
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
      'playerPassed': instance.playerPassed,
      'cardsPlayed': instance.cardsPlayed.map((e) => e.toJson()).toList(),
      'turnOrder': instance.turnOrder.map((e) => e.toJson()).toList(),
      'playerScores': instance.playerScores,
      'lobbyCode': instance.lobbyCode,
      'firstPlayer': instance.firstPlayer?.toJson(),
      'roundWinner': instance.roundWinner?.toJson(),
      'currentIndex': instance.currentIndex,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'playersNotPlaying':
          instance.playersNotPlaying.map((e) => e.toJson()).toList(),
      'playersPlaying': instance.playersPlaying.map((e) => e.toJson()).toList(),
      'gameStatus': instance.gameStatus.toJson(),
      'host': instance.host.toJson(),
      'isRoundEnd': instance.isRoundEnd,
      'isTrickEnd': instance.isTrickEnd,
      'trickWinner': instance.trickWinner?.toJson(),
      'finishedOrder': instance.finishedOrder.map((e) => e.toJson()).toList(),
      'roundNumber': instance.roundNumber,
      'positions': instance.positions
          .map((k, e) => MapEntry(k, _$PlayerPositionEnumMap[e]!)),
      'lastPlayed': instance.lastPlayed.map((e) => e.toJson()).toList(),
    };

const _$GameStatusEnumMap = {
  GameStatus.cancelled: 'cancelled',
  GameStatus.pending: 'pending',
  GameStatus.inLobby: 'inLobby',
  GameStatus.playing: 'playing',
  GameStatus.roundEnded: 'roundEnded',
  GameStatus.finished: 'finished',
};

const _$PlayerPositionEnumMap = {
  PlayerPosition.president: 'president',
  PlayerPosition.vicePresident: 'vicePresident',
  PlayerPosition.commoner: 'commoner',
  PlayerPosition.viceScum: 'viceScum',
  PlayerPosition.scum: 'scum',
};
