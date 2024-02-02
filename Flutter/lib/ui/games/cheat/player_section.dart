import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/cheat_notifier.dart';
import 'package:ripple/ui/games/hearts/player_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlayerSection extends ConsumerWidget {
  final String lobbyCode;
  final User player;
  final CheatNotifierProvider provider;

  const PlayerSection({
    super.key,
    required this.lobbyCode,
    required this.player,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (isPlayerTurn, playerScore, playerHandLength, calledCheat) =
        ref.watch(provider(lobbyCode).select((value) => value.maybeWhen(
              orElse: () => (false, 0, 0, null),
              data: (data) => (
                data!.currentPlayer == player,
                data.playerScores[player.firebaseId]!,
                data.playerHands[player.firebaseId]!.length,
                data.playerWhoCalledCheat == player && data.calledCheat,
              ),
            )));

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayerAvatar(player: player, isPlayerTurn: isPlayerTurn),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Icon(MdiIcons.cardsPlayingOutline),
                ),
                Text(
                  "$playerHandLength",
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                )
              ],
            ),
            Text(player.displayName?.truncate(maxLength: 10) ?? "Opponent"),
            Text("Score: $playerScore"),
          ],
        ),
        if (calledCheat ?? false)
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text("Cheat!"),
              ),
            ).animate().fadeIn(duration: 400.ms, curve: Curves.easeOutCubic),
          ),
      ],
    );
  }
}
