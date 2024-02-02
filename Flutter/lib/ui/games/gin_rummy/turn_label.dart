import 'dart:math';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/gin_rummy_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TurnLabel extends ConsumerWidget {
  final GinRummyNotifierProvider provider;
  final String lobbyCode;

  TurnLabel(this.lobbyCode, this.provider, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    final (opponent, currentPlayer, gameStatus) =
        ref.watch(provider(lobbyCode).select((value) {
      final game = value.asData!.value!;

      return (
        game.players.firstWhere((element) => element != user),
        game.currentPlayer,
        game.gameStatus
      );
    }));
    final roundEnded = gameStatus == GameStatus.roundEnded;
    String message;

    if (gameStatus == GameStatus.finished) {
      message = "Game Over";
    } else if (!roundEnded && currentPlayer == user) {
      message = "Your Turn";
    } else if (!roundEnded && currentPlayer == opponent) {
      final opponentName = opponent.displayName
              ?.substring(0, min(10, opponent.displayName?.length ?? 10)) ??
          "Opponent";
      message = "$opponentName's Turn";
    } else {
      message = "Round Ended";
    }

    return Text(message, style: Theme.of(context).textTheme.titleLarge);
  }
}
