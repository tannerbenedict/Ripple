import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/database_models/two_player_game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/friend_providers/friend_requests_provider.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/game_providers/two_player_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/ripple_bot_logic.dart';
import 'package:ripple/ui/games/two_player/active_pile.dart';
import 'package:ripple/ui/games/two_player/discard_pile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:math';

import 'package:ripple/app/router.dart';
import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/providers/database_provider.dart';

part 'two_player_notifier_solo.g.dart';

const botDelay = Duration(seconds: 1);

@riverpod
class TwoPlayerSoloNotifier extends _$TwoPlayerSoloNotifier
    implements TwoPlayerNotifier<TwoPlayerGameModel?> {
  var _runningBotTurn = false;

  @override
  Future<TwoPlayerGameModel?> build(String lobbyCode, {int? seed}) async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    var newGame = TwoPlayerGameModel.newGame(
            lobbyCode, User.getRealOrDefaultUser(user),
            rng: Random(seed))
        .addPlayer(User.defaultBot(0));

    ref.listenSelf((previous, next) async {
      if (previous == next ||
          next.asData?.value == null ||
          _runningBotTurn == true) {
        return;
      }

      final game = next.asData!.value!;

      if (game.gameStatus == GameStatus.playing && game.currentPlayer!.isBot) {
        _runningBotTurn = true;
        await _takeBotTurn(game);
        _runningBotTurn = false;
      }
    });

    final shuffled = newGame.startNewGame(rng: Random(seed));
    await _optimisticStateUpdate(shuffled);
    return shuffled;
  }

  Future<void> _takeBotTurn(TwoPlayerGameModel game) async {
    await Future.delayed(botDelay);

    if (game.isFirstTurn || game.isSecondTurn) {
      await flipCards(User.defaultBot(0));
      return;
    } else if (RippleLogic.takeDiscard(
      game.discardPile,
      game.playerHands["bot0"]!,
    )) {
      // We need the most up to date version of the provider, not this current
      // one. Otherwise, we're using the wrong game state in later calls.
      await ref
          .read(twoPlayerSoloNotifierProvider(lobbyCode).notifier)
          .drawDiscardPile(User.defaultBot(0));
    } else {
      await ref
          .read(twoPlayerSoloNotifierProvider(lobbyCode).notifier)
          .botDrawDrawPile(User.defaultBot(0));
    }
    //Card discard = GinRummyLogic.getCardToDiscard(bMatches, botDWood);

    await Future.delayed(botDelay);
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

    await _optimisticStateUpdate(newGame);
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
    } else if (game.gameStatus != GameStatus.pending) {
      throw GameNotJoinableException();
    }

    final updatedGame = game.addPlayer(User.fromFirebaseUser(user));
    await _optimisticStateUpdate(updatedGame);
  }

  @override
  Future<void> startGame() async {
    final game = state.asData?.value;
    if (game == null) {
      throw GameNotFoundException();
    } else if (game.gameStatus != GameStatus.inLobby) {
      throw GameNotStartableException();
    }

    await _optimisticStateUpdate(game.startNewGame(rng: Random(seed)));
  }

  @override
  Future<void> flipCards(User user) async {
    final game = state.asData?.value;
    _checkBasicConditions(user);
    if ((!game!.isFirstTurn && !game.isSecondTurn)) {
      throw CannotPassException();
    }
    final playerHands = {...game.playerHands};
    final playerHand = [...playerHands[user.firebaseId]!];
    playerHand[6] = Card(
        faceValue: playerHand[6].faceValue,
        id: playerHand[6].id,
        isFlipped: true);
    playerHand[2] = Card(
        faceValue: playerHand[2].faceValue,
        id: playerHand[2].id,
        isFlipped: true);
    playerHand[8] = Card(
        faceValue: playerHand[8].faceValue,
        id: playerHand[8].id,
        isFlipped: true);
    playerHands[user.firebaseId] = playerHand;
    final nextPlayer = game.players[(game.players.indexOf(user) + 1) % 2];

    await _optimisticStateUpdate(game.copyWith(
      currentPlayer: nextPlayer,
      playerHands: playerHands,
      isFirstTurn: false,
      // If we're the first player, then we obviously passed. If we're
      // the second, player the only way we could get this far is if the
      // first player passed, so, this is always true.
      isSecondTurn: !game.isSecondTurn,
    ));
  }

  @override
  Future<void> userFlipCard(User user, int index) async {
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
    await _optimisticStateUpdate(game.copyWith(
      currentPlayer: nextPlayer,
      playerHands: playerHands,
      isFirstTurn: endTurn,
      cardsFlipped: flipped,
      // If we're the first player, then we obviously passed. If we're
      // the second, player the only way we could get this far is if the
      // first player passed, so, this is always true.
      isSecondTurn: !game.isSecondTurn,
    ));
  }

  @override
  Future<void> notPlayingAgain() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    } else if (user == null) {
      throw UserRequiredError();
    }

    await _optimisticStateUpdate(
        game.notPlayingAgain(User.fromFirebaseUser(user)));
  }

  @override
  Future<void> playingAgain() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    } else if (user == null) {
      throw UserRequiredError();
    }

    await _optimisticStateUpdate(
        game.playingAgain(User.fromFirebaseUser(user)));
  }

  @override
  Future<void> startNewRound() async {
    final game = state.asData?.value;
    User? firstPlayer = game?.currentPlayer;
    if (game == null) {
      throw GameNotFoundException();
    } else if (game.gameStatus != GameStatus.roundEnded) {
      throw RoundNotStartableException();
    }

    await _optimisticStateUpdate(
      game.newRound(rng: Random(seed), firstPlayer: firstPlayer).startGame(),
    );
  }

  @override
  Future<void> playGameAgain() async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    if (user == null) {
      throw UserRequiredError();
    }
    final convertedUser = User.fromFirebaseUser(user);
    final newGame =
        TwoPlayerGameModel.newGame(lobbyCode, convertedUser, rng: Random(seed));

    await _optimisticStateUpdate(
      newGame.addPlayer(convertedUser).startGame(),
    );
  }

  @override
  Future<void> drawDiscardPile(User user) async {
    final game = state.asData?.value;
    _checkCanDraw(user);

    final playerHands = {...game!.playerHands};
    final discardPile = [...game.discardPile];
    final activePile = [...game.activePile];
    final playerHand = [...playerHands[user.firebaseId]!];
    assert(discardPile.isNotEmpty, "Cannot draw from an empty discard pile!");
    assert(playerHands.containsKey(user.firebaseId),
        "User is in game but does not have a hand!");
    final drawnCard = discardPile.removeLast();
    final cardIndex =
        RippleLogic.playIndex(playerHands[user.firebaseId]!, drawnCard);
    activePile.add(Card(
        faceValue: playerHand[cardIndex].faceValue,
        isFlipped: true,
        id: playerHand[cardIndex].id));
    playerHand[cardIndex] =
        Card(faceValue: drawnCard.faceValue, isFlipped: true, id: drawnCard.id);
    playerHands[user.firebaseId] = playerHand;

    if (RippleLogic.takeDiscard(activePile, playerHand)) {
      drawActivePile(user, activePile, playerHand);
    } else {
      botDiscardCard(user, activePile, playerHand);
    }
  }

  @override
  Future<void> drawActivePile(
      User user, List<Card> activePile, List<Card> playerHand) async {
    final game = state.asData?.value;

    final playerHands = {...game!.playerHands};
    final drawnCard = activePile.removeLast();
    final cardIndex = RippleLogic.playIndex(playerHand, drawnCard);
    activePile.add(Card(
        faceValue: playerHand[cardIndex].faceValue,
        isFlipped: true,
        id: playerHand[cardIndex].id));
    playerHand[cardIndex] = playerHand[cardIndex] =
        Card(faceValue: drawnCard.faceValue, isFlipped: true, id: drawnCard.id);
    playerHands[user.firebaseId] = playerHand;
    if (RippleLogic.takeDiscard(activePile, playerHand)) {
      drawActivePile(user, activePile, playerHand);
    } else {
      botDiscardCard(user, activePile, playerHand);
    }
  }

  @override
  Future<void> drawDrawPile(User user) async {
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
            drawnCard: drawnCard),
      );
    } else {
      await _optimisticStateUpdate(
        game.copyWith(
            currentPlayer: nextPlayer,
            drawPile: drawPile,
            activePile: activePile,
            drawnCard: drawnCard),
      );
    }
  }

  @override
  Future<void> botDrawDrawPile(User user) async {
    final game = state.asData?.value;
    _checkCanDraw(user);
    if (game!.isFirstTurn || game.isSecondTurn) {
      throw DrawNotAllowedException();
    }
    final playerHands = {...game.playerHands};
    final activePile = [...game.activePile];
    final drawPile = [...game.drawPile];
    final playerHand = [...playerHands[user.firebaseId]!];
    assert(drawPile.isNotEmpty, "Cannot draw from an empty draw pile");
    // Map.from only does a shallow clone, so we get the same reference
    // to the actual list, except it's now modifiable.
    // To prevent accidental modification, we instead create a copy here.
    final drawnCard = drawPile.removeLast();
    activePile.add(Card(
        faceValue: drawnCard.faceValue, isFlipped: true, id: drawnCard.id));
    final nextPlayer = game.players[(game.players.indexOf(user))];
    if (RippleLogic.takeDiscard(activePile, playerHand)) {
      drawActivePile(user, activePile, playerHand);
    } else {
      botDiscardCard(user, activePile, playerHand);
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
  Future<void> discardCard(Card card, User user) async {
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
    );
  }

  @override
  Future<void> botDiscardCard(
      User user, List<Card> activePile, List<Card> playerHand) async {
    final game = state.asData?.value;
    _checkBasicConditions(user);
    final playerHands = {...game!.playerHands};
    final discardPile = [...game!.discardPile];

    if (activePile.isEmpty) {
      throw CannotDiscardException();
    }
    final discarded = activePile.removeLast();
    discardPile.add(discarded);
    playerHands[user.firebaseId] = playerHand;
    // Gin Rummy games always have two players, bot or human.
    final nextPlayer = game.players[((game.players.indexOf(user) + 1) % 2)];

    await _optimisticStateUpdate(
      game.copyWith(
          currentPlayer: nextPlayer,
          activePile: activePile,
          discardPile: discardPile,
          playerHands: playerHands,
          drawnCard: null,
          isFirstTurn: false,
          canRipple: true,
          firstPlay: true,
          isSecondTurn: game.isFirstTurn),
    );
  }

  @override
  Future<void> placeCard(Card card, User user, int index) async {
    final game = state.asData?.value;
    _checkBasicConditions(user);

    final playerHands = {...game!.playerHands};
    assert(playerHands.containsKey(user.firebaseId),
        "User is marked as a player but does not have a hand");
    final activePile = [...game.activePile];
    final discardPile = [...game.discardPile];
    final playerHand = [...playerHands[user.firebaseId]!];
    bool canRipple = game.canRipple;
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

    // Gin Rummy games always have two players, bot or human.
    //final nextPlayer = game.players[((game.players.indexOf(user) + 1) % 2)];

    await _optimisticStateUpdate(
      game.copyWith(
        playerHands: playerHands,
        activePile: activePile,
        discardPile: discardPile,
        canRipple: canRipple,
        drawnCard: null,
        firstPlay: false,
      ),
    );
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

  Future<void> _optimisticStateUpdate(TwoPlayerGameModel game) async {
    state = AsyncData(game);
  }

  @override
  (String, Map<String, String>) getGameRoutingInfo() {
    return (
      GameType.twoPlayer.soloRouteName,
      {},
    );
  }

  @override
  (String, Map<String, String>) getLobbyRoutingInfo() {
    return getGameRoutingInfo();
  }

  @override
  Future<void> updateHost() async {
    return Future.value();
  }
}
