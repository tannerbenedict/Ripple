import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/hearts_notifier.dart';
import 'package:ripple/providers/game_providers/hearts_notifier_online.dart';
import 'package:ripple/providers/game_providers/hearts_notifier_solo.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../fanned_hand.dart';

class TopSection extends ConsumerWidget {
  final String lobbyCode;
  final User player;
  final Duration animationDuration;
  final bool isPlayerTurn;

  const TopSection({
    super.key,
    required this.lobbyCode,
    required this.player,
    required this.isPlayerTurn,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HeartsNotifierProvider provider = heartsOnlineNotifierProvider.call;
    if (lobbyCode == "") {
      provider = heartsSoloNotifierProvider.call;
    }
    User currentUser = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    final (startOfTrick, startOfRound, trickWinner) =
        ref.read(provider(lobbyCode).select(
      (value) => value.maybeWhen(
        orElse: () => (false, false, null),
        data: (data) =>
            (data!.startOfTrick, data.startOfRound, data.firstPlayer),
      ),
    ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: SizedBox.expand(),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: RotatedBox(
            quarterTurns: 2,
            child: FannedHand(
              gameNotifierProvider: provider,
              lobbyCode: lobbyCode,
              player: player,
              animationDuration: animationDuration,
            ),
          ),
        ),
        Flexible(
            fit: FlexFit.tight,
            child: startOfTrick && !startOfRound
                ? Text("${trickWinner!.firebaseId == currentUser.firebaseId ? "You" : trickWinner.displayName?.truncate()} won the trick!",
                        style: Theme.of(context).textTheme.titleMedium)
                    .animate()
                    .slideY(
                      begin: -1.0,
                      end: 0.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    )
                    .fadeIn()
                    .fadeOut(
                      delay: const Duration(seconds: 3),
                    )
                    .slideY(
                      begin: 0,
                      end: -1.0,
                    )
                : SizedBox.expand())
      ],
    );
  }
}
