import 'dart:async';

import 'package:ripple/models/database_models/card.dart';
import 'package:flutter/material.dart' hide Card;

class FaceSet extends StatelessWidget {
  final FutureOr<void> Function(List<Card>,int)? handleOnPressed;
  final Card? card;
  final bool showCard;
  final int handleDrawInt;
  final bool autoComplete;

  const FaceSet(this.card, this.handleOnPressed, this.handleDrawInt, this.autoComplete,
      {this.showCard = true, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: IconButton(
          padding: EdgeInsets.only(left: 8, right: 8),
          icon: showCard && card != null ? card!.front : Card.back,
          style: Theme.of(context).iconButtonTheme.style?.copyWith(
              padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
          onPressed: !autoComplete && handleOnPressed != null
              ? () {
                  handleOnPressed!([card!], handleDrawInt);
                }
              : null),
    );
  }
}
