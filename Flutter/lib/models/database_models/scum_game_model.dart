import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/ui/games/scum/scum_bot_logic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scum_game_model.freezed.dart';
part 'scum_game_model.g.dart';

typedef PlayerID = String;

enum PlayerPosition {
  president,
  vicePresident,
  commoner,
  viceScum,
  scum;

  @override
  String toString() {
    switch (this) {
      case PlayerPosition.president:
        return "President";
      case PlayerPosition.vicePresident:
        return "Vice President";
      case PlayerPosition.commoner:
        return "Commoner";
      case PlayerPosition.viceScum:
        return "Vice Scum";
      case PlayerPosition.scum:
        return "Scum";
    }
  }

  static const Map<int, PlayerPosition> indexToPositionMap = {
    0: PlayerPosition.president,
    1: PlayerPosition.vicePresident,
    2: PlayerPosition.commoner,
    3: PlayerPosition.commoner,
    4: PlayerPosition.viceScum,
    5: PlayerPosition.scum,
  };
}

@freezed
class CardPlayEntry with _$CardPlayEntry {
  factory CardPlayEntry({
    required PlayerID playerID,
    required List<Card> cards,
  }) = _CardPlayEntry;

  factory CardPlayEntry.fromJson(Map<String, dynamic> json) =>
      _$CardPlayEntryFromJson(json);
}

@freezed
class ScumGameModel extends GameModel with _$ScumGameModel {
  ScumGameModel._();

  factory ScumGameModel({
    required Map<PlayerID, List<Card>> playerHands,
    required Map<PlayerID, bool> playerPassed,
    required List<CardPlayEntry> cardsPlayed,
    required List<User> turnOrder,
    required Map<PlayerID, int> playerScores,
    required String lobbyCode,
    required User? firstPlayer,
    required User? roundWinner,
    required int currentIndex,
    required List<User> players,
    required List<User> playersNotPlaying,
    required List<User> playersPlaying,
    required GameStatus gameStatus,
    required User host,
    required bool isRoundEnd,
    required bool isTrickEnd,
    required User? trickWinner,
    required List<User> finishedOrder,
    required int roundNumber,
    required Map<PlayerID, PlayerPosition> positions,
    required List<User> lastPlayed,
  }) = _ScumGameModel;

  factory ScumGameModel.fromJson(Map<String, dynamic> json) =>
      _$ScumGameModelFromJson(json);

  factory ScumGameModel.newGame(String lobbyCode, User user, Random rng) {
    return ScumGameModel(
      playerHands: {user.firebaseId: []},
      playerPassed: {user.firebaseId: false},
      cardsPlayed: [],
      turnOrder: [],
      playerScores: {user.firebaseId: 0},
      lobbyCode: lobbyCode,
      gameStatus: GameStatus.pending,
      firstPlayer: null,
      roundWinner: null,
      currentIndex: 0,
      roundNumber: 6,
      players: [user],
      playersPlaying: [user],
      playersNotPlaying: [],
      host: user,
      trickWinner: null,
      isRoundEnd: false,
      isTrickEnd: false,
      finishedOrder: [],
      lastPlayed: [],
      positions: {},
    );
  }

  ScumGameModel notPlayingAgain(User user) {
    final playersNotPlaying = [...this.playersNotPlaying, user];
    return copyWith(playersNotPlaying: playersNotPlaying);
  }

  ScumGameModel playingAgain(User user) {
    final playersPlaying = [...this.playersPlaying, user];
    return copyWith(
        playersPlaying: playersPlaying,
        gameStatus:
            playersPlaying.length == 6 ? GameStatus.inLobby : gameStatus);
  }

  @override
  GameType get gameType => GameType.scum;

  User? get currentPlayer => turnOrder[currentIndex];

  bool canDiscard(User player) =>
      currentPlayer?.firebaseId == player.firebaseId &&
      gameStatus == GameStatus.playing;

  User? get getTrickWinner {
    if (isTrickEnd) {
      return trickWinner;
    } else {
      return null;
    }
  }

  bool canPass(User player) {
    return currentPlayer?.firebaseId == player.firebaseId &&
        gameStatus == GameStatus.playing &&
        cardsPlayed.isNotEmpty;
  }

  @override
  bool canStartGame(User player) =>
      super.canStartGame(player) && playersPlaying.length == 6;
  ScumGameModel addPlayer(User user) => copyWith(
        playerHands: {...playerHands, user.firebaseId: <Card>[]},
        playerPassed: {...playerPassed, user.firebaseId: false},
        playerScores: {...playerScores, user.firebaseId: 0},
        players: [...players, user],
        playersPlaying: [...playersPlaying, user],
        gameStatus: GameStatus.inLobby,
      );

