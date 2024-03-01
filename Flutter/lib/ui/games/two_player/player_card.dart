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

class PlayerCard extends HookConsumerWidget {
  final TwoPlayerNotifierProvider provider;
  final String lobbyCode;
  final Card card;
  final int index;

  const PlayerCard(this.lobbyCode, this.provider, this.card, this.index, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    final (
      playerHand,
      canDiscard,
      canDraw,
      isFirst,
      isSecond,
      cardDrawn,
      currentPlayer,
    ) = ref.watch(provider(lobbyCode).select((value) {
      final data = value.asData!.value!;

      return (
        data.playerHands[user.firebaseId]!,
        data.playerCanDiscard(user),
        data.playerCanDrawDiscardPile(user),
        data.isFirstTurn,
        data.isSecondTurn,
        data.drawnCard,
        data.currentPlayer,
      );
    }));

    final topCard = card;
    final secondCard = null;

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
                  data != null,
              onAccept: (data) async => await ref
                  .read(provider(lobbyCode).notifier)
                  .placeCard(data, user, index),
              builder: (context, _, __) {
                return DraggableFaceCard(
                  topCard,
                  isFirst || isSecond
                      ? (value) async => await ref
                          .read(provider(lobbyCode).notifier)
                          .userFlipCard(user, index)
                      : canDraw ? (value) async => await ref
                          .read(provider(lobbyCode).notifier)
                          .placeCard(value, user, index) : null,
                  canDrag: false,
                  childWhenDragging: secondCard != null
                      ? FaceCard(secondCard, (_) {})
                      : AspectRatio(
                          aspectRatio: 224 / 312, child: SizedBox.expand()),
                ).animate(
                    effects: cardDrawn == null
                        ? [
                            SlideEffect(
                              begin: Offset(0, currentPlayer == user ? -1 : 1),
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
