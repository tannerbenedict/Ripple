// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardImpl _$$CardImplFromJson(Map<String, dynamic> json) => _$CardImpl(
      id: json['id'] as String,
      faceValue: json['faceValue'] as int,
      suit: $enumDecode(_$SuitEnumMap, json['suit']),
    );

Map<String, dynamic> _$$CardImplToJson(_$CardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'faceValue': instance.faceValue,
      'suit': _$SuitEnumMap[instance.suit]!,
    };

const _$SuitEnumMap = {
  Suit.hearts: 'hearts',
  Suit.diamonds: 'diamonds',
  Suit.spades: 'spades',
  Suit.clubs: 'clubs',
  Suit.redJoker: 'redJoker',
  Suit.blackJoker: 'blackJoker',
};