  static List<Card> generateDeck({Random? rng}) {
    var allCards = <Card>[];
    for (final suit in Suit.values) {
      if (suit != Suit.redJoker && suit != Suit.blackJoker) {
        for (int i = 1; i <= 13; i++) {
          allCards.add(Card(faceValue: i, suit: suit));
        }
      }
    }

    allCards.add(Card(faceValue: 0, suit: Suit.blackJoker));
    allCards.add(Card(faceValue: 0, suit: Suit.redJoker));

    allCards.shuffle(rng);

    return allCards;
  }

  void swapCards(List<Card> scum, List<Card> president, int numCards) {
    president.sort(Card.sortByRank);
    scum.sort(Card.sortByRank);

    var scumTrade = [...scum.reversed.take(numCards)];
    var presidentTrade = [...president.take(numCards)];

    president.addAll(scumTrade);
    scum.addAll(presidentTrade);

    president.removeWhere((element) => presidentTrade.contains(element));
    scum.removeWhere((element) => scumTrade.contains(element));

    president.sort(Card.sortByRank);
    scum.sort(Card.sortByRank);
  }

  ScumGameModel shuffleCards({Random? rng}) {
    var allCards = generateDeck(rng: rng);
    var hands = {...playerHands};

    int lowerBound = 0;
    int upperBound = 9;
    for (final hand in hands.entries) {
      hand.value.clear();
      hand.value.addAll(allCards.getRange(lowerBound, upperBound));
      lowerBound += 9;
      upperBound += 9;
      hand.value.sort(Card.sortByRank);
    }

    int index = Random().nextInt(6);
    var president = positions.entries
        .where((element) => element.value == PlayerPosition.president)
        .firstOrNull;
    if (president != null) {
      index =
          players.indexWhere((element) => element.firebaseId == president.key);

      var vicePresident = positions.entries
          .where((element) => element.value == PlayerPosition.vicePresident)
          .first
          .key;

      var viceScum = positions.entries
          .where((element) => element.value == PlayerPosition.viceScum)
          .first
          .key;

      var scum = positions.entries
          .where((element) => element.value == PlayerPosition.scum)
          .first
          .key;

      swapCards(
          hands.entries.where((element) => element.key == scum).first.value,
          hands.entries
              .where((element) => element.key == president.key)
              .first
              .value,
          2);

      swapCards(
          hands.entries.where((element) => element.key == viceScum).first.value,
          hands.entries
              .where((element) => element.key == vicePresident)
              .first
              .value,
          1);
    }

    List<User> turnOrder = [];

    for (var i = 0; i < 6; i++) {
      turnOrder.add(players[(index + i) % 6]);
    }

    return copyWith(
      playerHands: hands,
      turnOrder: turnOrder,
      firstPlayer: firstPlayer,
    );
  }

  ScumGameModel roundEnd() {
    final playerScores = {...this.playerScores};
    final finishedOrder =
        <User>{...this.finishedOrder}.union(this.players.toSet()).toList();
    List<User> players = [];

    for (var i = 0; i < finishedOrder.length; i++) {
      var tempScore = playerScores[finishedOrder[i].firebaseId]!;
      playerScores[finishedOrder[i].firebaseId] =
          tempScore + ScumLogic.calculateScore(i);
    }

    final playerHands = {...this.playerHands};
    final playerPassed = {...this.playerPassed};

    for (final player in players) {
      playerHands[player.firebaseId] = [];
      playerPassed[player.firebaseId] = false;
    }

    final positions = <PlayerID, PlayerPosition>{};

    for (var i = 0; i < finishedOrder.length; i++) {
      players.add(this
          .players
          .where((element) => element.firebaseId == finishedOrder[i].firebaseId)
          .first);
      positions[finishedOrder[i].firebaseId] =
          PlayerPosition.indexToPositionMap[i]!;
    }

    return copyWith(
      playerHands: playerHands,
      playerScores: playerScores,
      playerPassed: playerPassed,
      players: players,
      finishedOrder: [],
      currentIndex: 0,
      firstPlayer: null,
      roundNumber: roundNumber - 1,
      cardsPlayed: [],
      lastPlayed: [],
      isRoundEnd: false,
      isTrickEnd: false,
      trickWinner: null,
      gameStatus:
          roundNumber - 1 == 0 ? GameStatus.finished : GameStatus.playing,
      positions: positions,
    ).shuffleCards();
  }

