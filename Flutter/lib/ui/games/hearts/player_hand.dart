import 'package:ripple/models/database_models/card.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_animate/flutter_animate.dart';
import '../draggable_face_card.dart';

class PlayerHand extends StatelessWidget {
  final List<Card> playerHand;

  final void Function(Card)? handlePlayerCardTapped;

  const PlayerHand(this.playerHand, this.handlePlayerCardTapped, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Effect> calcEffects(Card card) => [];
    final hand = playerHand
        .map(
          (card) => Expanded(
            child: Animate(
              effects: calcEffects(card),
              child: DraggableFaceCard(card, handlePlayerCardTapped),
            ),
          ),
        )
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [...hand],
    );
  }
}
