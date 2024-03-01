import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/two_player_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/draggable_face_card.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ripple/ui/games/two_player/two_player_ripple.dart';

class ActivePile extends HookConsumerWidget {
  final TwoPlayerNotifierProvider provider;
  final String lobbyCode;

  const ActivePile(this.lobbyCode, this.provider, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    final (
      activePile,
      playerHand,
      canDiscard,
      canDraw,
      cardDrawn,
      currentPlayer,
    ) = ref.watch(provider(lobbyCode).select((value) {
      final data = value.asData!.value!;

      return (
        data.activePile,
        data.playerHands[user.firebaseId]!,
        data.playerCanDiscard(user),
        data.playerCanDrawDiscardPile(user),
        data.drawnCard,
        data.currentPlayer,
      );
    }));

    final topCard = activePile!.isEmpty ? null : activePile.last;
    final secondCard =
        activePile.length <= 1 ? null : activePile[activePile.length - 2];

    return AnimatedContainer(
        duration: animationDuration,
        curve: animationCurve,
        foregroundDecoration: BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          color: !canDraw ? Colors.black.withOpacity(0.33) : Colors.transparent,
        ),
        child: AnimatedSwitcher(
            duration: animationDuration,
            reverseDuration: animationDuration,
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeOut,
            child: DragTarget<Card>(
              key: ValueKey(topCard),
              onWillAccept: (data) =>
                  data != null && canDiscard,
              onAccept: (data) async => await ref
                  .read(provider(lobbyCode).notifier)
                  .discardCard(data, user),
              builder: (context, _, __) {
                return activePile.isEmpty
                    ? AspectRatio(
                        // This is the aspect ratio of the card images we have
                        aspectRatio: 224 / 312,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          child: Center(),
                        ),
                      )
                    : DraggableFaceCard(
                        topCard,
                        canDiscard
                            ? (data) async => await ref
                                .read(provider(lobbyCode).notifier)
                                .discardCard(data, user)
                            : null,
                        canDrag: canDraw,
                        childWhenDragging: secondCard != null
                            ? FaceCard(secondCard, (_) {})
                            : AspectRatio(
                                aspectRatio: 224 / 312,
                                child: SizedBox.expand()),
                      ).animate(
                        effects: cardDrawn == null
                            ? [
                                SlideEffect(
                                  begin:
                                      Offset(0, currentPlayer == user ? 1 : -1),
                                  end: Offset.zero,
                                  duration: animationDuration,
                                  curve: animationCurve,
                                )
                              ]
                            : []);
              },
            )));
  }
}