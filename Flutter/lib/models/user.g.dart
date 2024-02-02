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
      solitaireGamesPlayed: json['solitaireGamesPlayed'] as int,
      solitaireGamesWon: json['solitaireGamesWon'] as int,
      ginRummyGamesPlayed: json['ginRummyGamesPlayed'] as int,
      ginRummyGamesWon: json['ginRummyGamesWon'] as int,
      heartsGamesPlayed: json['heartsGamesPlayed'] as int,
      heartsGamesWon: json['heartsGamesWon'] as int,
      scumGamesPlayed: json['scumGamesPlayed'] as int,
      scumGamesWon: json['scumGamesWon'] as int,
      cheatGamesPlayed: json['cheatGamesPlayed'] as int,
      cheatGamesWon: json['cheatGamesWon'] as int,
      solitaireBestMoves: json['solitaireBestMoves'] as int,
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
      'solitaireGamesPlayed': instance.solitaireGamesPlayed,
      'solitaireGamesWon': instance.solitaireGamesWon,
      'ginRummyGamesPlayed': instance.ginRummyGamesPlayed,
      'ginRummyGamesWon': instance.ginRummyGamesWon,
      'heartsGamesPlayed': instance.heartsGamesPlayed,
      'heartsGamesWon': instance.heartsGamesWon,
      'scumGamesPlayed': instance.scumGamesPlayed,
      'scumGamesWon': instance.scumGamesWon,
      'cheatGamesPlayed': instance.cheatGamesPlayed,
      'cheatGamesWon': instance.cheatGamesWon,
      'solitaireBestMoves': instance.solitaireBestMoves,
    };
