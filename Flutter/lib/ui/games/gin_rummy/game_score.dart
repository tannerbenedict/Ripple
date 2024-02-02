import 'dart:math';

import 'package:ripple/models/user.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ripple/providers/game_providers/gin_rummy_notifier.dart';

class GameScore extends ConsumerWidget {
  final GinRummyNotifierProvider provider;
  final String lobbyCode;

  const GameScore(this.lobbyCode, this.provider, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    final (opponent,) = ref.watch(provider(lobbyCode).select((value) {
      final game = value.asData!.value!;

      return (game.players.firstWhere((element) => element != user),);
    }));
    final opponentName = opponent.displayName
            ?.substring(0, min(10, opponent.displayName?.length ?? 10)) ??
        "Opponent";
    final scores = ref.watch(provider(lobbyCode)
        .select((value) => value.asData!.value!.playerScores));

    final playerScore = scores[user.firebaseId]!.toString();
    final opponentScore = scores.entries
        .firstWhere((element) => element.key != user.firebaseId)
        .value
        .toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "$opponentName: $opponentScore",
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.end,
        ),
        Text(
          "You: $playerScore",
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
