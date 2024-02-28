import 'dart:collection';
import 'dart:math';
import 'dart:core';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/two_player/player_hand.dart';

class RippleLogic {
  static void shuffleAndDealCards(
      Queue<Card> drawPile, List<Card> playerHand, List<List<Card>> botsHands) {
    List<Card> allCards = [];

    for (int i = 0; i < 18; i++) {
      allCards.add(Card(faceValue: 0, isFlipped: false));
    }
    for (int i = 1; i <= 13; i++) {
      for (int j = 0; j < 12; j++) {
        allCards.add(Card(faceValue: i, isFlipped: false));
      }
    }
    allCards.shuffle();

    playerHand.addAll(allCards.getRange(0, 10));
    int index = 10;
    for (int i = 0; i < botsHands.length; i++) {
      botsHands[i].addAll(allCards.getRange(index, index + 10));
      index += 10;
    }
    drawPile.addAll(allCards.getRange(index, allCards.length));
  }

  static bool takeDiscard(List<Card> discardPile, List<Card> botHand) {
    if (discardPile.isEmpty) {
      return false;
    }
    var discarded = discardPile.last.getCardValue();
    if (botHand[0].isFlipped &&
        botHand[0].getCardValue() == discarded &&
        (!botHand[5].isFlipped ||
            (!botHand[1].isFlipped && !botHand[6].isFlipped))) {
      return true;
    }
    if (botHand[5].isFlipped &&
        botHand[5].getCardValue() == discarded &&
        (!botHand[0].isFlipped ||
            (!botHand[1].isFlipped && !botHand[6].isFlipped))) {
      return true;
    }
    if (botHand[1].isFlipped &&
        botHand[1].getCardValue() == discarded &&
        (!botHand[6].isFlipped ||
            (!botHand[0].isFlipped && !botHand[5].isFlipped) ||
            (!botHand[2].isFlipped && !botHand[7].isFlipped))) {
      return true;
    }
    if (botHand[6].isFlipped &&
        botHand[6].getCardValue() == discarded &&
        (!botHand[1].isFlipped ||
            (!botHand[0].isFlipped && !botHand[5].isFlipped) ||
            (!botHand[2].isFlipped && !botHand[7].isFlipped))) {
      return true;
    }
    if (botHand[2].isFlipped &&
        botHand[2].getCardValue() == discarded &&
        (!botHand[7].isFlipped ||
            (!botHand[1].isFlipped && !botHand[6].isFlipped) ||
            (!botHand[3].isFlipped && !botHand[8].isFlipped))) {
      return true;
    }
    if (botHand[7].isFlipped &&
        botHand[7].getCardValue() == discarded &&
        (!botHand[2].isFlipped ||
            (!botHand[1].isFlipped && !botHand[6].isFlipped) ||
            (!botHand[3].isFlipped && !botHand[8].isFlipped))) {
      return true;
    }
    if (botHand[3].isFlipped &&
        botHand[3].getCardValue() == discarded &&
        (!botHand[8].isFlipped ||
            (!botHand[2].isFlipped && !botHand[7].isFlipped) ||
            (!botHand[4].isFlipped && !botHand[9].isFlipped))) {
      return true;
    }
    if (botHand[8].isFlipped &&
        botHand[8].getCardValue() == discarded &&
        (!botHand[3].isFlipped ||
            (!botHand[2].isFlipped && !botHand[7].isFlipped) ||
            (!botHand[4].isFlipped && !botHand[9].isFlipped))) {
      return true;
    }
    if (botHand[4].isFlipped &&
        botHand[4].getCardValue() == discarded &&
        (!botHand[9].isFlipped ||
            (!botHand[3].isFlipped && !botHand[8].isFlipped))) {
      return true;
    }
    if (botHand[9].isFlipped &&
        botHand[9].getCardValue() == discarded &&
        (!botHand[4].isFlipped ||
            (!botHand[3].isFlipped && !botHand[8].isFlipped))) {
      return true;
    }
    if (discarded <= 3 &&
        ((!botHand[0].isFlipped && !botHand[5].isFlipped) ||
            (!botHand[1].isFlipped && !botHand[6].isFlipped) ||
            (!botHand[2].isFlipped && !botHand[7].isFlipped) ||
            (!botHand[3].isFlipped && !botHand[8].isFlipped) ||
            (!botHand[4].isFlipped && !botHand[9].isFlipped))) {
      return true;
    }
    return false;
  }

