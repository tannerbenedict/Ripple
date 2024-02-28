import 'dart:async';

import 'package:ripple/models/database_models/card.dart';
import 'package:flutter/material.dart' hide Card;

class FaceColumn extends StatelessWidget {
  final FutureOr<void> Function(List<Card>)? handleOnPressed;
  final List<Card>? card;
  final bool showCard;

  const FaceColumn(this.card, this.handleOnPressed,
      {this.showCard = true, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: IconButton(
          icon: showCard && card != null ? card!.last.front : Card.back,
          style: Theme.of(context).iconButtonTheme.style?.copyWith(
              padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
          onPressed: handleOnPressed != null
              ? () {
                  handleOnPressed!(card!);
                }
              : null),
    );
  }
}
