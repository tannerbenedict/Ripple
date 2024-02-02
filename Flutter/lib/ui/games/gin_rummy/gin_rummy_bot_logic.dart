import 'dart:collection';
import 'dart:math';
import 'dart:core';

import 'package:ripple/models/database_models/card.dart';

class GinRummyLogic {
  static bool takeDiscard(
      List<Card> discardPile, List<Card> botHand, List<Card> botDeadwood) {
    int oldDeadwoodCalc = calculateDeadwood(botDeadwood);

    List<Card> botHandPlusNewCard = [...botHand]; // deep copy
    botHandPlusNewCard.add(discardPile.last);

    List<List<Card>> newMatched = getMatched(botHandPlusNewCard);

    List<Card> newDeadwood = getDeadwood(botHandPlusNewCard, newMatched);
    if (newDeadwood.isEmpty) {
      return true;
    }

    newDeadwood.sort(Card.sortByValue);
    newDeadwood.removeAt(newDeadwood.length - 1);
    int newDeadwoodCalc = calculateDeadwood(newDeadwood);

    if (newDeadwoodCalc < oldDeadwoodCalc) {
      return true;
    }

    return false;
  }

  static List<List<Card>> getMatched(List<Card> botHand) {
    List<List<Card>> sets = getSets(botHand);
    List<List<Card>> runs = getRuns(botHand);

    return removeOverlapSetsAndRuns(sets, runs, botHand);
  }

  static List<List<Card>> removeOverlapSetsAndRuns(
      List<List<Card>> sets, List<List<Card>> runs, List<Card> botHand) {
    // combine sets and runs
    for (int i = 0; i < runs.length; i++) {
      sets.add(runs[i]);
    }

    if (sets.isEmpty) {
      return [];
    }

    List<List<int>> overlap = determineOverlap(sets);

    List<List<Card>> finalMatched = [];
    int highestMatchedSoFar = 0;

    for (int i = 0; i < pow(2, overlap.length); i++) {
      List<bool> includeInOutput = List<bool>.filled(overlap.length, false);

      for (int j = 0; j < overlap.length; j++) {
        includeInOutput[j] = ((i >> j) % 2) != 0;
      }

      bool valid = validCombination(overlap, includeInOutput);

      if (valid) {
        List<List<Card>> tempMatched = [];
        for (int j = 0; j < includeInOutput.length; j++) {
          if (includeInOutput[j]) {
            tempMatched.add(sets[j]);
          }
        }

        int cardsAddTo = addUpCardVals(tempMatched);

        if (cardsAddTo > highestMatchedSoFar) {
          finalMatched = tempMatched;
          highestMatchedSoFar = cardsAddTo;
        }
      }
    }

    return finalMatched;
  }

  static int addUpCardVals(List<List<Card>> tempMatched) {
    int sum = 0;

    for (var match in tempMatched) {
      for (var card in match) {
        sum += card.getCardValue();
      }
    }
    return sum;
  }

  static bool validCombination(
      List<List<int>> overlap, List<bool> includeInOutput) {
    for (int i = 0; i < includeInOutput.length; i++) {
      if (includeInOutput[i]) {
        List<int> overlapForThisSet = overlap[i];
        for (var overlapSets in overlapForThisSet) {
          if (includeInOutput[overlapSets]) {
            return false;
          }
        }
      }
    }

    return true;
  }

