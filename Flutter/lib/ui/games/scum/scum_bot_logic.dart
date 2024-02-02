import 'dart:core';
import 'dart:math';
import 'package:ripple/models/database_models/card.dart';

class ScumLogic {
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

    allCards.add(Card(faceValue: 0, suit: Suit.blackJoker));
    allCards.add(Card(faceValue: 0, suit: Suit.redJoker));

    allCards.shuffle();
    playerHand.addAll(allCards.getRange(0, 9));
    botsHands[0].addAll(allCards.getRange(9, 18));
    botsHands[1].addAll(allCards.getRange(18, 27));
    botsHands[2].addAll(allCards.getRange(27, 36));
    botsHands[3].addAll(allCards.getRange(36, 45));
    botsHands[4].addAll(allCards.getRange(45, 54));
  }

  static int randomStartingPlayer() {
    Random random = Random();
    return random.nextInt(6);
  }

  static List<Card> getCardsToPlay(
      List<Card> hand, List<List<Card>> cardsPlayed) {
    List<List<Card>> possibleCards = getPossibleCardsToPlay(hand, cardsPlayed);

    if (possibleCards.isEmpty) {
      return [];
    }

    int lowestTrickRankOrder =
        getFaceValueCard(possibleCards[0]).getTrickRankingOrder();
    List<Card> cardsToPlay = possibleCards[0];

    for (var cards in possibleCards) {
      int trickRankOrder =
          getFaceValueCard(possibleCards[0]).getTrickRankingOrder();

      if (trickRankOrder < lowestTrickRankOrder) {
        lowestTrickRankOrder = trickRankOrder;
        cardsToPlay = cards;
      }
    }

    return cardsToPlay;
  }

  static List<int> getPlayOrder(int startingPlayer, List<int> order) {
    switch (startingPlayer) {
      case 0:
        order = [0, 1, 2, 3, 4, 5];
        break;
      case 1:
        order = [1, 2, 3, 4, 5, 0];
        break;
      case 2:
        order = [2, 3, 4, 5, 0, 1];
        break;
      case 3:
        order = [3, 4, 5, 0, 1, 2];
        break;
      case 4:
        order = [4, 5, 0, 1, 2, 3];
        break;
      case 5:
        order = [5, 0, 1, 2, 3, 4];
        break;
    }
    return order;
  }

  static Card getFaceValueCard(List<Card> cards) {
    Card faceValueCard = Card(faceValue: 1, suit: Suit.spades);

    for (var card in cards) {
      if (card.suit != Suit.blackJoker && card.suit != Suit.redJoker) {
        faceValueCard = card;
      }
    }

    return faceValueCard;
  }

  static int calculateScore(int i) {
    switch (i) {
      case 0:
        return 2;
      case 1:
        return 1;
      case 2:
        return 0;
      case 3:
        return 0;
      case 4:
        return -1;
      case 5:
        return -2;
    }
    return 0;
  }

  static int getWinnerOfTrick(List<List<Card>> cards) {
    int bestCard = getFaceValueCard(cards[0]).getTrickRankingOrder();
    int bestCardPlayerPosition = 0;

    for (int i = 0; i < cards.length; i++) {
      Card faceValueCard = getFaceValueCard(cards[i]);

      if (faceValueCard.getTrickRankingOrder() > bestCard) {
        bestCard = faceValueCard.getTrickRankingOrder();
        bestCardPlayerPosition = i;
      }
    }

    return bestCardPlayerPosition % 6;
  }

  static List<List<Card>> getPossibleCardsToPlay(
      List<Card> hand, List<List<Card>> cardsPlayed) {
    List<List<Card>> groupByValue = [];

    for (int i = 0; i < 14; i++) {
      groupByValue.add([]);
    }

    int bestTrickRank = 0;

    for (var cards in cardsPlayed) {
      var trickRank = getFaceValueCard(cards).getTrickRankingOrder();

      if (trickRank > bestTrickRank) {
        bestTrickRank = trickRank;
      }
    }

    if (bestTrickRank == 100) {
      return [];
    }

    // group by face value
    for (var card in hand) {
      if (card.suit == Suit.blackJoker || card.suit == Suit.redJoker) {
        groupByValue[0].add(card);
      } else {
        groupByValue[card.faceValue].add(card);
      }
    }

    int numLed = cardsPlayed.isEmpty ? 0 : cardsPlayed[0].length;
    List<Card> jokers = groupByValue[0];

    List<List<Card>> possibleCards = [];

    // player starting trick
    if (numLed == 0) {
      for (int i = 1; i < 14; i++) {
        List<Card> group = groupByValue[i];

        if (group.isNotEmpty) {
          for (var joker in jokers) {
            group.add(joker);
          }

          while (group.length > 4) {
            group.removeAt(group.length - 1);
          }

          var trickRank = getFaceValueCard(group).getTrickRankingOrder();

          if (trickRank > bestTrickRank) {
            possibleCards.add(group);
          }
        }
      }

      if (jokers.isNotEmpty) {
        possibleCards.add(jokers);
      }
    }

    // player not starting trick
    else {
      for (int i = 1; i < 14; i++) {
        List<Card> group = groupByValue[i];

        if (group.isNotEmpty) {
          for (var joker in jokers) {
            group.add(joker);
          }

          while (group.length > numLed) {
            group.removeAt(group.length - 1);
          }

          if (group.length == numLed) {
            var trickRank = getFaceValueCard(group).getTrickRankingOrder();

            if (trickRank > bestTrickRank) {
              possibleCards.add(group);
            }
          }
        }
      }

      if (jokers.length == numLed) {
        possibleCards.add(jokers);
      }

      if (jokers.length == 2 && numLed == 1) {
        List<Card> oneJoker = [];
        oneJoker.add(jokers[0]);
        possibleCards.add(oneJoker);
      }
    }

    return possibleCards;
  }

  static bool canDiscardCards(
      List<Card> cardsToDiscard, List<List<Card>> cardsPlayed) {
    if (cardsPlayed.isEmpty || cardsPlayed.last.isEmpty) {
      var nonJokers = cardsToDiscard
          .where((element) => !(element.suit == Suit.blackJoker ||
              element.suit == Suit.redJoker))
          .toList();
      var firstCard = nonJokers.firstOrNull;
      return nonJokers.every((card) => card.faceValue == firstCard!.faceValue);
    }

    var trickRankDiscarded =
        getFaceValueCard(cardsPlayed.last).getTrickRankingOrder();
    var trickRankTryingToDiscard =
        getFaceValueCard(cardsToDiscard).getTrickRankingOrder();

    if (trickRankTryingToDiscard > trickRankDiscarded) {
      bool allCardsSameValue = true;
      var nonJokers = cardsToDiscard
          .where((element) => !(element.suit == Suit.blackJoker ||
              element.suit == Suit.redJoker))
          .toList();
      var firstCard = nonJokers.isEmpty ? null : nonJokers[0];
      for (var card in nonJokers) {
        if (card.faceValue != firstCard!.faceValue) {
          allCardsSameValue = false;
          break;
        }
      }

      return allCardsSameValue &&
          cardsPlayed.last.length == cardsToDiscard.length;
    }

    return false;
  }
}
