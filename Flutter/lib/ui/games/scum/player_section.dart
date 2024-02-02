import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/scum_local_state_notifier.dart';
import 'package:ripple/providers/game_providers/scum_notifier.dart';
import 'package:ripple/providers/game_providers/scum_notifier_online.dart';
import 'package:ripple/providers/game_providers/scum_notifier_solo.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/draggable_face_card.dart';
import 'package:ripple/ui/games/fanned_hand.dart';
import 'package:ripple/ui/games/hearts/player_avatar.dart';
import 'package:ripple/ui/games/scum/position_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerSection extends ConsumerWidget {
  const PlayerSection({
    super.key,
    required this.lobbyCode,
  });

  final String lobbyCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));

    ScumNotifierProvider provider = scumOnlineNotifierProvider.call;
    if (lobbyCode == "") {
      provider = scumSoloNotifierProvider.call;
    }

    final (canDiscard, canPass, isPlayerTurn, position) =
        ref.watch(provider(lobbyCode).select((value) {
      final result = value.asData!.value!;

      return (
        result.canDiscard(user),
        result.canPass(user),
        result.currentPlayer?.firebaseId == user.firebaseId,
        result.positions[user.firebaseId],
      );
    }));
    final localState = ref.watch(scumLocalStateNotifierProvider(lobbyCode));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: SizedBox.expand(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PositionIcon(position: position),
              PlayerAvatar(
                isPlayerTurn: isPlayerTurn,
                player: user,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: const Text("You"),
              )
            ],
          ),
        )),
        Flexible(
            flex: 3,
            child: FannedHand(
              gameNotifierProvider: provider,
              lobbyCode: lobbyCode,
              player: user,
              maxRotationAngle: 10,
              cardOverlap: 0.25,
              builder: (context, card) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  foregroundDecoration: BoxDecoration(
                    color: localState.selectedCards.contains(card)
                        ? Colors.black.withOpacity(0.5)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DraggableFaceCard(
                    card,
                    (card) {
                      if (ref
                          .read(scumLocalStateNotifierProvider(lobbyCode))
                          .selectedCards
                          .contains(card)) {
                        ref.read(
                            scumLocalStateNotifierProvider(lobbyCode).notifier)
                          ..removeSelectedCard(card)
                          ..setInvalidCardsTouched([]);
                      } else {
                        ref.read(
                            scumLocalStateNotifierProvider(lobbyCode).notifier)
                          ..addSelectedCard(card)
                          ..setInvalidCardsTouched([]);
                      }
                    },
                    canDrag: canDiscard,
                    showCard: true,
                    onDragStart: () {
                      final state =
                          ref.read(scumLocalStateNotifierProvider(lobbyCode));
                      if (state.selectedCards.isEmpty) {
                        ref
                            .read(scumLocalStateNotifierProvider(lobbyCode)
                                .notifier)
                            .addSelectedCard(card);
                      }
                    },
                    onDragStop: (_) {
                      final state =
                          ref.read(scumLocalStateNotifierProvider(lobbyCode));
                      if (state.selectedCards.length == 1 &&
                          state.selectedCards.contains(card)) {
                        ref
                            .read(scumLocalStateNotifierProvider(lobbyCode)
                                .notifier)
                            .removeSelectedCard(card);
                      }
                    },
                    data: localState.selectedCards,
                  ).animate(
                      effects: localState.invalidCardsTouched.contains(card)
                          ? [
                              ShakeEffect(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              )
                            ]
                          : []),
                );
              },
            )),
        Flexible(
            child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: ElevatedButton.icon(
                onPressed: canPass
                    ? () async {
                        await ref.read(provider(lobbyCode).notifier).pass(user);
                      }
                    : null,
                icon: Icon(
                  Icons.arrow_forward_rounded,
                ),
                label: Text(
                  "Pass",
                )),
          ),
        ))
      ],
    );
  }
}
