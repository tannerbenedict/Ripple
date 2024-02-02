import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:flutter/material.dart' hide Card;

class DiscardPile extends StatelessWidget {
  final Card? topCard;
  final Offset disappearOffset;
  final bool showDisabled;
  const DiscardPile(
    this.topCard, {
    super.key,
    this.disappearOffset = Offset.zero,
    this.showDisabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: AspectRatio(
              aspectRatio: 1 / FaceCard.aspectRatio,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: showDisabled
                          ? Theme.of(context).colorScheme.background
                          : Theme.of(context).colorScheme.primaryContainer))),
        ),
        Center(
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) => SlideTransition(
                  position: animation
                      .drive(Tween(begin: disappearOffset, end: Offset.zero)),
                  child: FadeTransition(opacity: animation, child: child)),
              child: topCard == null
                  ? AspectRatio(aspectRatio: FaceCard.aspectRatio)
                  : FaceCard(topCard, null, key: ValueKey(topCard))),
        ),
      ],
    );
  }
}
