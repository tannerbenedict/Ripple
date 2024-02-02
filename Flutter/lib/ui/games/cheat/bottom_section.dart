import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/cheat_local_state_notifier.dart';
import 'package:ripple/providers/game_providers/cheat_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/cheat/player_section.dart';
import 'package:ripple/ui/games/draggable_face_card.dart';
import 'package:ripple/ui/games/fanned_hand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSection extends ConsumerWidget {
  final String lobbyCode;
  final CheatNotifierProvider provider;

  const BottomSection({
    super.key,
    required this.lobbyCode,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginInfoProvider.select((value) => value.user));

    final localState = ref.watch(cheatLocalStateNotifierProvider(lobbyCode));
    final (isPlayerTurn, cardsPlayed, isRoundEnd) =
        ref.watch(provider(lobbyCode).select((value) => value.maybeWhen(
            orElse: () => (false, [], false),
            data: (data) => (
                  data!.currentPlayer == User.getRealOrDefaultUser(user),
                  data.cardsPlayed,
                  data.isRoundEnd,
                ))));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: PlayerSection(
            lobbyCode: lobbyCode,
            provider: provider,
            player: User.getRealOrDefaultUser(user),
          ),
        ),
        Flexible(
          flex: 4,
          child: FannedHand(
              cardOverlap: 0.25,
              player: User.getRealOrDefaultUser(user),
              lobbyCode: lobbyCode,
              gameNotifierProvider: provider,
              builder: (context, card) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  foregroundDecoration: BoxDecoration(
                      color: localState.selectedCards.contains(card)
                          ? Colors.black.withOpacity(0.5)
                          : Colors.transparent),
                  child: DraggableFaceCard(
                    card,
                    (card) {
                      ref
                          .read(cheatLocalStateNotifierProvider(lobbyCode)
                              .notifier)
                          .toggleSelectedCard(card);
                    },
                    canDrag: isPlayerTurn && !isRoundEnd,
                    data: localState.selectedCards,
                    onDragStart: () {
                      final state =
                          ref.read(cheatLocalStateNotifierProvider(lobbyCode));

                      if (state.selectedCards.isEmpty ||
                          !state.selectedCards.contains(card)) {
                        ref
                            .read(cheatLocalStateNotifierProvider(lobbyCode)
                                .notifier)
                            .toggleSelectedCard(card);
                      }
                    },
                    onDragStop: (_) {
                      final state =
                          ref.read(cheatLocalStateNotifierProvider(lobbyCode));

                      if (state.selectedCards.length == 1 &&
                          state.selectedCards.contains(card)) {
                        ref
                            .read(cheatLocalStateNotifierProvider(lobbyCode)
                                .notifier)
                            .toggleSelectedCard(card);
                      }
                    },
                  ),
                );
              }),
        ),
        Flexible(
          child: SizedBox.expand(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: isPlayerTurn && cardsPlayed.isNotEmpty
                      ? () async {
                          await ref
                              .read(provider(lobbyCode).notifier)
                              .callCheat(User.getRealOrDefaultUser(user));
                        }
                      : null,
                  child: Text(
                    'Cheat!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