  static List<List<int>> determineOverlap(List<List<Card>> sets) {
    List<List<int>> overlap = List<List<int>>.empty(growable: true);
    for (int i = 0; i < sets.length; i++) {
      overlap.add([]);
    }

    for (int i = 0; i < sets.length; i++) {
      List<Card> set = sets[i];

      for (int j = i + 1; j < sets.length; j++) {
        List<Card> run = sets[j];
        Card overlappedCard = Card(faceValue: 0, suit: Suit.spades);
        bool setsOverlap = false;

        for (var card in set) {
          if (run.any((element) => element == card)) {
            setsOverlap = true;
            overlappedCard = card;
            break;
          }
        }

        if (setsOverlap) {
          if (set.length == 4) {
            if ((run.first == overlappedCard || run.last == overlappedCard) &&
                run.length >= 4) {
              run.remove(overlappedCard);
            } else {
              set.remove(overlappedCard);
            }
          } else {
            if ((run.first == overlappedCard || run.last == overlappedCard) &&
                run.length >= 4) {
              run.remove(overlappedCard);
            } else {
              overlap[i].add(j);
              overlap[j].add(i);
            }
          }
        }
      }
    }

    return overlap;
  }

  static int numOfCardsInListOfList(List<List<Card>> matchedCards) {
    int numCards = 0;
    for (var match in matchedCards) {
      numCards += match.length;
    }

    return numCards;
  }

  static List<List<Card>> getSets(List<Card> botHand) {
    botHand.sort(Card.sortByValue);
    List<List<Card>> sets = [];

    int index = 0;
    while (index < botHand.length) {
      List<Card> currentMatched = [];
      currentMatched.add(botHand[index]);
      int value = botHand[index].faceValue;

      int nextIndex = index + 1;
      for (nextIndex; nextIndex < botHand.length; nextIndex++) {
        int otherValue = botHand[nextIndex].faceValue;
        if (otherValue == value) {
          currentMatched.add(botHand[nextIndex]);
        } else {
          break;
        }
      }

      if (currentMatched.length >= 3) {
        sets.add(currentMatched);
      }

      index = nextIndex;
    }

    return sets;
  }

  static List<List<Card>> getRuns(List<Card> botHand) {
    botHand.sort(Card.sortBySuit);
    List<List<Card>> runs = [];

    int index = 0;
    while (index < botHand.length) {
      List<Card> currentMatched = [];
      Card card = botHand[index];
      currentMatched.add(botHand[index]);

      int value = card.faceValue;
      Suit suit = card.suit;

      int nextIndex = index + 1;
      for (nextIndex; nextIndex < botHand.length; nextIndex++) {
        Card otherCard = botHand[nextIndex];
        int otherValue = otherCard.faceValue;
        Suit otherSuit = otherCard.suit;

        if (otherSuit == suit) {
          if (otherValue == value + 1) {
            value = otherValue;
            currentMatched.add(botHand[nextIndex]);
          } else {
            break;
          }
        } else {
          break;
        }
      }

      if (currentMatched.length >= 3) {
        runs.add(currentMatched);
      }

      index = nextIndex;
    }

    return runs;
  }

  static List<List<Card>> getMiniRuns(List<Card> playerDeadwood) {
    playerDeadwood.sort(Card.sortBySuit);
    List<List<Card>> runs = [];

    int index = 0;
    while (index < playerDeadwood.length) {
      List<Card> currentMatched = [];
      Card card = playerDeadwood[index];
      currentMatched.add(playerDeadwood[index]);

      int value = card.faceValue;
      Suit suit = card.suit;

      int nextIndex = index + 1;
      for (nextIndex; nextIndex < playerDeadwood.length; nextIndex++) {
        Card otherCard = playerDeadwood[nextIndex];
        int otherValue = otherCard.faceValue;
        Suit otherSuit = otherCard.suit;

        if (otherSuit == suit) {
          if (otherValue == value + 1) {
            value = otherValue;
            currentMatched.add(playerDeadwood[nextIndex]);
          } else {
            break;
          }
        } else {
          break;
        }
      }

      if (currentMatched.isNotEmpty) {
        runs.add(currentMatched);
      }

      index = nextIndex;
    }

    return runs;
  }

  static bool isSet(List<Card> groups) {
    return (groups[0].faceValue == groups[1].faceValue);
  }

