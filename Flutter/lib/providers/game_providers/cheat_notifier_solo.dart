import 'dart:math';

import 'package:ripple/app/router.dart';
import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/cheat_game_model.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/cheat_notifier.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/cheat/cheat_bot_logic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cheat_notifier_solo.g.dart';

const botDelay = Duration(seconds: 1, milliseconds: 500);
const cheatCalledDelay = Duration(seconds: 2);

@riverpod
class CheatSoloNotifier extends _$CheatSoloNotifier
    implements CheatNotifier<CheatGameModel?> {
  @override
  Future<CheatGameModel?> build(String lobbyCode, {int? seed}) async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    var newGame = CheatGameModel.newGame(
        lobbyCode, User.getRealOrDefaultUser(user), Random(seed));

    for (int i = 0; i < 7; i++) {
      newGame = newGame.addPlayer(User.defaultBot(i));
    }

    ref.listenSelf((previous, next) async {
      if (previous == next || next.isLoading) {
        return;
      } else if (next.asData?.value == null) {
        return;
      }

      var updatedGame = next.asData?.value;

      if (updatedGame == null) {
        return;
      }

      final possibleBot = updatedGame.turnOrder[updatedGame.currentIndex];
      if (!possibleBot.isBot) {
        return;
      }
      _takeBotTurn(updatedGame, possibleBot);
    });

    final shuffled = newGame.startGame().shuffleCards(rng: Random(seed));
    return shuffled;
  }

  Future<void> _takeBotTurn(CheatGameModel updatedGame, User bot) async {
    // We're waiting for the after cheat/round end update to be called at this point,
    // so just return.
    if (updatedGame.calledCheat ||
        updatedGame.isRoundEnd ||
        updatedGame.gameStatus != GameStatus.playing) {
      return;
    }
    await Future.delayed(botDelay);
    var prevPlayer = updatedGame.currentIndex - 1 >= 0
        ? updatedGame.playerHands[
            updatedGame.turnOrder[updatedGame.currentIndex - 1].firebaseId]!
        : updatedGame.playerHands[bot.firebaseId]!;
    if (CheatLogic.getIfBotCallsCheat(
            updatedGame.currentFaceValue - 1,
            updatedGame.numPlayedPrevious,
            updatedGame.cardsPlayed,
            prevPlayer,
            updatedGame.playerHands[bot.firebaseId]!) &&
        updatedGame.cardsPlayed.isNotEmpty) {
      updatedGame = updatedGame
          .callCheat(updatedGame.turnOrder[updatedGame.currentIndex]);
      await _optimisticStateUpdate(updatedGame);

      await Future.delayed(cheatCalledDelay);

      updatedGame = updatedGame.updateAfterCheatCalled(bot);
      await _optimisticStateUpdate(updatedGame);
    } else {
      List<Card> cardsToPlay = CheatLogic.getCardsToPlay(
          updatedGame.currentFaceValue,
          updatedGame.playerHands[bot.firebaseId]!);

      updatedGame = updatedGame.discardCards(cardsToPlay, bot);

      await _optimisticStateUpdate(updatedGame);

      if (updatedGame.isRoundEnd) {
        await Future.delayed(Duration(seconds: 3));
        await _optimisticStateUpdate(updatedGame.roundEnd());
      }
    }
  }

  @override
  Future<void> discardCards(User user, List<Card> cards) async {
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    }

    var updatedGame = game.discardCards(cards, user);
    await _optimisticStateUpdate(updatedGame);

    if (updatedGame.isRoundEnd) {
      await Future.delayed(Duration(seconds: 3));
      await _optimisticStateUpdate(updatedGame.roundEnd());
    }
  }

  @override
  Future<void> callCheat(User user) async {
    final game = state.asData?.value;

    if (game == null) {
      throw GameNotFoundException();
    }

    var updatedGame = game.callCheat(user);
    await _optimisticStateUpdate(updatedGame);

    await Future.delayed(cheatCalledDelay);

    updatedGame = updatedGame.updateAfterCheatCalled(user);
    await _optimisticStateUpdate(updatedGame);
  }

  Future<void> _optimisticStateUpdate(CheatGameModel game) async {
    state = AsyncData(game);
  }

  @override
  (String, Map<String, String>) getGameRoutingInfo() {
    return (GameType.cheat.soloRouteName, {});
  }

  @override
  (String, Map<String, String>) getLobbyRoutingInfo() {
    return getGameRoutingInfo();
  }

  @override
  Future<void> createNewGame() {
    throw UnimplementedError();
  }

  @override
  Future<void> joinGame() {
    throw UnimplementedError();
  }

  @override
  Future<void> startGame() {
    throw UnimplementedError();
  }

  @override
  Future<void> notPlayingAgain() {
    return Future.value();
  }

  @override
  Future<void> playingAgain() {
    return Future.value();
  }

  @override
  Future<void> updateHost() async {
    return Future.value();
  }
}
