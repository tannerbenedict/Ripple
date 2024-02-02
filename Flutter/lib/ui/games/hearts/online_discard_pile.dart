import 'dart:async';

import 'package:ripple/models/database_models/card.dart';
import 'package:flutter/material.dart' hide Card;

import '../face_card.dart';

class OnlineDiscardPile extends StatelessWidget {
  final Card? topCard;
  final FutureOr<void> Function(Card)? handleDiscard;
  final Offset disappearOffset;
  const OnlineDiscardPile({
    super.key,
    this.topCard,
    this.handleDiscard,
    this.disappearOffset = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Card>(
      onWillAccept: (data) => handleDiscard != null,
      onAccept: (data) {
        handleDiscard!(data);
      },
      builder: (context, _, __) {
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
                          color: handleDiscard == null
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context)
                                  .colorScheme
                                  .primaryContainer))),
            ),
            Center(
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder: (child, animation) => SlideTransition(
                      position: animation.drive(
                          Tween(begin: disappearOffset, end: Offset.zero)),
                      child: FadeTransition(opacity: animation, child: child)),
                  child: topCard == null
                      ? AspectRatio(aspectRatio: FaceCard.aspectRatio)
                      : FaceCard(topCard, null, key: ValueKey(topCard))),
            ),
          ],
        );
      },
    );
  }
}
