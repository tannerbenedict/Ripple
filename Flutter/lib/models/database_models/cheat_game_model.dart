import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cheat_game_model.freezed.dart';
part 'cheat_game_model.g.dart';

typedef PlayerID = String;

@freezed
class CheatGameModel extends GameModel with _$CheatGameModel {
  static const numberRoundsToWin = 5;

  CheatGameModel._();

  factory CheatGameModel({
    required Map<PlayerID, List<Card>> playerHands,
    required List<Card> cardsPlayed,
    required List<User> turnOrder,
    required Map<PlayerID, int> playerScores,
    required String lobbyCode,
    required User? firstPlayer,
    required User? handWinner,
    required int currentIndex,
    required List<User> players,
    required List<User> playersNotPlaying,
    required List<User> playersPlaying,
    required GameStatus gameStatus,
    required User host,
    required User? playerWhoPlayed,
    required User? potentialWinner,
    required User? playerWhoCalledCheat,
    @Default(null) User? playerWhoGotCards,
    required bool calledCheat,
    required int numPlayedPrevious,
    required int currentFaceValue,
    required bool isRoundEnd,
  }) = _CheatGameModel;

  factory CheatGameModel.fromJson(Map<String, dynamic> json) =>
      _$CheatGameModelFromJson(json);

  factory CheatGameModel.newGame(String lobbyCode, User user, Random rng) {
    return CheatGameModel(
      playerHands: {user.firebaseId: []},
      cardsPlayed: [],
      turnOrder: [],
      playerScores: {user.firebaseId: 0},
      lobbyCode: lobbyCode,
      gameStatus: GameStatus.pending,
      firstPlayer: null,
      handWinner: null,
      currentIndex: 0,
      players: [user],
      playersPlaying: [user],
      playersNotPlaying: [],
      host: user,
      playerWhoPlayed: null,
      potentialWinner: null,
      playerWhoCalledCheat: null,
      calledCheat: false,
      numPlayedPrevious: 0,
      currentFaceValue: 1,
      isRoundEnd: false,
    );
  }

  List<Card>? get lastPlayedCards {
    if (cardsPlayed.isEmpty) {
      return null;
    }
    return cardsPlayed
        .getRange(cardsPlayed.length - numPlayedPrevious, cardsPlayed.length)
        .toList();
  }

  int get previousFaceValue {
    if (currentFaceValue == 1) {
      return 13;
    } else {
      return currentFaceValue - 1;
    }
  }

  @override
  GameType get gameType => GameType.cheat;

  User? get currentPlayer => turnOrder[currentIndex];

  List<User> otherPlayersInOrder(User player) {
    final otherPlayers = <User>[];
    final playerIndex = turnOrder.indexOf(player);

    for (var i = 1;
        turnOrder[(i + playerIndex) % turnOrder.length] != player;
        i++) {
      otherPlayers.add(turnOrder[(i + playerIndex) % turnOrder.length]);
    }
    return otherPlayers;
  }

