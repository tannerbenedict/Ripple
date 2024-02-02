import 'dart:core';
import 'package:ripple/models/database_models/card.dart';

class SolitaireLogic {
  static void shuffleAndDealCards(
      List<List<Card>> column1,
      List<List<Card>> column2,
      List<List<Card>> column3,
      List<List<Card>> column4,
      List<List<Card>> column5,
      List<List<Card>> column6,
      List<List<Card>> column7,
      List<List<Card>> drawPile) {
    List<Card> allCards = [];

    for (final suit in Suit.values) {
      if (suit != Suit.redJoker && suit != Suit.blackJoker) {
        for (int i = 1; i <= 13; i++) {
          allCards.add(Card(faceValue: i, suit: suit));
        }
      }
    }

    allCards.shuffle();
    column1[0].add(allCards[0]); //1 card
    column2[0].add(allCards[1]);
    column2[1].add(allCards[2]);
    column3[0].add(allCards[3]);
    column3[1].add(allCards[4]);
    column3[2].add(allCards[5]);
    column4[0].add(allCards[6]);
    column4[1].add(allCards[7]);
    column4[2].add(allCards[8]);
    column4[3].add(allCards[9]);
    column5[0].add(allCards[10]);
    column5[1].add(allCards[11]);
    column5[2].add(allCards[12]);
    column5[3].add(allCards[13]);
    column5[4].add(allCards[14]);
    column6[0].add(allCards[15]);
    column6[1].add(allCards[16]);
    column6[2].add(allCards[17]);
    column6[3].add(allCards[18]);
    column6[4].add(allCards[19]);
    column6[5].add(allCards[20]);
    column7[0].add(allCards[21]);
    column7[1].add(allCards[22]);
    column7[2].add(allCards[23]);
    column7[3].add(allCards[24]);
    column7[4].add(allCards[25]);
    column7[5].add(allCards[26]);
    column7[6].add(allCards[27]);

    int nextcard = 28;
    int cardsleft = allCards.length - nextcard;
    for (int i = 0; i < cardsleft; i++) {
      drawPile[i].add(allCards[nextcard]);
      nextcard++;
    }
  }

  static bool canAddColumn(List<Card> column, List<Card> cards) {
    if (column.isEmpty && cards[0].faceValue == 13) {
      return true;
    } else {
      if (column.isEmpty) {
        return false;
      }
      int lastNumber = column.last.faceValue;
      Suit lastSuit = column.last.suit;
      List<Suit> suits = columnSuits(lastSuit);
      if (suits.contains(cards.first.suit)) {
        if (lastNumber - 1 == cards.first.faceValue) {
          return true;
        }
      }
    }
    return false;
  }

  static List<Card> addCards(List<Card> column, List<Card> cards) {
    List<Card> temp = column;
    for (Card card in cards) {
      temp.add(card);
    }
    return temp;
  }

  static List<Suit> columnSuits(Suit suit) {
    List<Suit> suits = [];
    switch (suit) {
      case Suit.hearts:
        suits.add(Suit.clubs);
        suits.add(Suit.spades);
        break;
      case Suit.diamonds:
        suits.add(Suit.clubs);
        suits.add(Suit.spades);
        break;
      case Suit.clubs:
        suits.add(Suit.diamonds);
        suits.add(Suit.hearts);
        break;
      case Suit.spades:
        suits.add(Suit.diamonds);
        suits.add(Suit.hearts);
        break;
      default:
        break;
    }
    return suits;
  }

  static bool canAddSet(
      List<Card> set, List<Card> cards, List<Suit> possibleSuits) {
    Suit suit = cards.first.suit;
    if (cards.any((card) => card.suit != suit)) {
      return false;
    }
    if (set.isEmpty) {
      if (cards.last.faceValue == 1 &&
          possibleSuits.contains(cards.last.suit)) {
        possibleSuits.remove(cards.last.suit);
        return true;
      }
      return false;
    } else {
      int lastNumber = set.last.faceValue;
      Suit lastSuit = set.last.suit;
      if (lastSuit == cards.last.suit &&
          lastNumber + 1 == cards.last.faceValue) {
        return true;
      }
    }
    return false;
  }
}
