// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardImpl _$$CardImplFromJson(Map<String, dynamic> json) => _$CardImpl(
      id: json['id'] as String,
      faceValue: json['faceValue'] as int,
      isFlipped: json['isFlipped'] as bool,
    );

Map<String, dynamic> _$$CardImplToJson(_$CardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'faceValue': instance.faceValue,
      'isFlipped': instance.isFlipped,
    };
