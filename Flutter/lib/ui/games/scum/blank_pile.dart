import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:flutter/material.dart' hide Card;

class BlankPile extends StatelessWidget {
  final Card? topCard;
  const BlankPile(this.topCard, {super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: topCard == null
          ? AspectRatio(
              // This is the aspect ratio of the card images we have
              aspectRatio: 224 / 312,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.background),
              ),
            )
          : FaceCard(topCard, null),
    );
  }
}
