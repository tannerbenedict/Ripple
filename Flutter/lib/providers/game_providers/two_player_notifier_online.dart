import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/database_models/two_player_game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/game_providers/two_player_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/ripple_bot_logic.dart';
import 'package:ripple/ui/games/two_player/draw_pile.dart';
import 'package:ripple/ui/lobby/lobby.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ripple/app/router.dart';

part 'two_player_notifier_online.g.dart';

@riverpod
class TwoPlayerNotifierOnline extends _$TwoPlayerNotifierOnline
    implements TwoPlayerNotifier<TwoPlayerGameModel?> {
  @override
  Future<TwoPlayerGameModel?> build(String lobbyCode, {int? seed}) async {
    final db = ref.read(databaseRepositoryProvider);

    final sub = db.watchTwoPlayerGame(lobbyCode).listen((event) {
      if (event == null) {
        state = AsyncError(GameDeletedException(), StackTrace.current);
      } else {
        state = AsyncData(event);
      }
    });
    ref.onDispose(() async {
      await sub.cancel();
    });
    return await db.getTwoPlayerGame(lobbyCode);
  }

  @override
  Future<void> createNewGame() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    if (user == null) {
      throw UserRequiredError();
    }
    final db = ref.read(databaseRepositoryProvider);
    final possibleGame = await db.getTwoPlayerGame(lobbyCode);

    if (possibleGame != null) {
      throw GameAlreadyExistsException();
    }

    final newGame = TwoPlayerGameModel.newGame(
        lobbyCode, User.fromFirebaseUser(user),
        rng: Random(seed));

    await _optimisticStateUpdate(newGame, db);
  }

  Future<void> updateAtomically(
      String lobbyCode, User user, UpdateType update) async {
    final previous = state;
    final db = ref.read(databaseRepositoryProvider);

    try {
      state =
          AsyncData((await db.updateTwoPlayerLobby(lobbyCode, user, update)));
    } catch (e) {
      state = previous;
      rethrow;
    }
  }

  @override
  Future<void> joinGame() async {
    final db = ref.read(databaseRepositoryProvider);
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    if (user == null) {
      throw UserRequiredError();
    }
    final game = await db.getTwoPlayerGame(lobbyCode);
    if (game == null) {
      throw GameNotFoundException();
    } else if (game.players.contains(User.fromFirebaseUser(user))) {
      return;
    } else if (game.players.length == 2) {
      throw GameFullException();
      // Technically, we'll hit the exception case above first, as
      // a non-pending game must, by our definition, have two players.
      // Pays to be thorough though, especially later on when we add
      // Crashalytics.
    }
    // else if (game.gameStatus != GameStatus.pending) {
    //   throw GameNotJoinableException();
    // }

    await updateAtomically(
        lobbyCode, User.fromFirebaseUser(user), UpdateType.newPlayer);
  }

  @override
  Future<void> startGame() async {
    final db = ref.read(databaseRepositoryProvider);
    final game = state.asData?.value;
    if (game == null) {
      throw GameNotFoundException();
    } else if (game.gameStatus != GameStatus.inLobby) {
      throw GameNotStartableException();
    }

    await _optimisticStateUpdate(game.startNewGame(rng: Random(seed)), db);
  }

  @override
  Future<void> flipCards(User user) async {
    //not used online
  }

  @override
  Future<void> notPlayingAgain() async {
    final db = ref.read(databaseRepositoryProvider);
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    } else if (user == null) {
      throw UserRequiredError();
    }

    await updateAtomically(
        lobbyCode, User.fromFirebaseUser(user), UpdateType.notPlaying);
  }

  @override
  Future<void> updateHost() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    } else if (user == null) {
      throw UserRequiredError();
    }

    await updateAtomically(
        lobbyCode, User.fromFirebaseUser(user), UpdateType.updateHost);
  }

  @override
  Future<void> playingAgain() async {
    final db = ref.read(databaseRepositoryProvider);
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    } else if (user == null) {
      throw UserRequiredError();
    }

    await updateAtomically(
        lobbyCode, User.fromFirebaseUser(user), UpdateType.replaying);
  }

  @override
  Future<void> startNewRound() async {
    final db = ref.read(databaseRepositoryProvider);
    final game = state.asData?.value;
    User? firstPlayer = game?.currentPlayer;
    if (game == null) {
      throw GameNotFoundException();
    } else if (game.gameStatus != GameStatus.roundEnded) {
      throw RoundNotStartableException();
    }

    await _optimisticStateUpdate(
      game.newRound(rng: Random(seed), firstPlayer: firstPlayer).startGame(),
      db,
    );
  }

  @override
  Future<void> playGameAgain() async {
    final db = ref.read(databaseRepositoryProvider);
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    if (user == null) {
      throw UserRequiredError();
    }
    final convertedUser = User.fromFirebaseUser(user);
    final newGame =
        TwoPlayerGameModel.newGame(lobbyCode, convertedUser, rng: Random(seed));

    await _optimisticStateUpdate(
      newGame.addPlayer(convertedUser).startGame(),
      db,
    );
  }

  @override
  Future<void> drawDiscardPile(User user) async {
    final db = ref.read(databaseRepositoryProvider);
    final game = state.asData?.value;
    _checkCanDraw(user);

    final playerHands = {...game!.playerHands};
    final discardPile = [...game.discardPile];
    final playerHand = [...playerHands[user.firebaseId]!];
    assert(discardPile.isNotEmpty, "Cannot draw from an empty discard pile!");
    assert(playerHands.containsKey(user.firebaseId),
        "User is in game but does not have a hand!");
    final drawnCard = discardPile.removeLast();
    final cardIndex =
        RippleLogic.playIndex(playerHands[user.firebaseId]!, drawnCard);
    playerHand[cardIndex] = drawnCard;
    playerHands[user.firebaseId] = playerHand;

    await _optimisticStateUpdate(
        game.copyWith(
            discardPile: discardPile,
            playerHands: playerHands,
            drawnCard: null),
        db);
  }

  @override
  Future<void> drawDrawPile(User user) async {
    final db = ref.read(databaseRepositoryProvider);
    final game = state.asData?.value;
    _checkCanDraw(user);
    if (game!.isFirstTurn || game.isSecondTurn) {
      throw DrawNotAllowedException();
    }
    final activePile = [...game.activePile];
    final drawPile = [...game.drawPile];
    assert(drawPile.isNotEmpty, "Cannot draw from an empty draw pile");
    // Map.from only does a shallow clone, so we get the same reference
    // to the actual list, except it's now modifiable.
    // To prevent accidental modification, we instead create a copy here.
    final drawnCard = drawPile.removeLast();
    activePile.add(Card(
        faceValue: drawnCard.faceValue, isFlipped: true, id: drawnCard.id));
    final nextPlayer = game.players[(game.players.indexOf(user))];
    if (drawPile.isEmpty) {
      // Shuffle all but top card of discard into draw pile.
      final pile = List<Card>.from(game.discardPile);
      final topCard = pile.removeLast();
      pile.shuffle(Random(seed));
      await _optimisticStateUpdate(
          game.copyWith(
              currentPlayer: nextPlayer,
              discardPile: [topCard],
              drawPile: pile,
              activePile: activePile,
              drawnCard: null),
          db);
    } else {
      await _optimisticStateUpdate(
          game.copyWith(
              currentPlayer: nextPlayer,
              drawPile: drawPile,
              activePile: activePile,
              drawnCard: drawnCard),
          db);
    }
  }

  /// Checks a variety of criteria to make sure a player is allowed to
  /// draw.
  void _checkCanDraw(User user) {
    _checkBasicConditions(user);
    final game = state.asData!.value!;
    if (game.activePile.isNotEmpty) {
      throw DrawNotAllowedException();
    }
  }

  @override
  Future<void> userFlipCard(User user, int index) async {
    final db = ref.read(databaseRepositoryProvider);
    final game = state.asData?.value;
    _checkBasicConditions(user);
    if ((!game!.isFirstTurn && !game.isSecondTurn)) {
      throw CannotPassException();
    }
    final playerHands = {...game.playerHands};
    final playerHand = [...playerHands[user.firebaseId]!];
    _checkCanFlip(index, playerHand);
    playerHand[index] = Card(
        faceValue: playerHand[index].faceValue,
        id: playerHand[index].id,
        isFlipped: true);
    playerHands[user.firebaseId] = playerHand;
    final flipped = game.cardsFlipped + 1;
    final nextPlayer = flipped > 2
        ? game.players[(game.players.indexOf(user) + 1) % 2]
        : game.players[(game.players.indexOf(user))];
    final endTurn = flipped < 3;
    final cardsFlipped = flipped < 3 ? flipped : 0;
    await _optimisticStateUpdate(
        game.copyWith(
          currentPlayer: nextPlayer,
          playerHands: playerHands,
          isFirstTurn: endTurn,
          cardsFlipped: cardsFlipped,
          // If we're the first player, then we obviously passed. If we're
          // the second, player the only way we could get this far is if the
          // first player passed, so, this is always true.
          isSecondTurn: !game.isSecondTurn,
        ),
        db);
  }

  @override
  Future<void> placeCard(Card card, User user, int index) async {
    final db = ref.read(databaseRepositoryProvider);
    final game = state.asData?.value;
    _checkBasicConditions(user);

    final playerHands = {...game!.playerHands};
    assert(playerHands.containsKey(user.firebaseId),
        "User is marked as a player but does not have a hand");
    final activePile = [...game.activePile];
    final discardPile = [...game.discardPile];
    final playerHand = [...playerHands[user.firebaseId]!];
    bool canRipple = game.canRipple;
    final activeDraw = activePile.isNotEmpty ? true : false;
    final playingCard =
        activePile.isEmpty ? discardPile.removeLast() : activePile.removeLast();
    if (game.firstPlay == false) {
      _checkCanPlace(user, index, playingCard, playerHand, canRipple);
    }
    canRipple = playerHand[index].isFlipped ? false : true;
    activePile.add(Card(
        faceValue: playerHand[index].faceValue,
        isFlipped: true,
        id: playerHand[index].id));
    playerHand[index] = Card(
        faceValue: playingCard.faceValue, isFlipped: true, id: playingCard.id);
    playerHands[user.firebaseId] = playerHand;
    if (RippleLogic.allFlipped(playerHand)) {
      endRound(user, activePile, playerHand);
    } else {
      if (activeDraw) {
        await _optimisticStateUpdate(
            game.copyWith(
              playerHands: playerHands,
              activePile: activePile,
              canRipple: canRipple,
              drawnCard: playingCard,
              firstPlay: false,
            ),
            db);
      } else {
        await _optimisticStateUpdate(
            game.copyWith(
              playerHands: playerHands,
              activePile: activePile,
              discardPile: discardPile,
              canRipple: canRipple,
              drawnCard: playingCard,
              firstPlay: false,
            ),
            db);
      }
    }
  }

  @override
  Future<void> endRound(
      User user, List<Card> activePile, List<Card> playerHand) async {
    final db = ref.read(databaseRepositoryProvider);
    final game = state.asData?.value;
    final playerHands = {...game!.playerHands};
    final playerScores = {...game.playerScores};
    int playerUpdatedScore;
    int oppUpdatedScore;
    var opp =
        game.players.where((player) => player.firebaseId != user.firebaseId);
    final oppHand =
        RippleLogic.flipRemaining(playerHands[opp.first.firebaseId]!);
    final playerScore = RippleLogic.calculateScore(playerHand);
    final oppScore =
        RippleLogic.calculateScore(playerHands[opp.first.firebaseId]!);
    playerUpdatedScore =
        playerScores.update(user.firebaseId, (value) => value + playerScore);
    oppUpdatedScore =
        playerScores.update(opp.first.firebaseId, (value) => value + oppScore);
    final nextPlayer = game.players[((game.players.indexOf(user) + 1) % 2)];
    playerHands[user.firebaseId] = playerHand;
    playerHands[opp.first.firebaseId] = oppHand;
    await _optimisticStateUpdate(
        game.copyWith(
            playerScores: playerScores,
            playerHands: playerHands,
            gameStatus: playerUpdatedScore >= 100
                ? GameStatus.finished
                : oppUpdatedScore >= 100
                    ? GameStatus.finished
                    : playerUpdatedScore <= -100
                        ? GameStatus.finished
                        : oppUpdatedScore <= -100
                            ? GameStatus.finished
                            : GameStatus.roundEnded,
            currentPlayer: nextPlayer),
        db);
    await Future.delayed(Duration(seconds: 3));
    await startNewRound();
  }

  @override
  Future<void> discardCard(Card card, User user) async {
    final db = ref.read(databaseRepositoryProvider);
    final game = state.asData?.value;
    _checkBasicConditions(user);

    final activePile = [...game!.activePile];
    final discardPile = [...game.discardPile];

    if (activePile.isEmpty) {
      throw CannotDiscardException();
    }
    activePile.remove(card);
    discardPile.add(card);

    // Gin Rummy games always have two players, bot or human.
    final nextPlayer = game.players[((game.players.indexOf(user) + 1) % 2)];

    await _optimisticStateUpdate(
        game.copyWith(
            currentPlayer: nextPlayer,
            activePile: activePile,
            discardPile: discardPile,
            drawnCard: null,
            isFirstTurn: false,
            canRipple: true,
            firstPlay: true,
            isSecondTurn: game.isFirstTurn),
        db);
  }

  void _checkBasicConditions(User user) {
    final game = state.asData?.value;
    if (game == null) {
      throw GameNotFoundException();
    } else if (game.gameStatus != GameStatus.playing) {
      throw GameEndedException();
    } else if (!game.players.contains(user)) {
      throw NotAPlayerException();
    } else if (game.currentPlayer != user) {
      throw NotPlayerTurnException();
    }
  }

  void _checkCanPlace(User user, int index, Card playingCard,
      List<Card> playerHand, bool canRipple) {
    if (!canRipple) {
      throw CannotRippleException();
    }
    final cardValue = playingCard.faceValue;
    switch (index) {
      case 0:
        if (playerHand[0].isFlipped ||
            (!playerHand[5].isFlipped ||
                (playerHand[5].isFlipped &&
                    playerHand[5].faceValue != cardValue))) {
          throw CannotRippleException();
        }
      case 1:
        if (playerHand[1].isFlipped ||
            (!playerHand[6].isFlipped ||
                (playerHand[6].isFlipped &&
                    playerHand[6].faceValue != cardValue))) {
          throw CannotRippleException();
        }
      case 2:
        if (playerHand[2].isFlipped ||
            (!playerHand[7].isFlipped ||
                (playerHand[7].isFlipped &&
                    playerHand[7].faceValue != cardValue))) {
          throw CannotRippleException();
        }
      case 3:
        if (playerHand[3].isFlipped ||
            (!playerHand[8].isFlipped ||
                (playerHand[8].isFlipped &&
                    playerHand[8].faceValue != cardValue))) {
          throw CannotRippleException();
        }
      case 4:
        if (playerHand[4].isFlipped ||
            (!playerHand[9].isFlipped ||
                (playerHand[9].isFlipped &&
                    playerHand[9].faceValue != cardValue))) {
          throw CannotRippleException();
        }
      case 5:
        if (playerHand[5].isFlipped ||
            (!playerHand[0].isFlipped ||
                (playerHand[0].isFlipped &&
                    playerHand[0].faceValue != cardValue))) {
          throw CannotRippleException();
        }
      case 6:
        if (playerHand[6].isFlipped ||
            (!playerHand[1].isFlipped ||
                (playerHand[1].isFlipped &&
                    playerHand[1].faceValue != cardValue))) {
          throw CannotRippleException();
        }
      case 7:
        if (playerHand[7].isFlipped ||
            (!playerHand[2].isFlipped ||
                (playerHand[2].isFlipped &&
                    playerHand[2].faceValue != cardValue))) {
          throw CannotRippleException();
        }
      case 8:
        if (playerHand[9].isFlipped ||
            (!playerHand[3].isFlipped ||
                (playerHand[3].isFlipped &&
                    playerHand[3].faceValue != cardValue))) {
          throw CannotRippleException();
        }
      case 9:
        if (playerHand[9].isFlipped ||
            (!playerHand[4].isFlipped ||
                (playerHand[4].isFlipped &&
                    playerHand[4].faceValue != cardValue))) {
          throw CannotRippleException();
        }
    }
  }

  void _checkCanFlip(int index, List<Card> PlayerHand) {
    switch (index) {
      case 0:
        if (PlayerHand[5].isFlipped) throw CannotPassException();
      case 1:
        if (PlayerHand[6].isFlipped) throw CannotPassException();
      case 2:
        if (PlayerHand[7].isFlipped) throw CannotPassException();
      case 3:
        if (PlayerHand[8].isFlipped) throw CannotPassException();
      case 4:
        if (PlayerHand[9].isFlipped) throw CannotPassException();
      case 5:
        if (PlayerHand[0].isFlipped) throw CannotPassException();
      case 6:
        if (PlayerHand[1].isFlipped) throw CannotPassException();
      case 7:
        if (PlayerHand[2].isFlipped) throw CannotPassException();
      case 8:
        if (PlayerHand[3].isFlipped) throw CannotPassException();
      case 9:
        if (PlayerHand[4].isFlipped) throw CannotPassException();
    }
  }

  Future<void> _optimisticStateUpdate(
      TwoPlayerGameModel? newState, DatabaseRepository db) async {
    final previous = state;

    if (newState == null) {
      state = AsyncError(GameDeletedException(), StackTrace.current);
      return;
    } else {
      state = AsyncData(newState);
    }
    try {
      await db.updateTwoPlayerGame(newState);
    } catch (e) {
      state = previous;
    }
  }

  @override
  (String, Map<String, String>) getGameRoutingInfo() {
    return (
      GameType.twoPlayer.onlineRouteName,
      {"lobbyCode": lobbyCode},
    );
  }

  @override
  (String, Map<String, String>) getLobbyRoutingInfo() {
    return (
      LobbyPage.routeName,
      {"gameType": GameType.twoPlayer.toString(), "lobbyCode": lobbyCode},
    );
  }
}
