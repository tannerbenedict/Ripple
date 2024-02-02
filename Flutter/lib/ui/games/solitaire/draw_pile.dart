import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/solitaire/outlined_card_pile.dart';
import 'package:flutter/material.dart' hide Card;

class DrawPile extends StatelessWidget {
  final List<Card>? topCard;
  final bool drawIsEmpty;
  final bool flippedIsEmpty;
  final void Function(List<Card>)? handleDraw;

  const DrawPile(
      this.topCard, this.drawIsEmpty, this.flippedIsEmpty, this.handleDraw,
      {super.key});

  @override
  Widget build(BuildContext context) {
    if (drawIsEmpty) {
      return Padding(
          padding: EdgeInsets.all(8),
          child: OutlinedCardPile(
              topCard,
              handleDraw,
              drawIsEmpty && flippedIsEmpty
                  ? null
                  : Transform.scale(
                      scale: MediaQuery.sizeOf(context).width / 800,
                      child: Icon(Icons.restart_alt,
                          color: Theme.of(context).colorScheme.background),
                    ),
              !drawIsEmpty || !flippedIsEmpty));
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: IconButton(
          //padding: EdgeInsets.only(left: 8, right: 8, top: 24, bottom: 24),
          icon: Card.back,
          style: Theme.of(context).iconButtonTheme.style?.copyWith(
              padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
          onPressed: drawIsEmpty && flippedIsEmpty
              ? null
              : () {
                  handleDraw!(topCard!);
                }),
    );
  }
}
