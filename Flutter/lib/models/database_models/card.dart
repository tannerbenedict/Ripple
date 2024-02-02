import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ripple/globals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

part 'card.g.dart';
part 'card.freezed.dart';

enum Suit implements Comparable<Suit> {
  hearts,
  diamonds,
  spades,
  clubs,
  redJoker,
  blackJoker;

  @override
  String toString() => name;

  @override
  int compareTo(Suit other) => name.compareTo(other.name);
}

extension CardNumIcons on int {
  IconData get asIcon {
    switch (this) {
      case 1:
        return MdiIcons.alphaACircleOutline;
      case 2:
        return MdiIcons.numeric2CircleOutline;
      case 3:
        return MdiIcons.numeric3CircleOutline;
      case 4:
        return MdiIcons.numeric4CircleOutline;
      case 5:
        return MdiIcons.numeric5CircleOutline;
      case 6:
        return MdiIcons.numeric6CircleOutline;
      case 7:
        return MdiIcons.numeric7CircleOutline;
      case 8:
        return MdiIcons.numeric8CircleOutline;
      case 9:
        return MdiIcons.numeric9CircleOutline;
      case 10:
        return MdiIcons.numeric10CircleOutline;
      case 11:
        return MdiIcons.alphaJCircleOutline;
      case 12:
        return MdiIcons.alphaQCircleOutline;
      case 13:
        return MdiIcons.alphaKCircleOutline;
      default:
        return Icons.error;
    }
  }
}

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

  factory Card._internal({
    required UUID id,
    required int faceValue,
    required Suit suit,
  }) = _Card;

  factory Card({
    UUID? id,
    required int faceValue,
    required Suit suit,
  }) {
    return Card._internal(
      id: id ?? _uuid.v4(),
      faceValue: faceValue,
      suit: suit,
    );
  }

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  // Required by freezed to have methods/getters defined, not entirely sure why.
  Card._();

  Image get front {
    String suitInitial;
    switch (suit) {
      case Suit.diamonds:
        suitInitial = "D";
        break;
      case Suit.clubs:
        suitInitial = "C";
        break;
      case Suit.hearts:
        suitInitial = "H";
        break;
      case Suit.spades:
        suitInitial = "S";
        break;
      case Suit.redJoker:
        return Image.asset('./images/cards/joker_red.png');
      case Suit.blackJoker:
        return Image.asset('./images/cards/joker_black.png');
    }
    return Image.asset('./images/cards/$faceValue$suitInitial.png');
  }

  static Image get back => Image.asset(cardBack);

  @override
  String toString() {
    if (suit == Suit.redJoker) {
      return 'joker_red';
    }

    if (suit == Suit.blackJoker) {
      return 'joker_black';
    }

    return '$faceValue$suit';
  }

  int getCardValue() {
    if (faceValue > 10) {
      return 10;
    }

    return faceValue;
  }

  int getTrickRankingOrder() {
    // joker is the best
    if (suit == Suit.blackJoker || suit == Suit.redJoker) {
      return 1000;
    }
    // ace is the next best
    if (faceValue == 1) {
      return 100;
    }

    return faceValue;
  }

  bool sameCard(Card other) {
    return other.faceValue == faceValue && other.suit == suit;
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
  int get hashCode => faceValue.hashCode ^ suit.hashCode ^ id.hashCode;

  static int sortByValue(Card a, Card b) {
    int valueA = a.faceValue;
    int valueB = b.faceValue;

    if (valueA < valueB) {
      return -1;
    } else if (valueA > valueB) {
      return 1;
    } else {
      return a.suit.compareTo(b.suit);
    }
  }

  static int sortByRank(Card a, Card b) {
    int valueA = a.getTrickRankingOrder();
    int valueB = b.getTrickRankingOrder();

    if (valueA < valueB) {
      return -1;
    } else if (valueA > valueB) {
      return 1;
    } else {
      return a.suit.compareTo(b.suit);
    }
  }

  static int sortBySuit(Card a, Card b) {
    int valueA = a.faceValue;
    int valueB = b.faceValue;

    int suitComparison = a.suit.compareTo(b.suit);

    if (suitComparison == 0) {
      return valueA.compareTo(valueB);
    } else {
      return suitComparison;
    }
  }
}