  static List<List<Card>> addAfterKnock(
      List<Card> deadwood, List<List<Card>> matched) {
    List<List<Card>> miniRuns = GinRummyLogic.getMiniRuns(deadwood);
    List<List<Card>> newMatched = [];
    for (var match in matched) {
      List<Card> newMatch = match;
      if (!GinRummyLogic.isSet(match)) {
        for (var run in miniRuns) {
          if (run.first.suit == newMatch.first.suit) {
            newMatch = GinRummyLogic.addToRun(newMatch, run, deadwood);
          }
        }
        newMatched.add(newMatch);
      }
    }
    for (var match in matched) {
      if (GinRummyLogic.isSet(match)) {
        List<Card> newSet = match;
        for (var card in deadwood) {
          newSet = GinRummyLogic.addToSet(match, card, deadwood);
        }
        newMatched.add(newSet);
      }
    }
    return newMatched;
  }

  static List<Card> addToRun(
      List<Card> botRun, List<Card> miniRun, List<Card> dead) {
    if (miniRun.length == 1) {
      if (botRun[0].faceValue - 1 == miniRun[0].faceValue) {
        dead.remove(miniRun[0]);
        return miniRun + botRun;
      } else if (botRun[botRun.length - 1].faceValue + 1 ==
          miniRun[0].faceValue) {
        dead.remove(miniRun[0]);
        return botRun + miniRun;
      }
    } else if (botRun[0].faceValue - 1 == miniRun[1].faceValue) {
      dead.remove(miniRun[0]);
      dead.remove(miniRun[1]);
      return miniRun + botRun;
    } else if (botRun[botRun.length - 1].faceValue + 1 ==
        miniRun[0].faceValue) {
      dead.remove(miniRun[0]);
      dead.remove(miniRun[1]);
      return botRun + miniRun;
    }
    return botRun;
  }

  static List<Card> addToSet(List<Card> botSet, Card card, List<Card> dead) {
    if (botSet[0].faceValue == card.faceValue) {
      dead.remove(card);
      botSet.add(card);
    }
    return botSet;
  }

  static List<Card> getDeadwood(List<Card> botHand, List<List<Card>> matched) {
    List<Card> deadwood = [];

    for (var card in botHand) {
      bool cardInDeadwood = true;
      for (var match in matched) {
        for (var matchedCard in match) {
          if (matchedCard == card) {
            cardInDeadwood = false;
          }
        }
      }
      if (cardInDeadwood) {
        deadwood.add(card);
      }
    }

    return deadwood;
  }

  static int calculateDeadwood(List<Card> deadwood) {
    if (deadwood.isEmpty) {
      return 0;
    }
    return deadwood
        .map((e) => e.getCardValue())
        .reduce((value, element) => value + element);
  }

  static int getDeadMax(List<Card> deadwood) {
    if (deadwood.isEmpty) {
      return 0;
    }
    return deadwood.map((e) => e.getCardValue()).reduce(max);
  }

  static Card getCardToDiscard(List<List<Card>> matched, List<Card> deadwood) {
    if (deadwood.length == 1) {
      return deadwood[0];
    }

    if (deadwood.isEmpty) {
      for (var match in matched) {
        if (match.length >= 4) {
          return match.removeAt(0);
        }
      }
    }

    deadwood.sort(Card.sortByValue);
    return deadwood[deadwood.length - 1];
  }

  static void shuffleAndDealCards(Queue<Card> drawPile, Queue<Card> discardPile,
      List<Card> playerHand, List<Card> botHand) {
    List<Card> allCards = [];

    for (final suit in Suit.values) {
      if (suit != Suit.redJoker && suit != Suit.blackJoker) {
        for (var i = 1; i < 14; i++) {
          allCards.add(Card(faceValue: i, suit: suit));
        }
      }
    }

    allCards.shuffle();
    playerHand.addAll(allCards.getRange(0, 10));
    botHand.addAll(allCards.getRange(10, 20));
    drawPile.addAll(allCards.getRange(21, allCards.length));
    discardPile.add(allCards[20]);
  }
}
