import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/two_player_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/draggable_face_card.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ripple/ui/games/two_player/two_player_ripple.dart';

class DrawPile extends ConsumerWidget {
  final TwoPlayerNotifierProvider provider;
  final String lobbyCode;

  const DrawPile(this.lobbyCode, this.provider, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    final (drawPile, canDraw, currentPlayer, drawnCard) =
        ref.watch(provider(lobbyCode).select((value) {
      final game = value.asData!.value!;

      return (
        game.drawPile,
        game.playerCanDrawDrawPile(user),
        game.currentPlayer,
        game.drawnCard,
      );
    }));

    return AnimatedContainer(
        duration: animationDuration,
        curve: animationCurve,
        foregroundDecoration: !canDraw
            ? BoxDecoration(
                color: Colors.black.withOpacity(0.33),
                backgroundBlendMode: BlendMode.darken,
              )
            : BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: AnimatedSwitcher(
          duration: animationDuration,
          switchInCurve: animationCurve,
          switchOutCurve: animationCurve,
          transitionBuilder: (child, animation) {
            // We're transitioning in the top card.
            if (animation.isDismissed) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
              // We're transitioning out the top card and it was
              // just drawn.
            } else if (drawnCard != null && animation.isCompleted) {
              final offset =
                  currentPlayer == user ? Offset(0, 1) : Offset(0, -1);
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  // We have to switch the order cause the animation is now playing
                  // backwards to transition out the just drawn card.
                  position: Tween<Offset>(
                    begin: offset,
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            } else {
              return FadeTransition(opacity: animation, child: child);
            }
          },
          child: DraggableFaceCard(
            drawPile.last,
            canDraw
                ? (_) async {
                    await ref
                        .read(provider(lobbyCode).notifier)
                        .drawDrawPile(user);
                  }
                : null,
            key: ValueKey(drawPile.last),
            canDrag: false,
            showCard: false,
            childWhenDragging: FaceCard(null, (_) {}),
          ),
        ));
  }
}