  static int playIndex(List<Card> botHand, Card drawnCard) {
    var discarded = drawnCard.getCardValue();
    if (botHand[0].isFlipped && botHand[0].getCardValue() == discarded) {
      if (!botHand[5].isFlipped) {
        return 5;
      }
      if (!botHand[1].isFlipped && !botHand[6].isFlipped) {
        return 1;
      }
    }
    if (botHand[5].isFlipped && botHand[5].getCardValue() == discarded) {
      if (!botHand[0].isFlipped) {
        return 0;
      }
      if (!botHand[1].isFlipped && !botHand[6].isFlipped) {
        return 1;
      }
    }
    if (botHand[1].isFlipped && botHand[1].getCardValue() == discarded) {
      if (!botHand[6].isFlipped) {
        return 6;
      }
      if (!botHand[0].isFlipped && !botHand[5].isFlipped) {
        return 0;
      }
      if (!botHand[2].isFlipped && !botHand[7].isFlipped) {
        return 2;
      }
    }
    if (botHand[6].isFlipped && botHand[6].getCardValue() == discarded) {
      if (!botHand[1].isFlipped) {
        return 1;
      }
      if (!botHand[0].isFlipped && !botHand[5].isFlipped) {
        return 0;
      }
      if (!botHand[2].isFlipped && !botHand[7].isFlipped) {
        return 2;
      }
    }
    if (botHand[2].isFlipped && botHand[2].getCardValue() == discarded) {
      if (!botHand[7].isFlipped) {
        return 7;
      }
      if (!botHand[1].isFlipped && !botHand[6].isFlipped) {
        return 1;
      }
      if (!botHand[3].isFlipped && !botHand[8].isFlipped) {
        return 3;
      }
    }
    if (botHand[7].isFlipped && botHand[7].getCardValue() == discarded) {
      if (!botHand[2].isFlipped) {
        return 2;
      }
      if (!botHand[1].isFlipped && !botHand[6].isFlipped) {
        return 1;
      }
      if (!botHand[3].isFlipped && !botHand[8].isFlipped) {
        return 3;
      }
    }
    if (botHand[3].isFlipped && botHand[3].getCardValue() == discarded) {
      if (!botHand[8].isFlipped) {
        return 8;
      }
      if (!botHand[2].isFlipped && !botHand[7].isFlipped) {
        return 2;
      }
      if (!botHand[4].isFlipped && !botHand[9].isFlipped) {
        return 4;
      }
    }
    if (botHand[8].isFlipped && botHand[8].getCardValue() == discarded) {
      if (!botHand[3].isFlipped) {
        return 3;
      }
      if (!botHand[2].isFlipped && !botHand[7].isFlipped) {
        return 2;
      }
      if (!botHand[4].isFlipped && !botHand[9].isFlipped) {
        return 4;
      }
    }
    if (botHand[4].isFlipped && botHand[4].getCardValue() == discarded) {
      if (!botHand[9].isFlipped) {
        return 9;
      }
      if (!botHand[3].isFlipped && !botHand[8].isFlipped) {
        return 3;
      }
    }
    if (botHand[9].isFlipped && botHand[9].getCardValue() == discarded) {
      if (!botHand[4].isFlipped) {
        return 4;
      }
      if (!botHand[3].isFlipped && !botHand[8].isFlipped) {
        return 3;
      }
    }
    if (!botHand[0].isFlipped && !botHand[5].isFlipped) {
      return 5;
    }
    if (!botHand[1].isFlipped && !botHand[6].isFlipped) {
      return 6;
    }
    if (!botHand[2].isFlipped && !botHand[7].isFlipped) {
      return 7;
    }
    if (!botHand[3].isFlipped && !botHand[8].isFlipped) {
      return 8;
    }
    if (!botHand[4].isFlipped && !botHand[9].isFlipped) {
      return 9;
    }
    return 10;
  }
}
