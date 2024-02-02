import 'dart:math';

import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/gin_rummy_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActionMessage extends ConsumerWidget {
  final GinRummyNotifierProvider provider;
  final String lobbyCode;

  const ActionMessage(this.lobbyCode, this.provider, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    final (roundEnded, opponent, userGinning, userKnocking) =
        ref.watch(provider(lobbyCode).select((value) {
      final game = value.asData!.value!;

      return (
        game.gameStatus == GameStatus.finished ||
            game.gameStatus == GameStatus.roundEnded,
        game.players.firstWhere((element) => element != user),
        game.playerGinning,
        game.playerKnocking
      );
    }));

    String message;
    if (roundEnded && userGinning == user && userGinning != null) {
      message = "Gin";
    } else if (roundEnded && userGinning != user && userGinning != null) {
      message = "Gin";
    } else if (roundEnded && userKnocking == user && userKnocking != null) {
      message = "Knock";
    } else if (roundEnded && userKnocking != user && userKnocking != null) {
      message = "Knock";
    } else {
      message = "";
    }

    return Text(message, style: Theme.of(context).textTheme.titleLarge);
  }
}
