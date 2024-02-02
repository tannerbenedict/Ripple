import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/hearts/discard_pile.dart';
import 'package:flutter/material.dart' hide Card;

import 'draggable_stack.dart';

class ColumnPile extends StatelessWidget {
  final List<Card>? topCard;
  final List<Card>? secondCard;
  final int handleDiscardInt;
  final void Function(List<Card>, int)? handleAdd;
  final void Function(List<Card>, int)? handleTap;
  final double width;
  final double height;
  final int biggestLength;
  final int numHiddenCards;
  final bool autoComplete;

  const ColumnPile(
      this.topCard,
      this.secondCard,
      this.handleDiscardInt,
      this.handleAdd,
      this.handleTap,
      this.width,
      this.height,
      this.biggestLength,
      this.numHiddenCards,
      this.autoComplete,
      {super.key});

  double calculateHeight() {
    return biggestLength == 0
        ? height - 32
        : (height - 32) / (48 * (biggestLength - 1) / 312 + 1);
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<List<Card>>(
      onWillAccept: (data) => !autoComplete && handleAdd != null,
      onAccept: (data) {
        handleAdd!(data, handleDiscardInt);
      },
      builder: (context, _, __) {
        if (topCard == null) {
          return Center(
              child: Stack(children: [
            Positioned(
                width: width,
                height: calculateHeight(),
                child: Center(child: DiscardPile(null, showDisabled: true)))
          ]));
        } else {
          return DraggableStack(
              handleDiscardInt: handleDiscardInt,
              card: topCard,
              height: height,
              biggestLength: biggestLength,
              width: width,
              handleOnPressed: handleTap,
              canDrag: handleTap != null,
              numHiddenCards: numHiddenCards,
              autoComplete: autoComplete);
        }
      },
    );
  }
}