  @override
  bool canStartGame(User player) =>
      super.canStartGame(player) && playersPlaying.length == 8;
  CheatGameModel addPlayer(User user) => copyWith(
        playerHands: {...playerHands, user.firebaseId: <Card>[]},
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
          allCards.add(Card(faceValue: i, suit: suit));
        }
      }
    }
    allCards.shuffle(rng);

    return allCards;
  }

  CheatGameModel shuffleCards({Random? rng}) {
    var allCards = generateDeck(rng: rng);
    var hands = {...playerHands};

    int lowerBound = 0;
    int upperBound = 13;
    for (final hand in hands.entries) {
      hand.value.addAll(allCards.getRange(lowerBound, upperBound));
      lowerBound += 13;
      upperBound += 13;
      hand.value.sort(Card.sortByValue);
    }

    int index = Random().nextInt(8);

    List<User> turnOrder = [];

    for (var i = 0; i < 8; i++) {
      turnOrder.add(players[(index + i) % 8]);
    }

    return copyWith(
      playerHands: hands,
      turnOrder: turnOrder,
      firstPlayer: firstPlayer,
    );
  }

  CheatGameModel roundEnd() {
    final playerHands = {...this.playerHands};
    final playerScores = {...this.playerScores};

    for (final entry in playerHands.entries) {
      if (entry.value.isEmpty) {
        playerScores[entry.key] = playerScores[entry.key]! + 1;
      }
    }

    for (final player in players) {
      playerHands[player.firebaseId] = [];
    }

    return copyWith(
      playerHands: playerHands,
      playerScores: playerScores,
      currentIndex: 0,
      handWinner: null,
      firstPlayer: null,
      turnOrder: [...players]..shuffle(),
      cardsPlayed: [],
      isRoundEnd: false,
      numPlayedPrevious: 0,
      calledCheat: false,
      playerWhoCalledCheat: null,
      playerWhoPlayed: null,
      potentialWinner: null,
      playerWhoGotCards: null,
      currentFaceValue: 1,
      gameStatus: playerScores.values.any((element) => element >= 5)
          ? GameStatus.finished
          : GameStatus.playing,
    ).shuffleCards();
  }

  CheatGameModel notPlayingAgain(User user) {
    final playersNotPlaying = [...this.playersNotPlaying, user];
    return copyWith(playersNotPlaying: playersNotPlaying);
  }

  CheatGameModel playingAgain(User user) {
    final playersPlaying = [...this.playersPlaying, user];
    return copyWith(
        playersPlaying: playersPlaying, gameStatus: GameStatus.inLobby);
  }

  CheatGameModel updateAfterCheatCalled(User user) {
    User playerWhoGotCards;
    if (playerWhoCalledCheat == user && calledCheat == true) {
      final playerHands = {...this.playerHands};

      final playerLied = lastPlayedCards!
          .any((element) => element.faceValue != previousFaceValue);
      if (playerLied) {
        // player was lying
        final playerHand = [...playerHands[playerWhoPlayed!.firebaseId]!];
        playerHand.addAll(cardsPlayed);
        playerHand.sort(Card.sortByValue);
        playerHands[playerWhoPlayed!.firebaseId] = playerHand;
        playerWhoGotCards = playerWhoPlayed!;
      } else {
        final playerHand = [...playerHands[user.firebaseId]!];
        playerHand.addAll(cardsPlayed);
        playerHand.sort(Card.sortByValue);
        playerHands[user.firebaseId] = playerHand;
        playerWhoGotCards = user;
      }

      return copyWith(
        playerHands: playerHands,
        cardsPlayed: [],
        calledCheat: false,
        playerWhoGotCards: playerWhoGotCards,
      );
    }

    return this;
  }

  CheatGameModel callCheat(User user) {
    assert(currentPlayer == user);
    assert(cardsPlayed.isNotEmpty,
        "Cannot call Cheat when no cards have been played!");
    assert(calledCheat != true,
        "Cannot call Cheat when Cheat has already been called!");
    return copyWith(
      calledCheat: true,
      playerWhoCalledCheat: user,
    );
  }

  CheatGameModel discardCards(List<Card> cards, User user) {
    final playerHands = {...this.playerHands};
    final playerHand = [...playerHands[user.firebaseId]!];

    for (var card in cards) {
      assert(playerHand.contains(card));
    }

    assert(
        currentPlayer == user, "Cannot discard cards when it's not your turn!");

    assert(currentIndex < 8);

    playerHand.removeWhere((element) => cards.contains(element));
    playerHands[user.firebaseId] = playerHand;

    var cardsPlayed = [...this.cardsPlayed];
    cardsPlayed.addAll(cards);

    int newCurrentIndex = currentIndex + 1;

    if (currentIndex == 7) {
      newCurrentIndex = 0;
    }

    return copyWith(
      currentIndex: newCurrentIndex,
      cardsPlayed: cardsPlayed,
      playerHands: playerHands,
      numPlayedPrevious: cards.length,
      potentialWinner: currentIndex == 0 ? turnOrder[7] : turnOrder[currentIndex - 1],
      playerWhoPlayed: user,
      currentFaceValue: (currentFaceValue % 13) + 1,
      isRoundEnd: playerHands.entries.any(
          (element) => element.key != user.firebaseId && element.value.isEmpty),
      playerWhoGotCards: null,
    );
  }

  CheatGameModel startGame() {
    Map<String, List<Card>> playerHands = {};
    Map<String, int> playerScores = {};

    for (var player in players) {
      playerHands[player.firebaseId] = [];
      playerScores[player.firebaseId] = 0;
    }
    return copyWith(
        playerHands: playerHands,
        playerScores: playerScores,
        gameStatus: GameStatus.playing,
        playersPlaying: [],
        playersNotPlaying: []);
  }
}
