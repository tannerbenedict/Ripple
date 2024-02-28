// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      firebaseId: json['firebaseId'] as String,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      profileUrl: json['profileUrl'] as String?,
      coins: json['coins'] as int,
      cardBacks:
          (json['cardBacks'] as List<dynamic>).map((e) => e as String).toList(),
      selectedCardBack: json['selectedCardBack'] as String,
      gamesPlayed: json['gamesPlayed'] as int,
      gamesWon: json['gamesWon'] as int,
      twoPlayerGamesPlayed: json['twoPlayerGamesPlayed'] as int,
      twoPlayerGamesWon: json['twoPlayerGamesWon'] as int,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'firebaseId': instance.firebaseId,
      'displayName': instance.displayName,
      'email': instance.email,
      'profileUrl': instance.profileUrl,
      'coins': instance.coins,
      'cardBacks': instance.cardBacks,
      'selectedCardBack': instance.selectedCardBack,
      'gamesPlayed': instance.gamesPlayed,
      'gamesWon': instance.gamesWon,
      'twoPlayerGamesPlayed': instance.twoPlayerGamesPlayed,
      'twoPlayerGamesWon': instance.twoPlayerGamesWon,
    };
