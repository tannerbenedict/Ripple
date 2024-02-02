import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_animate/flutter_animate.dart';


class CardsPlayed extends StatelessWidget {
  final List<Card> lastPlayed;

  const CardsPlayed(this.lastPlayed, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Effect> calcEffects(Card card) => [];
    final hand = lastPlayed
        .map(
          (card) => Animate(
              effects: calcEffects(card),
              child: FaceCard(card, null),
          ),
        )
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [...hand],
    );
  }
}
