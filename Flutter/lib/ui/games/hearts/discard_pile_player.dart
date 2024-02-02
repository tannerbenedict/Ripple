import 'package:ripple/models/database_models/card.dart';
import 'package:flutter/material.dart' hide Card;

import 'discard_pile.dart';

class DiscardPilePlayer extends StatelessWidget {
  final Card? topCard;
  final void Function(Card)? handleDiscard;
  final Offset disappearOffset;
  const DiscardPilePlayer(this.topCard, this.handleDiscard,
      {super.key, this.disappearOffset = Offset.zero});

  @override
  Widget build(BuildContext context) {
    return DragTarget<Card>(
      onWillAccept: (data) => handleDiscard != null,
      onAccept: (data) {
        handleDiscard!(data);
      },
      builder: (context, _, __) {
        return DiscardPile(
          topCard,
          disappearOffset: disappearOffset,
          showDisabled: handleDiscard == null,
        );
      },
    );
  }
}