  ScumGameModel pass(User user) {
    if (playerHands.values.every((value) => value.isEmpty)) {
      return roundEnd();
    }

    assert(
        lastPlayed.isNotEmpty, "Tried to pass without anything being played!");
    final lastPlayer = lastPlayed.last;
    var playerPassed = {...this.playerPassed};
    playerPassed[user.firebaseId] = true;

    final allPassed = playerPassed.entries.every((element) =>
        element.key == lastPlayer.firebaseId ||
        element.value ||
        finishedOrder.any((e) => e.firebaseId == element.key));

    if (allPassed) {
      final newFirstPlayer = lastPlayed.last;
      final index = players.indexOf(newFirstPlayer);

      final newTurnOrder = <User>[];

      for (var i = 0; i < 6; i++) {
        newTurnOrder.add(players[(index + i) % 6]);
      }

      newTurnOrder.removeWhere((element) => finishedOrder.contains(element));

      playerPassed = playerPassed.map((k, v) => MapEntry(k, false));

      return copyWith(
          currentIndex: 0,
          playerPassed: playerPassed,
          isTrickEnd: true,
          cardsPlayed: [],
          firstPlayer: newTurnOrder[0],
          lastPlayed: [],
          trickWinner: newFirstPlayer,
          turnOrder: newTurnOrder);
    } else {
      int newCurrentIndex = currentIndex + 1;

      if (currentIndex == turnOrder.length - 1) {
        newCurrentIndex = 0;
      }

      return copyWith(
        currentIndex:
            _nextValidPlayerIndex(finishedOrder, startingFrom: newCurrentIndex),
        playerPassed: playerPassed,
      );
    }
  }

  ScumGameModel discardCards(List<Card> cards, User user) {
    final cardsPlayed = [...this.cardsPlayed];
    final playerHands = {...this.playerHands};
    final positions = {...this.positions};
    final playerHand = [...playerHands[user.firebaseId]!];

    for (var card in cards) {
      assert(playerHand.contains(card));
    }

    assert(currentIndex < 6);

    playerHand.removeWhere((element) => cards.contains(element));
    playerHands[user.firebaseId] = playerHand;

    var lastPlayed = [...this.lastPlayed, user];

    var finishedOrder = [...this.finishedOrder];
    if (playerHand.isEmpty) {
      finishedOrder.add(user);
      positions[user.firebaseId] =
          PlayerPosition.indexToPositionMap[finishedOrder.length - 1]!;
    }

    if (finishedOrder.length == 5) {
      return roundEnd();
    }

    var playerPassed =
        this.playerPassed.map((key, value) => MapEntry(key, false));
    playerPassed[user.firebaseId] = false;

    return copyWith(
        currentIndex: _nextValidPlayerIndex(finishedOrder),
        cardsPlayed: cardsPlayed
          ..add(CardPlayEntry(playerID: user.firebaseId, cards: [...cards])),
        playerHands: playerHands,
        lastPlayed: lastPlayed,
        playerPassed: playerPassed,
        finishedOrder: finishedOrder,
        positions: positions,
        isTrickEnd: false);
  }

  /// Returns the index of the next valid player, starting from the current player.
  /// If [startingFrom] is provided, it will start from that index instead.
  /// If no valid player is found, an exception is thrown.
  /// A valid player is one that has not yet finished the game.
  int _nextValidPlayerIndex(List<User> finishedOrder, {int? startingFrom}) {
    startingFrom ??= (currentIndex + 1) % turnOrder.length;

    for (var i = 0; i < turnOrder.length; i++) {
      if (!finishedOrder
          .contains(turnOrder[(i + startingFrom) % turnOrder.length])) {
        return (i + startingFrom) % turnOrder.length;
      }
    }
    throw Exception(
        "No valid player index found! Typically, this means that the game is over, but this method was still called.");
  }

  ScumGameModel startGame() {
    Map<String, List<Card>> playerHands = {};
    Map<String, bool> playerPassed = {};
    Map<String, int> playerScores = {};
    for (var player in players) {
      playerHands[player.firebaseId] = [];
      playerScores[player.firebaseId] = 0;
      playerPassed[player.firebaseId] = false;
    }

    return copyWith(
        playerHands: playerHands,
        playerPassed: playerPassed,
        playerScores: playerScores,
        gameStatus: GameStatus.playing,
        roundNumber: 6,
        playersPlaying: [],
        playersNotPlaying: []);
  }
}
