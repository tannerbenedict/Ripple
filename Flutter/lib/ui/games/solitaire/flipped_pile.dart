import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:ripple/ui/games/hearts/discard_pile.dart';
import 'package:flutter/material.dart' hide Card;

import 'draggable_column.dart';

class FlippedPile extends StatelessWidget {
  final List<Card>? topCard;
  final List<Card>? secondCard;
  final void Function(List<Card>)? handleDraw;
  const FlippedPile(this.topCard, this.secondCard, this.handleDraw,
      {super.key});

  @override
  Widget build(BuildContext context) {
    if (topCard == null) {
      return Flexible(child: Padding(padding: EdgeInsets.only(top: 8, bottom: 8), child: DiscardPile(null, showDisabled: true)));
    }
    return Flexible(
        child: DraggableColumn(
      topCard,
      handleDraw,
      canDrag: handleDraw != null,
      childWhenDragging: secondCard != null
          ? FaceCard(null, null)
          : AspectRatio(aspectRatio: 224 / 312, child: SizedBox.expand()),
    ));
  }
}
