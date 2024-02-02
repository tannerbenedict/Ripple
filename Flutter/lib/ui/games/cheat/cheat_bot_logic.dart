import 'dart:core';
import 'dart:math';
import 'package:ripple/models/database_models/card.dart';
import 'package:trotter/trotter.dart';

class CheatLogic {
  static List<Card> getCardsToPlay(int faceValueToPlay, List<Card> hand) {
    var faceValueCards =
        hand.where((element) => element.faceValue == faceValueToPlay);

    if (faceValueCards.isEmpty) {
      List<List<Card>> groupByValue = [];

      for (int i = 0; i < 13; i++) {
        groupByValue.add([]);
      }

      // group by face value
      for (var card in hand) {
        groupByValue[card.faceValue - 1].add(card);
      }

      List<Card> cardsToPlay = [];
      int lowestNumCards = 0;

      // find first non empty set
      for (var cards in groupByValue) {
        if (cards.isNotEmpty) {
          cardsToPlay = cards;
          lowestNumCards = cards.length;
          break;
        }
      }

      // find set with lowest number of cards
      for (var cards in groupByValue) {
        if (cards.isNotEmpty) {
          if (cards.length < lowestNumCards) {
            lowestNumCards = cards.length;
            cardsToPlay = cards;
          }
        }
      }
      return cardsToPlay;
    }
    var listfVC = faceValueCards.toList();
    if (listfVC.length > 2) {
      return listfVC;
    } else {
      final Random rand = Random();
      double randomNumber = rand.nextDouble();

      if (randomNumber < 0.4) {
        var lying =
            hand.where((element) => element.faceValue != faceValueToPlay);
        var toAdd = lying.toList();
        listfVC.add(toAdd[0]);
      }
      return listfVC;
    }
  }

  static List<int> getPlayOrder(int startingPlayer, List<int> order) {
    List<int> playOrder = [];
    for (int i = startingPlayer; i < startingPlayer + 8; i++) {
      playOrder.add(i % 8);
    }

    return playOrder;
  }

  static bool getIfBotCallsCheat(int previousFacePlayed, int previousNumPlayed,
      List<Card> cardsPlayed, List<Card> botHand, List<Card> hand) {
    int numRemainingCards = 104 - hand.length - cardsPlayed.length;
    int numFacePossible = 8 -
        hand.where((element) => element.faceValue == previousFacePlayed).length;
    int numPlayerCards = botHand.length;

    if (previousNumPlayed == 0) {
      return false;
    }

    if (previousNumPlayed > numFacePossible) {
      return true;
    }
    if (previousNumPlayed ~/ numFacePossible > .5) {
      return true;
    }
    double base = (numFacePossible / (numRemainingCards + previousNumPlayed));
    double base2 = 1 - base;

    var nCr = factorial(numPlayerCards + previousNumPlayed) ~/
        (factorial(previousNumPlayed) *
            factorial(
                (numPlayerCards + previousNumPlayed) - previousNumPlayed));
    var pK = pow(base, previousNumPlayed);
    var comb = pow(base2, numPlayerCards);

    var prob = nCr.toDouble() * pK * comb;

    // var first = List.generate(
    //     numRemainingCards - numFacePossible, (i) => String.fromCharCode(i));
    // var second = List.generate(numFacePossible, (i) => String.fromCharCode(i));
    // var third = List.generate(numRemainingCards, (i) => String.fromCharCode(i));

    // var prob = Combinations(numPlayerCards - previousNumPlayed, first).length *
    //     Combinations(previousNumPlayed, second).length /
    //     Combinations(numPlayerCards, third).length;
    return prob < 0.20;
  }

  static void shuffleAndDealCards(
      List<Card> playerHand, List<List<Card>> botsHands) {
    List<Card> allCards = [];

    for (final suit in Suit.values) {
      if (suit != Suit.redJoker && suit != Suit.blackJoker) {
        for (var i = 1; i < 14; i++) {
          allCards.add(Card(faceValue: i, suit: suit));
          allCards.add(Card(faceValue: i, suit: suit));
        }
      }
    }

    allCards.shuffle();
    playerHand.addAll(allCards.getRange(0, 13));
    botsHands[0].addAll(allCards.getRange(13, 26));
    botsHands[1].addAll(allCards.getRange(26, 39));
    botsHands[2].addAll(allCards.getRange(39, 52));
    botsHands[3].addAll(allCards.getRange(52, 65));
    botsHands[4].addAll(allCards.getRange(65, 78));
    botsHands[5].addAll(allCards.getRange(78, 91));
    botsHands[6].addAll(allCards.getRange(91, 104));
  }
}
