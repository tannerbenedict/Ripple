import 'dart:async';

import 'package:ripple/models/database_models/card.dart';
import 'package:flutter/material.dart' hide Card;

class FaceCard extends StatelessWidget {
  // Extracted from Adobe Illustrator.
  static const aspectRatio = 1.5015324603;

  final FutureOr<void> Function(Card)? handleOnPressed;
  final Card? card;
  final bool showCard;
  final ColorFilter? filter;

  const FaceCard(this.card, this.handleOnPressed,
      {this.showCard = true, this.filter, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleOnPressed != null && card != null
            ? () {
                handleOnPressed!(card!);
              }
            : null,
        child: card!.visibility && card != null ? card!.front : Card.back);
  }
}
