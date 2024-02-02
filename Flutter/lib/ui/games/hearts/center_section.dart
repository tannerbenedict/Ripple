import 'dart:async';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/hearts_notifier.dart';
import 'package:ripple/providers/game_providers/hearts_notifier_online.dart';
import 'package:ripple/providers/game_providers/hearts_notifier_solo.dart';
import 'package:ripple/ui/games/hearts/player_section.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CenterSection extends ConsumerWidget {
  final String lobbyCode;
  final User leftPlayer;
  final User rightPlayer;
  final User topPlayer;
  final User bottomPlayer;
  final bool broken;
  final FutureOr<void> Function(Card)? handleDiscard;

  const CenterSection({
    super.key,
    required this.lobbyCode,
    required this.leftPlayer,
    required this.rightPlayer,
    required this.topPlayer,
    required this.bottomPlayer,
    required this.broken,
    required this.handleDiscard,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HeartsNotifierProvider provider = heartsOnlineNotifierProvider.call;
    if (lobbyCode == "") {
      provider = heartsSoloNotifierProvider.call;
    }
    final (
      leftPlayerCard,
      rightPlayerCard,
      topPlayerCard,
      bottomPlayerCard,
      firstPlayer
    ) = ref.watch(provider(lobbyCode).select((value) => value.maybeWhen(
          orElse: () => (null, null, null, null, null),
          data: (data) {
            return (
              data!.playerDiscards[leftPlayer.firebaseId],
              data.playerDiscards[rightPlayer.firebaseId],
              data.playerDiscards[topPlayer.firebaseId],
              data.playerDiscards[bottomPlayer.firebaseId],
              data.firstPlayer,
            );
          },
        )));

    var left = Offset(-1, 0);
    var top = Offset(0, -1);
    var right = Offset(1, 0);
    var bottom = Offset(0, 1);
    Offset? disappearOffset;

    // Someone just won the trick, we need to make the cards disappear
    if (leftPlayerCard == null &&
        rightPlayerCard == null &&
        topPlayerCard == null &&
        bottomPlayerCard == null &&
        firstPlayer != null) {
      if (firstPlayer == leftPlayer) {
        disappearOffset = Offset(-1, 0);
      } else if (firstPlayer == rightPlayer) {
        disappearOffset = Offset(1, 0);
      } else if (firstPlayer == topPlayer) {
        disappearOffset = Offset(0, -1);
      } else if (firstPlayer == bottomPlayer) {
        disappearOffset = Offset(0, 1);
      } else {
        throw Exception('Invalid first player');
      }

      left = disappearOffset;
      top = disappearOffset;
      right = disappearOffset;
      bottom = disappearOffset;
    }

    return Column(
      children: [
        // Top player
        Flexible(
          child: Row(
            children: [
              Spacer(),
              Flexible(
                flex: 2,
                child: PlayerSection(
                  infoSide: Side.left,
                  lobbyCode: lobbyCode,
                  player: topPlayer,
                  disappearOffset: top,
                ),
              ),
              Spacer(),
            ],
          ),
        ),

        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: PlayerSection(
                  infoSide: Side.left,
                  lobbyCode: lobbyCode,
                  player: leftPlayer,
                  disappearOffset: left,
                ),
              ),
              broken
                  ? Flexible(
                      child: Icon(Icons.heart_broken, color: Colors.red)
                          .animate()
                          .fadeIn(duration: const Duration(milliseconds: 500)))
                  : Spacer(),
              Flexible(
                flex: 2,
                child: PlayerSection(
                  infoSide: Side.right,
                  lobbyCode: lobbyCode,
                  player: rightPlayer,
                  disappearOffset: right,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Flexible(
                flex: 2,
                child: PlayerSection(
                  handleDiscard: handleDiscard,
                  infoSide: Side.left,
                  lobbyCode: lobbyCode,
                  player: bottomPlayer,
                  disappearOffset: bottom,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
