import 'dart:async';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/hearts_notifier.dart';
import 'package:ripple/providers/game_providers/hearts_notifier_online.dart';
import 'package:ripple/providers/game_providers/hearts_notifier_solo.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/draggable_face_card.dart';
import 'package:ripple/ui/games/fanned_hand.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSection extends ConsumerWidget {
  final String lobbyCode;
  final FutureOr<void> Function(Card)? handleOnCardTapped;
  final Card? invalidCardTouched;

  const BottomSection(
      {super.key,
      required this.lobbyCode,
      this.handleOnCardTapped,
      this.invalidCardTouched});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    HeartsNotifierProvider provider = heartsOnlineNotifierProvider.call;
    if (lobbyCode == "") {
      provider = heartsSoloNotifierProvider.call;
    }
    final (
      currentPlayer,
      gameStatus,
    ) = ref.watch(provider(lobbyCode).select(
      (value) => value.maybeWhen(
          orElse: () => (null, GameStatus.playing),
          data: (data) => (
                data!.currentPlayer,
                data.gameStatus,
              )),
    ));
    return FannedHand(
      gameNotifierProvider: provider,
      lobbyCode: lobbyCode,
      player: user,
      maxRotationAngle: 10,
      cardOverlap: 0.5,
      builder: (context, card) {
        return DraggableFaceCard(
          card,
          currentPlayer == user && gameStatus == GameStatus.playing
              ? handleOnCardTapped
              : null,
          canDrag: true,
        ).animate(
            effects: card == invalidCardTouched
                ? [
                    ShakeEffect(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    )
                  ]
                : []);
      },
    );
  }
}
