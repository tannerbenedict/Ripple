import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/ui/games/ripple_bot_logic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'two_player_game_model.freezed.dart';
part 'two_player_game_model.g.dart';

@freezed
class TwoPlayerGameModel extends GameModel with _$TwoPlayerGameModel {
  TwoPlayerGameModel._();

  @override
  GameType get gameType => GameType.twoPlayer;


  @override
  bool canStartGame(User player) =>
      super.canStartGame(player) && playersPlaying.length == 2;

  factory TwoPlayerGameModel({
    required User? currentPlayer,
    required bool isFirstTurn,
    required bool isSecondTurn,
    required bool canRipple,
    required bool firstPlay,
    required List<Card> drawPile,
    required List<Card> discardPile,
    required List<Card> activePile,
    required int cardsFlipped,
    required Map<FirebaseID, List<Card>> playerHands,
    required Card? drawnCard,
    required Map<FirebaseID, int> playerScores,
    required String lobbyCode,
    required List<User> players,
    required List<User> playersNotPlaying,
    required List<User> playersPlaying,
    required GameStatus gameStatus,
    required User host,
    required User? winner,
    required User? roundWinner,
  }) = _TwoPlayerGameState;

  factory TwoPlayerGameModel.fromJson(Map<String, dynamic> json) =>
      _$TwoPlayerGameModelFromJson(json);

  factory TwoPlayerGameModel.newGame(String lobbyCode, User user,
      {Random? rng}) {
    var allCards = GameModel.generateDeck(rng: rng);
    return TwoPlayerGameModel(
        currentPlayer: null,
        isFirstTurn: true,
        isSecondTurn: false,
        canRipple: true,
        firstPlay: true,
        winner: null,
        drawPile: allCards,
        discardPile: [],
        activePile: [],
        cardsFlipped: 0,
        playerHands: Map.fromEntries([MapEntry(user.firebaseId, [])]),
        drawnCard: null,
        playerScores: Map.fromEntries([MapEntry(user.firebaseId, 0)]),
        lobbyCode: lobbyCode,
        players: [user],
        playersPlaying: [user],
        playersNotPlaying: [],
        host: user,
        roundWinner: null,
        
        gameStatus: GameStatus.pending);
  }

  TwoPlayerGameModel addPlayer(User user) {
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

  TwoPlayerGameModel notPlayingAgain(User user) {
    final playersNotPlaying = [...this.playersNotPlaying, user];
    return copyWith(playersNotPlaying: playersNotPlaying);
  }

  TwoPlayerGameModel playingAgain(User user) {
    final playersPlaying = [...this.playersPlaying, user];
    return copyWith(
        playersPlaying: playersPlaying,
        gameStatus:
            playersPlaying.length == 2 ? GameStatus.inLobby : gameStatus);
  }

  TwoPlayerGameModel newRound({Random? rng, User? firstPlayer}) {
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

  TwoPlayerGameModel startGame({Random? rng}) {
    final allCards = [...drawPile];
    final hands = {...playerHands};
    hands.forEach((key, value) {
      value.addAll(allCards.getRange(0, 10));
      allCards.removeRange(0, 10);
    });

    final players = [...this.players];
    players.shuffle(rng);
    final firstPlayer = roundWinner ?? players.first;

    return copyWith(
      drawPile: allCards,
      playerHands: hands,
      players: players,
      discardPile: [],
      activePile: [],
      cardsFlipped: 0,
      gameStatus: GameStatus.playing,
      currentPlayer: firstPlayer,
      isFirstTurn: true,
      isSecondTurn: false,
      drawnCard: null,
      roundWinner: null,
    );
  }

  TwoPlayerGameModel startNewGame({Random? rng}) {
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

    final players = [...this.players];
    players.shuffle(rng);

    return copyWith(
        drawPile: allCards,
        playerHands: hands,
        players: players,
        discardPile: [],
        activePile: [],
        cardsFlipped: 0,
        gameStatus: GameStatus.playing,
        currentPlayer: players.first,
        isFirstTurn: true,
        isSecondTurn: false,
        drawnCard: null,
        roundWinner: null,
        playersPlaying: [],
        playerScores: newPlayerScores,
        playersNotPlaying: []);
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
      activePile.isNotEmpty;

  bool playerCanDrawDrawPile(User? player) =>
      _checkBasicConditions(player!) &&
      playerHands[currentPlayer!.firebaseId]!.length == 10;

  bool playerCanDrawDiscardPile(User? player) =>
      _checkBasicConditions(player) &&
      playerHands[currentPlayer!.firebaseId]!.length == 10;
      
        @override
        // TODO: implement gameStatus
        GameStatus get gameStatus => throw UnimplementedError();
      
        @override
        // TODO: implement host
        User get host => throw UnimplementedError();
      
        @override
        // TODO: implement lobbyCode
        String get lobbyCode => throw UnimplementedError();
      
        @override
        // TODO: implement playerHands
        Map<FirebaseID, List<Card>> get playerHands => throw UnimplementedError();
      
        @override
        // TODO: implement players
        List<User> get players => throw UnimplementedError();
      
        @override
        // TODO: implement playersNotPlaying
        List<User> get playersNotPlaying => throw UnimplementedError();
      
        @override
        // TODO: implement playersPlaying
        List<User> get playersPlaying => throw UnimplementedError();

  
}
