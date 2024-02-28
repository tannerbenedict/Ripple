import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ripple/globals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

part 'card.g.dart';
part 'card.freezed.dart';

extension ReducedHashCode on List<Card> {
  int get reducedHashCode {
    return fold(
        0, (previousValue, element) => previousValue ^ element.hashCode);
  }
}

typedef UUID = String;

@Freezed(equal: false)
class Card with _$Card {
  static final _uuid = Uuid();

  factory Card._internal(
      {required UUID id,
      required int faceValue,
      required bool isFlipped}) = _Card;

  factory Card({
    UUID? id,
    required int faceValue,
    required bool isFlipped,
  }) {
    return Card._internal(
      id: id ?? _uuid.v4(),
      faceValue: faceValue,
      isFlipped: isFlipped,
    );
  }

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  // Required by freezed to have methods/getters defined, not entirely sure why.
  Card._();

  Image get front {
    return Image.asset('./images/cards/$faceValue.png');
  }

  static Image get back => Image.asset(cardBack);

  bool get visibility {
    return isFlipped;
  }

  @override
  String toString() {
    return '$faceValue';
  }

  int getCardValue() {
    if (faceValue == 7 || faceValue == 11) {
      return 0;
    }
    return faceValue;
  }

  bool sameCard(Card other) {
    return other.faceValue == faceValue;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Card && other.id == id;
  }

  @override
  int get hashCode => faceValue.hashCode ^ id.hashCode;
}
