import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/database_models/gin_rummy_game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/game_providers/gin_rummy_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/gin_rummy/gin_rummy_bot_logic.dart';
import 'package:ripple/ui/lobby/lobby.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ripple/app/router.dart';

part 'gin_rummy_notifier_online.g.dart';

@riverpod
class GinRummyNotifierOnline extends _$GinRummyNotifierOnline
    implements GinRummyNotifier<GinRummyGameModel?> {
  @override
  Future<GinRummyGameModel?> build(String lobbyCode, {int? seed}) async {
    final db = ref.read(databaseRepositoryProvider);

    final sub = db.watchGinRummyGame(lobbyCode).listen((event) {
      if (event == null) {
        state = AsyncError(GameDeletedException(), StackTrace.current);
      } else {
        state = AsyncData(event);
      }
    });
    ref.onDispose(() async {
      await sub.cancel();
    });
    return await db.getGinRummyGame(lobbyCode);
  }

  @override
  Future<void> createNewGame() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    if (user == null) {
      throw UserRequiredError();
    }
    final db = ref.read(databaseRepositoryProvider);
    final possibleGame = await db.getGinRummyGame(lobbyCode);

    if (possibleGame != null) {
      throw GameAlreadyExistsException();
    }

    final newGame = GinRummyGameModel.newGame(
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
          AsyncData((await db.updateGinRummyLobby(lobbyCode, user, update)));
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
    final game = await db.getGinRummyGame(lobbyCode);
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
  Future<void> passTurn(User user) async {
    final db = ref.read(databaseRepositoryProvider);
    final game = state.asData?.value;
    _checkBasicConditions(user);
    if ((!game!.isFirstTurn && !game.isSecondTurn) ||
        (!game.firstPlayerPassed && game.isSecondTurn)) {
      throw CannotPassException();
    }

    final nextPlayer = game.players[(game.players.indexOf(user) + 1) % 2];

    await _optimisticStateUpdate(
        game.copyWith(
            currentPlayer: nextPlayer,
            isFirstTurn: false,
            // If we're the first player, then we obviously passed. If we're
            // the second, player the only way we could get this far is if the
            // first player passed, so, this is always true.
            firstPlayerPassed: true,
            isSecondTurn: !game.isSecondTurn,
            bothPass: game.isSecondTurn),
        db);
  }

  @override
  Future<void> knock(Card cardToDiscard, User user) async {
    final db = ref.read(databaseRepositoryProvider);
    User roundWinner;
    final game = state.asData?.value;
    _checkBasicConditions(user);
    if (!game!.playerHands[user.firebaseId]!.contains(cardToDiscard)) {
      throw CannotDiscardException();
    }

    assert(game.playerHands.containsKey(user.firebaseId),
        "User is marked as a player but has no hand!");
    final playerHands = {...game.playerHands};

    final playerHand = [...playerHands[user.firebaseId]!];
    playerHand.remove(cardToDiscard);
    playerHands[user.firebaseId] = playerHand;

    final deadwoods = <FirebaseID, int>{};
    final matched = <FirebaseID, List<List<Card>>>{};
    final deadCards = <FirebaseID, List<Card>>{};
    for (final entry in playerHands.entries) {
      final hand = [...entry.value];
      final matches = GinRummyLogic.getMatched(hand);
      final deadwood = GinRummyLogic.getDeadwood(hand, matches);
      final score = GinRummyLogic.calculateDeadwood(deadwood);

      deadwoods[entry.key] = score;
      matched[entry.key] = matches;
      deadCards[entry.key] = deadwood;
    }

    if (deadwoods[user.firebaseId]! > 10) {
      throw CannotKnockException();
    }

    // There are only ever two players in Gin Rummy
    var myMatched = matched.remove(user.firebaseId);
    var oppMatched = matched.values.first;
    var myDead = deadCards.remove(user.firebaseId);
    var oppDead = deadCards.values.first;

    myMatched = GinRummyLogic.addAfterKnock(oppDead, myMatched!);
    List<Card> pHand = [];
    for (List<Card> cards in myMatched) {
      pHand.addAll(cards);
    }
    pHand.addAll(myDead!);
    playerHands[user.firebaseId] = pHand;
    List<Card> oHand = [];
    for (List<Card> cards in oppMatched) {
      oHand.addAll(cards);
    }
    oHand.addAll(oppDead);
    var opp =
        game.players.where((player) => player.firebaseId != user.firebaseId);
    playerHands[opp.first.firebaseId] = oHand;

    final myScore = deadwoods.remove(user.firebaseId)!;
    final otherPlayerScore = GinRummyLogic.calculateDeadwood(oppDead);

    final playerScores = {...game.playerScores};
    int updatedScore;
    if (myScore < otherPlayerScore) {
      roundWinner = user;
      updatedScore = playerScores.update(
          user.firebaseId, (value) => value + (otherPlayerScore - myScore));
      // Account for Gin
      if (myScore == 0) {
        updatedScore =
            playerScores.update(user.firebaseId, (value) => value + 25);
      }
    } else {
      roundWinner = game.getOpponent(user);
      updatedScore = playerScores.update(deadwoods.keys.first,
          (value) => value + 25 + (myScore - otherPlayerScore));
    }

    User? playerKnocking;
    User? playerGinning;
    if (myScore < otherPlayerScore) {
      roundWinner = user;
      if (myScore == 0) {
        playerGinning = user;
        playerKnocking = null;
      } else {
        playerGinning = null;
        playerKnocking = user;
      }
    } else {
      final opponent = game.getOpponent(user);
      roundWinner = opponent;
      if (otherPlayerScore == 0) {
        playerGinning = opponent;
        playerKnocking = null;
      } else {
        playerGinning = null;
        playerKnocking = opponent;
      }
    }

    await _optimisticStateUpdate(
      game.copyWith(
          playerScores: playerScores,
          playerHands: playerHands,
          gameStatus:
              updatedScore >= 100 ? GameStatus.finished : GameStatus.roundEnded,
          playerKnocking: playerKnocking,
          playerGinning: playerGinning,
          currentPlayer: roundWinner),
      db,
    );
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
        GinRummyGameModel.newGame(lobbyCode, convertedUser, rng: Random(seed));

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
    assert(discardPile.isNotEmpty, "Cannot draw from an empty discard pile!");
    assert(playerHands.containsKey(user.firebaseId),
        "User is in game but does not have a hand!");
    final drawnCard = discardPile.removeLast();
    playerHands[user.firebaseId] = [
      ...playerHands[user.firebaseId]!,
      drawnCard
    ];

    await _optimisticStateUpdate(
      game.copyWith(
          discardPile: discardPile,
          playerHands: playerHands,
          drawnCard: drawnCard),
      db,
    );
  }

  @override
  Future<void> drawDrawPile(User user) async {
    final db = ref.read(databaseRepositoryProvider);
    final game = state.asData?.value;
    _checkCanDraw(user);
    if (game!.isFirstTurn || (game.isSecondTurn && game.firstPlayerPassed)) {
      throw DrawNotAllowedException();
    }

    final playerHands = {...game.playerHands};
    final drawPile = [...game.drawPile];

    assert(drawPile.isNotEmpty, "Cannot draw from an empty draw pile");
    assert(playerHands.containsKey(user.firebaseId),
        "User is in game but does not have a hand!");
    // Map.from only does a shallow clone, so we get the same reference
    // to the actual list, except it's now modifiable.
    // To prevent accidental modification, we instead create a copy here.
    final drawnCard = drawPile.removeLast();
    playerHands[user.firebaseId] = [
      ...playerHands[user.firebaseId]!,
      drawnCard
    ];

    if (drawPile.isEmpty) {
      // Shuffle all but top card of discard into draw pile.
      final pile = List<Card>.from(game.discardPile);
      final topCard = pile.removeLast();
      pile.shuffle(Random(seed));
      await _optimisticStateUpdate(
        game.copyWith(
            discardPile: [topCard],
            drawPile: pile,
            playerHands: playerHands,
            drawnCard: drawnCard),
        db,
      );
    } else {
      await _optimisticStateUpdate(
        game.copyWith(
            drawPile: drawPile, playerHands: playerHands, drawnCard: drawnCard),
        db,
      );
    }
  }

  /// Checks a variety of criteria to make sure a player is allowed to
  /// draw.
  void _checkCanDraw(User user) {
    _checkBasicConditions(user);
    final game = state.asData!.value!;
    if (game.playerHands[user.firebaseId]!.length == 11) {
      throw DrawNotAllowedException();
    }
  }

  @override
  Future<void> discardCard(Card card, User user) async {
    final db = ref.read(databaseRepositoryProvider);
    final game = state.asData?.value;
    _checkBasicConditions(user);

    final playerHands = {...game!.playerHands};
    assert(playerHands.containsKey(user.firebaseId),
        "User is marked as a player but does not have a hand");
    final discardPile = [...game.discardPile];
    final playerHand = [...playerHands[user.firebaseId]!];

    if (!playerHand.contains(card)) {
      throw InvalidCardDiscardedException();
    } else if (playerHand.length != 11) {
      throw CannotDiscardException();
    }
    playerHand.remove(card);
    playerHands[user.firebaseId] = playerHand;
    discardPile.add(card);

    // Gin Rummy games always have two players, bot or human.
    final nextPlayer = game.players[((game.players.indexOf(user) + 1) % 2)];

    await _optimisticStateUpdate(
      game.copyWith(
          currentPlayer: nextPlayer,
          playerHands: playerHands,
          discardPile: discardPile,
          drawnCard: null,
          isFirstTurn: false,
          isSecondTurn: game.isFirstTurn),
      db,
    );
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

  Future<void> _optimisticStateUpdate(
      GinRummyGameModel? newState, DatabaseRepository db) async {
    final previous = state;

    if (newState == null) {
      state = AsyncError(GameDeletedException(), StackTrace.current);
      return;
    } else {
      state = AsyncData(newState);
    }
    try {
      await db.updateGinRummyGame(newState);
    } catch (e) {
      state = previous;
    }
  }

  @override
  (String, Map<String, String>) getGameRoutingInfo() {
    return (
      GameType.ginRummy.onlineRouteName,
      {"lobbyCode": lobbyCode},
    );
  }

  @override
  (String, Map<String, String>) getLobbyRoutingInfo() {
    return (
      LobbyPage.routeName,
      {"gameType": GameType.ginRummy.toString(), "lobbyCode": lobbyCode},
    );
  }
}