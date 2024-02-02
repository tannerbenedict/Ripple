import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:flutter/foundation.dart';

typedef FirebaseID = String;

enum GameType {
  solitaire,
  ginRummy,
  hearts,
  scum,
  cheat;

  String get screenName {
    switch (this) {
      case GameType.solitaire:
        return "Solitaire";
      case GameType.ginRummy:
        return "Gin Rummy";
      case GameType.hearts:
        return "Hearts";
      case GameType.scum:
        return "Scum";
      case GameType.cheat:
        return "Cheat";
    }
  }

  int get requiredPlayerCount {
    switch (this) {
      case GameType.solitaire:
        return 1;
      case GameType.ginRummy:
        return 2;
      case GameType.hearts:
        return 4;
      case GameType.scum:
        return 6;
      case GameType.cheat:
        return 8;
    }
  }

  @override
  String toString() => name;

  String toJson() => name;
}

enum GameStatus {
  cancelled,
  pending,
  inLobby,
  playing,
  roundEnded,
  finished;

  String toJson() => name;
}

enum UpdateType {
  notPlaying,
  replaying,
  newPlayer,
  updateHost;

  String toJson() => name;
}

enum GameMode {
  solo,
  online;

  String toJson() => name;
}

// Abstract class that all game state database models should inherit from.
abstract class GameModel {
  List<User> get players;
  List<User> get playersNotPlaying;
  List<User> get playersPlaying;
  String get lobbyCode;
  GameStatus get gameStatus;
  User get host;
  GameType get gameType;
  Map<FirebaseID, List<Card>> get playerHands;

  @mustCallSuper
  bool canStartGame(User player) =>
      player == host && gameStatus == GameStatus.inLobby;

  static List<Card> generateDeck({Random? rng}) {
    var allCards = <Card>[];

    for (final suit in Suit.values) {
      if (suit != Suit.redJoker && suit != Suit.blackJoker) {
        for (int i = 1; i <= 13; i++) {
          allCards.add(Card(faceValue: i, suit: suit));
        }
      }
    }
    allCards.shuffle(rng);

    return allCards;
  }
}

abstract class GameState<T extends GameModel> {
  T get game;
}

extension OtherPlayersInOrder on List<User> {
  List<User> otherPlayersInOrder(String currentPlayerId) {
    final indexOfCurrent = indexWhere((e) => e.firebaseId == currentPlayerId);
    final otherPlayersInOrder = <User>[];

    // Loop around the array until we get back to the current player.
    for (var i = (indexOfCurrent + 1) % length;
        i != indexOfCurrent;
        i = (i + 1) % length) {
      otherPlayersInOrder.add(this[i]);
    }

    return otherPlayersInOrder;
  }
}
