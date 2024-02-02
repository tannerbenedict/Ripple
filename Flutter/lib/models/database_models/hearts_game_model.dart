import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/ui/games/hearts/hearts_bot_logic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hearts_game_model.freezed.dart';
part 'hearts_game_model.g.dart';

typedef PlayerID = String;

@freezed
class HeartsGameModel extends GameModel with _$HeartsGameModel {
  static const _perfectHand = 26;
  HeartsGameModel._();

  @override
  GameType get gameType => GameType.hearts;

  @override
  bool canStartGame(User player) =>
      super.canStartGame(player) && playersPlaying.length == 4;

  factory HeartsGameModel({
    required Map<PlayerID, List<Card>> playerHands,
    required List<Card> cardsPlayed,
    required Map<PlayerID, Card?> playerDiscards,
    required Card? cardLed,
    required List<User> turnOrder,
    required Map<PlayerID, int> playerScores,
    required Map<PlayerID, List<Card>> playerWins,
    required String lobbyCode,
    required User? firstPlayer,
    required User? handWinner,
    required int currentIndex,
    required bool roundEnded,
    required bool heartsBroken,
    required List<User> players,
    required List<User> playersNotPlaying,
    required List<User> playersPlaying,
    required GameStatus gameStatus,
    required User host,
    required User? winner,
  }) = _HeartsGameModel;

  factory HeartsGameModel.fromJson(Map<String, dynamic> json) =>
      _$HeartsGameModelFromJson(json);

  factory HeartsGameModel.newGame(String lobbyCode, User user, Random rng) {
    return HeartsGameModel(
        playerHands: {user.firebaseId: []},
        cardsPlayed: [],
        playerDiscards: {user.firebaseId: null},
        cardLed: null,
        turnOrder: [],
        playerScores: {user.firebaseId: 0},
        playerWins: {user.firebaseId: []},
        lobbyCode: lobbyCode,
        gameStatus: GameStatus.pending,
        firstPlayer: null,
        handWinner: null,
        currentIndex: 0,
        roundEnded: false,
        heartsBroken: false,
        winner: null,
        players: [user],
        playersPlaying: [user],
        playersNotPlaying: [],
        host: user);
  }

  User? get currentPlayer {
    if (endOfTrick) {
      return null;
    } else if (currentIndex > (turnOrder.length - 1)) {
      return null;
    } else {
      return turnOrder[currentIndex];
    }
  }

  bool get endOfTrick =>
      currentIndex == 0 &&
      playerDiscards.values.every((element) => element != null);

  bool get startOfTrick =>
      currentIndex == 0 && playerDiscards.values.every((v) => v == null);

  bool get startOfRound =>
      currentIndex == 0 && playerHands.values.every((v) => v.length == 13);

  HeartsGameModel addPlayer(User user) => copyWith(
        playerHands: {...playerHands, user.firebaseId: <Card>[]},
        playerScores: {...playerScores, user.firebaseId: 0},
        players: [...players, user],
        playersPlaying: [...playersPlaying, user],
        gameStatus: GameStatus.inLobby,
        playerDiscards: {...playerDiscards, user.firebaseId: null},
        playerWins: {...playerWins, user.firebaseId: []},
      );

  HeartsGameModel shuffleCards({Random? rng}) {
    var allCards = GameModel.generateDeck(rng: rng);
    var hands = {...playerHands};

    int lowerBound = 0;
    int upperBound = 13;
    for (final hand in hands.entries) {
      hand.value.addAll(allCards.getRange(lowerBound, upperBound));
      lowerBound += 13;
      upperBound += 13;
      hand.value.sort(Card.sortBySuit);
    }

    final entry = hands.entries.firstWhere(
        (hand) => hand.value.any((card) => card.faceValue == 2 && card.suit == Suit.clubs));

    final firstPlayer = players.firstWhere((p) => p.firebaseId == entry.key);

    int index = players.indexWhere((element) => element == firstPlayer);

    List<User> turnOrder = [];

    for (var i = 0; i < 4; i++) {
      turnOrder.add(players[(index + i) % 4]);
    }

    return copyWith(
      playerHands: hands,
      turnOrder: turnOrder,
      firstPlayer: firstPlayer,
    );
  }

  HeartsGameModel notPlayingAgain(User user) {
    final playersNotPlaying = [...this.playersNotPlaying, user];
    return copyWith(playersNotPlaying: playersNotPlaying);
  }

