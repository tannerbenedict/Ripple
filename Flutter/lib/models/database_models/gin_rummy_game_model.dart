import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/ui/games/gin_rummy/gin_rummy_bot_logic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gin_rummy_game_model.freezed.dart';
part 'gin_rummy_game_model.g.dart';

@freezed
class GinRummyGameModel extends GameModel with _$GinRummyGameModel {
  GinRummyGameModel._();

  @override
  GameType get gameType => GameType.ginRummy;

  @override
  bool canStartGame(User player) =>
      super.canStartGame(player) && playersPlaying.length == 2;

  factory GinRummyGameModel({
    required User? currentPlayer,
    required bool firstPlayerPassed,
    required bool isFirstTurn,
    required bool isSecondTurn,
    required bool bothPass,
    required List<Card> drawPile,
    required List<Card> discardPile,
    required Map<FirebaseID, List<Card>> playerHands,
    required Card? drawnCard,
    required Map<FirebaseID, int> playerScores,
    required User? playerKnocking,
    required User? playerGinning,
    required String lobbyCode,
    required List<User> players,
    required List<User> playersNotPlaying,
    required List<User> playersPlaying,
    required GameStatus gameStatus,
    required User host,
    required User? winner,
    required User? roundWinner,
  }) = _GinRummyGameState;

  factory GinRummyGameModel.fromJson(Map<String, dynamic> json) =>
      _$GinRummyGameModelFromJson(json);

  factory GinRummyGameModel.newGame(String lobbyCode, User user,
      {Random? rng}) {
    var allCards = GameModel.generateDeck(rng: rng);
    return GinRummyGameModel(
        currentPlayer: null,
        firstPlayerPassed: false,
        isFirstTurn: true,
        isSecondTurn: false,
        bothPass: false,
        winner: null,
        drawPile: allCards,
        discardPile: [],
        playerHands: Map.fromEntries([MapEntry(user.firebaseId, [])]),
        drawnCard: null,
        playerScores: Map.fromEntries([MapEntry(user.firebaseId, 0)]),
        playerKnocking: null,
        playerGinning: null,
        lobbyCode: lobbyCode,
        players: [user],
        playersPlaying: [user],
        playersNotPlaying: [],
        host: user,
        roundWinner: null,
        gameStatus: GameStatus.pending);
  }

  GinRummyGameModel addPlayer(User user) {
    var allCards = List<Card>.from(drawPile);

    var hands = {...playerHands};
    hands[user.firebaseId] = [];

    var players = [...this.players];
    players.add(user);

    var playersPlaying = [...this.playersPlaying];
    playersPlaying.add(user);

    var playerScores = {...this.playerScores};
    playerScores[user.firebaseId] = 0;

    return copyWith(
      drawPile: allCards,
      playerHands: hands,
      playerScores: playerScores,
      players: players,
      playersPlaying: playersPlaying,
      gameStatus: GameStatus.inLobby,
    );
  }

  GinRummyGameModel notPlayingAgain(User user) {
    final playersNotPlaying = [...this.playersNotPlaying, user];
    return copyWith(playersNotPlaying: playersNotPlaying);
  }

  GinRummyGameModel playingAgain(User user) {
    final playersPlaying = [...this.playersPlaying, user];
    return copyWith(
        playersPlaying: playersPlaying,
        gameStatus:
            playersPlaying.length == 2 ? GameStatus.inLobby : gameStatus);
  }

  GinRummyGameModel newRound({Random? rng, User? firstPlayer}) {
    var allCards = GameModel.generateDeck(rng: rng);
    final hands = {...playerHands};

    for (final key in hands.keys) {
      hands[key] = [];
    }

    return copyWith(
        drawPile: allCards,
        playerHands: hands,
        gameStatus: GameStatus.pending,
        roundWinner: firstPlayer);
  }

