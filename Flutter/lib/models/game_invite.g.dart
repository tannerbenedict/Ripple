// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameInviteImpl _$$GameInviteImplFromJson(Map<String, dynamic> json) =>
    _$GameInviteImpl(
      inviteId: json['inviteId'] as String,
      fromPlayer: User.fromJson(json['fromPlayer'] as Map<String, dynamic>),
      toPlayer: User.fromJson(json['toPlayer'] as Map<String, dynamic>),
      lobbyCode: json['lobbyCode'] as String,
      timeStamp: DateTime.parse(json['timeStamp'] as String),
      status: $enumDecode(_$InviteStatusEnumMap, json['status']),
      gameType: $enumDecode(_$GameTypeEnumMap, json['gameType']),
    );

Map<String, dynamic> _$$GameInviteImplToJson(_$GameInviteImpl instance) =>
    <String, dynamic>{
      'inviteId': instance.inviteId,
      'fromPlayer': instance.fromPlayer.toJson(),
      'toPlayer': instance.toPlayer.toJson(),
      'lobbyCode': instance.lobbyCode,
      'timeStamp': instance.timeStamp.toIso8601String(),
      'status': _$InviteStatusEnumMap[instance.status]!,
      'gameType': instance.gameType.toJson(),
    };

const _$InviteStatusEnumMap = {
  InviteStatus.pending: 'pending',
  InviteStatus.accepted: 'accepted',
  InviteStatus.expired: 'expired',
  InviteStatus.declined: 'declined',
};

const _$GameTypeEnumMap = {
  GameType.solitaire: 'solitaire',
  GameType.ginRummy: 'ginRummy',
  GameType.hearts: 'hearts',
  GameType.scum: 'scum',
  GameType.cheat: 'cheat',
};
