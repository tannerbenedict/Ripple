import 'dart:async';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/hearts_notifier.dart';
import 'package:ripple/providers/game_providers/hearts_notifier_online.dart';
import 'package:ripple/providers/game_providers/hearts_notifier_solo.dart';
import 'package:ripple/ui/games/hearts/online_discard_pile.dart';
import 'package:ripple/ui/games/hearts/player_avatar.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Side {
  left,
  right,
}

class PlayerSection extends ConsumerWidget {
  final Side infoSide;
  final String lobbyCode;
  final User player;
  final Offset disappearOffset;
  final FutureOr<void> Function(Card)? handleDiscard;

  const PlayerSection({
    super.key,
    required this.infoSide,
    required this.player,
    required this.lobbyCode,
    required this.disappearOffset,
    this.handleDiscard,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HeartsNotifierProvider provider = heartsOnlineNotifierProvider.call;
    if (lobbyCode == "") {
      provider = heartsSoloNotifierProvider.call;
    }
    final (isPlayerTurn, playerScore, cardDiscarded) =
        ref.watch(provider(lobbyCode).select((value) => value.maybeWhen(
              orElse: () => (false, 0, null),
              data: (data) => (
                data!.currentPlayer == player,
                data.playerScores[player.firebaseId],
                data.playerDiscards[player.firebaseId]
              ),
            )));

    final style = Theme.of(context).textTheme.bodySmall;

    final playerInfo = Flexible(
      fit: FlexFit.tight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Center(
              child: Text(
                "Score: $playerScore",
                style: style,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: PlayerAvatar(player: player, isPlayerTurn: isPlayerTurn),
          ),
          Flexible(
              fit: FlexFit.tight,
              child: Text(
                player.displayName?.truncate() ?? "Opponent",
                style: style,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );

    final discardPile = Flexible(
      fit: FlexFit.tight,
      child: OnlineDiscardPile(
        topCard: cardDiscarded,
        handleDiscard: handleDiscard,
        disappearOffset: disappearOffset,
      ),
    );

    switch (infoSide) {
      case Side.left:
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              playerInfo,
              discardPile,
              Spacer(),
            ]);
      case Side.right:
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              discardPile,
              playerInfo,
            ]);
    }
  }
}
