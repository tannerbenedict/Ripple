import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/scum_notifier.dart';
import 'package:ripple/providers/game_providers/scum_notifier_online.dart';
import 'package:ripple/providers/game_providers/scum_notifier_solo.dart';
import 'package:ripple/ui/games/fanned_hand.dart';
import 'package:ripple/ui/games/hearts/player_avatar.dart';
import 'package:ripple/ui/games/scum/position_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpponentSection extends ConsumerWidget {
  final String lobbyCode;
  final User opponent;
  final double rotationAngle;

  const OpponentSection({
    required this.opponent,
    required this.lobbyCode,
    required this.rotationAngle,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScumNotifierProvider provider = scumOnlineNotifierProvider.call;
    if (lobbyCode == "") {
      provider = scumSoloNotifierProvider.call;
    }
    final (isPlayerTurn, position) =
        ref.watch(provider(lobbyCode).select((value) {
      final result = value.asData!.value!;
      return (
        result.currentPlayer?.firebaseId == opponent.firebaseId,
        result.positions[opponent.firebaseId]
      );
    }));
    return LayoutBuilder(builder: (context, constraints) {
      assert(constraints.hasBoundedHeight && constraints.hasBoundedWidth,
          "OpponentSection must have bounded height and width");
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PositionIcon(position: position),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: PlayerAvatar(
                  player: opponent,
                  isPlayerTurn: isPlayerTurn,
                ),
              ),
              Text(opponent.displayName?.truncate() ?? "Opponent"),
            ],
          ),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FannedHand(
              gameNotifierProvider: provider,
              lobbyCode: lobbyCode,
              player: opponent,
              maxRotationAngle: 5.0,
              cardOverlap: 0.25,
              shiftCards: false,
            ),
          ))
        ],
      );
    });
  }
}
