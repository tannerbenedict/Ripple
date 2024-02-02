import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:flutter/material.dart' hide Card;

import 'draggable_set.dart';

class SetPile extends StatelessWidget {
  final Suit suit;
  final Card? topCard;
  final Card? secondCard;
  final int handleDiscardInt;
  final void Function(List<Card>, int)? handleDrag;
  final void Function(List<Card>, int)? handleTap;
  final bool autoComplete;
  const SetPile(this.suit, this.topCard, this.secondCard, this.handleDiscardInt,
      this.handleDrag, this.handleTap, this.autoComplete,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: DragTarget<List<Card>>(
        onWillAccept: (data) => !autoComplete && handleDrag != null,
        onAccept: (data) {
          handleDrag!(data, handleDiscardInt);
        },
        builder: (context, _, __) {
          if (topCard == null) {
            return AspectRatio(
                // This is the aspect ratio of the card images we have
                aspectRatio: 224 / 312,
                child: Center(
                  child: Opacity(
                    opacity: 0.4,
                    child: DraggableSet(
                      Card(faceValue: 1, suit: suit),
                      null,
                      handleDiscardInt,
                      false,
                      canDrag: false,
                      childWhenDragging: secondCard != null
                          ? FaceCard(secondCard, (_) {})
                          : AspectRatio(
                              aspectRatio: 224 / 312, child: SizedBox.expand()),
                    ),
                  ),
                ));
          } else {
            return AspectRatio(
              aspectRatio: 224 / 312,
              child: Container(
                foregroundDecoration: handleDrag == null
                    ? BoxDecoration(
                        backgroundBlendMode: BlendMode.darken,
                        color: Colors.black.withOpacity(0.75),
                      )
                    : null,
                child: DraggableSet(
                  topCard,
                  handleTap,
                  handleDiscardInt,
                  autoComplete,
                  canDrag: !autoComplete && handleTap != null,
                  childWhenDragging: secondCard != null
                      ? FaceCard(secondCard, (_) {})
                      : AspectRatio(
                          aspectRatio: 224 / 312, child: SizedBox.expand()),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