  GinRummyGameModel startGame({Random? rng}) {
    final allCards = [...drawPile];
    final hands = {...playerHands};
    hands.forEach((key, value) {
      value.addAll(allCards.getRange(0, 10));
      allCards.removeRange(0, 10);
    });

    final discardPile = allCards.take(1).toList();
    allCards.removeAt(0);
    final players = [...this.players];
    players.shuffle(rng);
    final firstPlayer = roundWinner ?? players.first;

    return copyWith(
      drawPile: allCards,
      playerHands: hands,
      players: players,
      discardPile: discardPile,
      gameStatus: GameStatus.playing,
      currentPlayer: firstPlayer,
      isFirstTurn: true,
      isSecondTurn: false,
      firstPlayerPassed: false,
      drawnCard: null,
      bothPass: false,
      playerKnocking: null,
      playerGinning: null,
      roundWinner: null,
    );
  }

  GinRummyGameModel startNewGame({Random? rng}) {
    Map<String, int> newPlayerScores = {};
    Map<String, List<Card>> hands = {};

    for (var player in this.players) {
      newPlayerScores[player.firebaseId] = 0;
      hands[player.firebaseId] = [];
    }

    final allCards = GameModel.generateDeck(rng: rng);

    hands.forEach((key, value) {
      value.addAll(allCards.getRange(0, 10));
      allCards.removeRange(0, 10);
    });

    final discardPile = allCards.take(1).toList();
    allCards.removeAt(0);
    final players = [...this.players];
    players.shuffle(rng);

    return copyWith(
        drawPile: allCards,
        playerHands: hands,
        players: players,
        discardPile: discardPile,
        gameStatus: GameStatus.playing,
        currentPlayer: players.first,
        isFirstTurn: true,
        isSecondTurn: false,
        firstPlayerPassed: false,
        drawnCard: null,
        bothPass: false,
        playerKnocking: null,
        playerGinning: null,
        roundWinner: null,
        playersPlaying: [],
        playerScores: newPlayerScores,
        playersNotPlaying: []);
  }

  int calcPlayerDeadwood(User? player) {
    if (player == null) {
      return -1;
    }
    final playerHand = playerHands[player.firebaseId]!;
    final playerMatched = GinRummyLogic.getMatched(playerHand);
    final playerDeadwood = GinRummyLogic.getDeadwood(playerHand, playerMatched);
    if (playerHand.length == 11) {
      final cardToDiscard =
          GinRummyLogic.getCardToDiscard(playerMatched, playerDeadwood);
      // The only time we'll discard a card *not* from the deadwood is if
      // we have a literally perfect hand. In that case, we wouldn't change
      // playerDeadwood would be empty, so remove would have no effect anyways.
      playerDeadwood.remove(cardToDiscard);
    }
    return GinRummyLogic.calculateDeadwood(playerDeadwood);
  }

  User getOpponent(User player) {
    return players
        .firstWhere((element) => element.firebaseId != player.firebaseId);
  }

  bool _checkBasicConditions(User? player) =>
      player != null &&
      players.contains(player) &&
      currentPlayer == player &&
      gameStatus == GameStatus.playing;

  bool playerCanDiscard(User? player) =>
      _checkBasicConditions(player!) &&
      playerHands[currentPlayer!.firebaseId]!.length == 11;

  bool playerCanDrawDrawPile(User? player) =>
      _checkBasicConditions(player!) &&
      !isFirstTurn &&
      !(isSecondTurn && firstPlayerPassed) &&
      playerHands[currentPlayer!.firebaseId]!.length == 10;

  bool playerCanDrawDiscardPile(User? player) =>
      _checkBasicConditions(player) &&
      playerHands[currentPlayer!.firebaseId]!.length == 10;

  bool playerCanPass() =>
      (isFirstTurn && isSecondTurn) || (firstPlayerPassed && isSecondTurn);

  bool playerCanKnock() {
    final hand = playerHands[currentPlayer!.firebaseId]!;
    final matches = GinRummyLogic.getMatched(hand);
    final deadwood = GinRummyLogic.getDeadwood(hand, matches);
    final score = GinRummyLogic.calculateDeadwood(deadwood);

    return score <= 10;
  }
}
