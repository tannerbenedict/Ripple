import 'dart:core';
import 'package:ripple/models/database_models/card.dart';

class HeartsLogic {
  static final _queenOfSpades = Card(faceValue: 12, suit: Suit.spades);
  static final _twoOfClubs = Card(faceValue: 2, suit: Suit.clubs);

  static Card getCardToPlay(
      List<Card> hand, List<Card> cardsPlayed, bool heartsBroken) {
    if (hand.any((card) => card.sameCard(_twoOfClubs))) {
      return hand.where((card) => card.sameCard(_twoOfClubs)).first;
    }
    List<Card> possibleCards = getPossibleCardsToPlay(
        hand, cardsPlayed.isEmpty ? null : cardsPlayed[0], heartsBroken);

    if (possibleCards.length == 1) {
      return possibleCards[0];
    }

    Card lowestCard = possibleCards[0];
    int lowestValue = possibleCards[0].getTrickRankingOrder();
    for (int i = 0; i < possibleCards.length; i++) {
      if (possibleCards[i].getTrickRankingOrder() < lowestValue) {
        lowestValue = possibleCards[i].getTrickRankingOrder();
        lowestCard = possibleCards[i];
      }
    }

    // if the player starts, it chooses to play the lowest card it has
    if (cardsPlayed.isEmpty) {
      return lowestCard;
    }

    // player could win the trick, so play the lowest card to try not to
    if (possibleCards[0].suit == cardsPlayed[0].suit) {
      return lowestCard;
    }

    // will not win the trick should play with following priority:
    // q of spades, highest heart, highest other card
    if (possibleCards.any((card) => card.sameCard(_queenOfSpades))) {
      return possibleCards.where((card) => card.sameCard(_queenOfSpades)).first;
    }

    List<Card> hearts = [];
    List<Card> cardsToCheck = [];
    for (var card in possibleCards) {
      if (card.suit == Suit.hearts) {
        hearts.add(card);
      }
    }

    if (hearts.isNotEmpty) {
      cardsToCheck = hearts;
    } else {
      cardsToCheck = possibleCards;
    }

    Card highestCard = cardsToCheck[0];
    int highestValue = cardsToCheck[0].getTrickRankingOrder();
    for (int i = 0; i < cardsToCheck.length; i++) {
      if (cardsToCheck[i].getTrickRankingOrder() > highestValue) {
        highestValue = cardsToCheck[i].getTrickRankingOrder();
        highestCard = cardsToCheck[i];
      }
    }

    return highestCard;
  }

  static int getStartingPlayer(
      List<Card> playerHand, List<List<Card>> botsHands) {
    for (int i = 0; i < botsHands.length; i++) {
      for (var card in botsHands[i]) {
        if (card.faceValue == 2 && card.suit == Suit.clubs) {
          return i + 1;
        }
      }
    }

    return 0;
  }

  static List<int> getPlayOrder(int startingPlayer, List<int> order) {
    switch (startingPlayer) {
      case 0:
        order = [0, 1, 2, 3];
        break;
      case 1:
        order = [1, 2, 3, 0];
        break;
      case 2:
        order = [2, 3, 0, 1];
        break;
      case 3:
        order = [3, 0, 1, 2];
        break;
    }
    return order;
  }

  static int getPoints(List<Card> cards) {
    int score = 0;
    for (var card in cards) {
      if (card.suit == Suit.hearts) {
        score++;
      }
      if (card.sameCard(_queenOfSpades)) {
        score += 13;
      }
    }

    return score;
  }

  static int getWinnerOfTrick(List<Card> cards) {
    Suit suitLed = cards[0].suit;
    int bestCard = cards[0].getTrickRankingOrder();
    int bestCardPlayerPosition = 0;

    for (int i = 0; i < cards.length; i++) {
      if (cards[i].suit == suitLed) {
        if (cards[i].getTrickRankingOrder() > bestCard) {
          bestCard = cards[i].getTrickRankingOrder();
          bestCardPlayerPosition = i;
        }
      }
    }

    return bestCardPlayerPosition;
  }

  static List<Card> getPossibleCardsToPlay(
      List<Card> hand, Card? cardLed, bool heartsBroken) {
    Suit? suitLed = cardLed?.suit;
    bool allHearts = true;
    List<Card> nonHearts = [];
    for (var card in hand) {
      if (card.suit != Suit.hearts) {
        nonHearts.add(card);
        allHearts = false;
      }
    }

    if (allHearts) {
      return hand;
    }

    List<Card> cardsMatchingSuitLed = [];
    for (var card in hand) {
      if (card.suit == suitLed) {
        cardsMatchingSuitLed.add(card);
      }
    }

    if (cardsMatchingSuitLed.isNotEmpty) {
      return cardsMatchingSuitLed;
    }

    // at this point player does not have all hearts or matching suit

    // this player is starting the trick
    if (cardLed == null) {
      if (heartsBroken) {
        return hand;
      } else {
        return nonHearts;
      }
    }

    // first trick so they cannot play a heart/queen unless they have to
    if (cardLed.sameCard(_twoOfClubs)) {
      if (nonHearts.length == 1 && nonHearts[0].sameCard(_queenOfSpades)) {
        return [nonHearts[0]];
      } else {
        nonHearts.removeWhere((card) => card.sameCard(_queenOfSpades));
        return nonHearts;
      }
    }

    return hand;
  }

  static void shuffleAndDealCards(
      List<Card> playerHand, List<List<Card>> botsHands) {
    List<Card> allCards = [];

    for (final suit in Suit.values) {
      if (suit != Suit.redJoker && suit != Suit.blackJoker) {
        for (int i = 1; i <= 13; i++) {
          allCards.add(Card(faceValue: i, suit: suit));
        }
      }
    }

    allCards.shuffle();
    playerHand.addAll(allCards.getRange(0, 13));
    botsHands[0].addAll(allCards.getRange(13, 26));
    botsHands[1].addAll(allCards.getRange(26, 39));
    botsHands[2].addAll(allCards.getRange(39, 52));
  }
}
