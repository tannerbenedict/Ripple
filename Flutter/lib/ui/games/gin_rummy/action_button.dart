import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/gin_rummy_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/gin_rummy/gin_rummy_bot_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActionButton extends ConsumerWidget {
  final GinRummyNotifierProvider provider;
  final String lobbyCode;

  ActionButton(this.lobbyCode, this.provider, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));

    final (
      playersTurn,
      isFirstTurn,
      isSecondTurn,
      firstPlayerPassed,
      playerScore,
      playerHand,
      gameStatus
    ) = ref.watch(provider(lobbyCode).select((value) {
      final data = value.asData!.value!;

      return (
        data.currentPlayer == user,
        data.isFirstTurn,
        data.isSecondTurn,
        data.firstPlayerPassed,
        data.calcPlayerDeadwood(user),
        data.playerHands[user.firebaseId]!,
        data.gameStatus
      );
    }));
    final playerMatched = GinRummyLogic.getMatched(playerHand);
    final playerDeadwood = GinRummyLogic.getDeadwood(playerHand, playerMatched);

    if ((playersTurn && isFirstTurn && playerHand.length == 10) ||
        (playersTurn &&
            isSecondTurn &&
            firstPlayerPassed &&
            playerHand.length == 10)) {
      return ElevatedButton(
        onPressed: () async {
          await ref.read(provider(lobbyCode).notifier).passTurn(user);
        },
        child: Text(
          'Pass',
        ),
      );
    } else if (playersTurn &&
        playerScore == 0 &&
        gameStatus != GameStatus.roundEnded &&
        playerHand.length == 11) {
      return ElevatedButton(
          onPressed: () async {
            final cardToDiscard =
                GinRummyLogic.getCardToDiscard(playerMatched, playerDeadwood);
            await ref
                .read(provider(lobbyCode).notifier)
                .knock(cardToDiscard, user);
          },
          child: Text(
            'GIN',
          ));
    } else if (gameStatus == GameStatus.roundEnded) {
      return ElevatedButton(
          onPressed: () async {
            await ref.read(provider(lobbyCode).notifier).startNewRound();
          },
          child: Text(
            "Next Round",
          ));
    } else {
      return ElevatedButton(
        onPressed: playersTurn &&
                playerScore <= 10 &&
                playerScore != 0 &&
                playerHand.length == 11 &&
                gameStatus != GameStatus.roundEnded
            ? () async {
                final cardToDiscard = GinRummyLogic.getCardToDiscard(
                    playerMatched, playerDeadwood);
                await ref
                    .read(provider(lobbyCode).notifier)
                    .knock(cardToDiscard, user);
              }
            : null,
        child: Text(
          'Knock',
        ),
      );
    }
  }
}
