import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:flutter/foundation.dart';

typedef FirebaseID = String;

enum GameType {
  twoPlayer,
  ;

  String get screenName {
    switch (this) {
      case GameType.twoPlayer:
        return "Two Player";
    }
  }

  int get requiredPlayerCount {
    switch (this) {
      case GameType.twoPlayer:
        return 1;
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

    for (int i = 0; i < 18; i++) {
      allCards.add(Card(faceValue: 0, isFlipped: false));
    }
    for (int i = 0; i < 12; i++) {
      for (int j = 1; j < 13; j++) {
        allCards.add(Card(faceValue: j, isFlipped: false));
      }
        allCards.shuffle(rng);
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
