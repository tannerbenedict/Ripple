// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LobbyModelImpl _$$LobbyModelImplFromJson(Map<String, dynamic> json) =>
    _$LobbyModelImpl(
      gameType: $enumDecode(_$GameTypeEnumMap, json['gameType']),
      lobbyCode: json['lobbyCode'] as String,
      players: (json['players'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      gameStatus: $enumDecode(_$GameStatusEnumMap, json['gameStatus']),
    );

Map<String, dynamic> _$$LobbyModelImplToJson(_$LobbyModelImpl instance) =>
    <String, dynamic>{
      'gameType': instance.gameType.toJson(),
      'lobbyCode': instance.lobbyCode,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'gameStatus': instance.gameStatus.toJson(),
    };

const _$GameTypeEnumMap = {
  GameType.solitaire: 'solitaire',
  GameType.ginRummy: 'ginRummy',
  GameType.hearts: 'hearts',
  GameType.scum: 'scum',
  GameType.cheat: 'cheat',
};

const _$GameStatusEnumMap = {
  GameStatus.cancelled: 'cancelled',
  GameStatus.pending: 'pending',
  GameStatus.inLobby: 'inLobby',
  GameStatus.playing: 'playing',
  GameStatus.roundEnded: 'roundEnded',
  GameStatus.finished: 'finished',
};