  HeartsGameModel playingAgain(User user) {
    final playersPlaying = [...this.playersPlaying, user];
    return copyWith(
        playersPlaying: playersPlaying,
        gameStatus:
            playersPlaying.length == 4 ? GameStatus.inLobby : gameStatus);
  }

  HeartsGameModel roundEnd() {
    final playerHands = {...this.playerHands};
    final playerWins = {...this.playerWins};
    final playerDiscards = {...this.playerDiscards};
    final playerScores = {...this.playerScores};

    for (final entry in playerWins.entries) {
      final score = HeartsLogic.getPoints(entry.value);
      if (score == _perfectHand) {
        playerScores.keys
            .where((k) => k != entry.key)
            .forEach((id) => playerScores[id] = playerScores[id]! + score);
      } else {
        playerScores[entry.key] = playerScores[entry.key]! + score;
      }
    }

    for (final player in players) {
      playerHands[player.firebaseId] = [];
      playerWins[player.firebaseId] = [];
      playerDiscards[player.firebaseId] = null;
    }

    return copyWith(
      playerHands: playerHands,
      playerWins: playerWins,
      playerDiscards: playerDiscards,
      playerScores: playerScores,
      heartsBroken: false,
      currentIndex: 0,
      handWinner: null,
      firstPlayer: null,
      turnOrder: [...players]..shuffle(),
      cardLed: null,
      cardsPlayed: [],
      gameStatus: playerScores.values.any((element) => element >= 100)
          ? GameStatus.finished
          : GameStatus.playing,
    ).shuffleCards();
  }

  HeartsGameModel trickWon(User user) {
    final playerHands = {...this.playerHands};
    final playerHand = [...playerHands[user.firebaseId]!];
    final playerDiscards = {...this.playerDiscards};
    assert(endOfTrick);
    final playerWins = {...this.playerWins};
    final handWinner = HeartsLogic.getWinnerOfTrick(cardsPlayed);

    final trickWinner = turnOrder[handWinner];
    playerWins[trickWinner.firebaseId]!.addAll(cardsPlayed);

    var index = players.indexWhere((element) => element == trickWinner);

    final updatedModel = copyWith(
      heartsBroken: heartsBroken,
      cardLed: null,
      currentIndex: 0,
      firstPlayer: trickWinner,
      cardsPlayed: [],
      playerWins: playerWins,
      playerHands: playerHands,
      playerDiscards: playerDiscards.map((key, _) => MapEntry(key, null)),
      turnOrder: List.generate(4, (i) => players[(index + i) % 4]),
    );

    if (playerHand.isEmpty) {
      return updatedModel.roundEnd();
    } else {
      return updatedModel;
    }
  }

  HeartsGameModel discardCard(Card card, User user) {
    final playerHands = {...this.playerHands};
    final playerHand = [...playerHands[user.firebaseId]!];
    final playerDiscards = {...this.playerDiscards};

    assert(playerHand.contains(card));
    assert(currentIndex < 4);

    playerHand.remove(card);
    playerHands[user.firebaseId] = playerHand;
    playerDiscards[user.firebaseId] = card;
    final cardsPlayed = [...this.cardsPlayed, card];

    if (currentIndex < 4) {
      return copyWith(
        cardLed: cardLed ?? card,
        currentIndex: (currentIndex + 1) % players.length,
        heartsBroken: heartsBroken || card.suit == Suit.hearts,
        cardsPlayed: cardsPlayed,
        playerHands: playerHands,
        playerDiscards: playerDiscards,
      );
      // Last play of trick (and maybe round)
    } else {
      throw Exception("Invalid index");
    }
  }

  HeartsGameModel startGame() {
    Map<String, List<Card>> playerHands = {};
    Map<String, Card?> playerDiscards = {};
    Map<String, int> playerScores = {};
    Map<String, List<Card>> playerWins = {};
    for (var player in players) {
      playerHands[player.firebaseId] = [];
      playerDiscards[player.firebaseId] = null;
      playerScores[player.firebaseId] = 0;
      playerWins[player.firebaseId] = [];
    }

    return copyWith(
      gameStatus: GameStatus.playing,
      playersPlaying: [],
      playersNotPlaying: [],
      playerHands: playerHands,
      cardsPlayed: [],
      playerDiscards: playerDiscards,
      cardLed: null,
      turnOrder: [],
      playerScores: playerScores,
      playerWins: playerWins,
      firstPlayer: null,
      handWinner: null,
      currentIndex: 0,
      roundEnded: false,
      heartsBroken: false,
      winner: null,
    );
  }
}
