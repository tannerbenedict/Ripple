import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_animate/flutter_animate.dart';

class FannedStack extends StatelessWidget {
  final List<Card>? cards;
  final bool showCards;
  final double maxRotationAngle;
  final double overlap;

  const FannedStack({
    super.key,
    this.showCards = false,
    this.maxRotationAngle = 10.0,
    this.cards = const [],
    this.overlap = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final rotationTween =
          Tween(begin: -maxRotationAngle, end: maxRotationAngle);
      final actualCards =
          cards ?? List.filled(3, Card(faceValue: 0, suit: Suit.clubs));
      var cardHeight = constraints.maxHeight;
      var cardWidth = cardHeight / FaceCard.aspectRatio;

      var totalWidth = cardWidth * actualCards.length -
          cardWidth * (actualCards.length - 1) * overlap;
      if (totalWidth > constraints.maxWidth) {
        cardWidth = constraints.maxWidth / actualCards.length;
        cardHeight = cardWidth * FaceCard.aspectRatio;
        totalWidth = cardWidth * actualCards.length -
            cardWidth * (actualCards.length - 1) * overlap;
      }
      final padding = max((constraints.maxWidth - totalWidth) / 2.0, 0.0);

      final top = (constraints.maxHeight - cardHeight) / 2;
      return Stack(
        children: actualCards.indexed.map((e) {
          final (index, card) = e;
          //print("foo");
          final left =
              padding + index * cardWidth - index * cardWidth * overlap;
          final rotation =
              rotationTween.transform(index / (actualCards.length - 1));

          return Positioned(
            height: cardHeight,
            width: cardWidth,
            top: top,
            left: left,
            child: Transform.rotate(
              angle: actualCards.length == 1
                  ? 0
                  : (rotation * pi / 180) / (2 * pi),
              child: Animate(
                effects: showCards
                    ? [
                        FlipEffect(
                          begin: -1.0,
                          duration: 400.ms,
                          direction: Axis.horizontal,
                        ),
                      ]
                    : [],
                child: FaceCard(
                  card,
                  null,
                  showCard: showCards,
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
