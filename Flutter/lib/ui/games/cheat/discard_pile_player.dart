import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:flutter/material.dart' hide Card;

class DiscardPilePlayer extends StatelessWidget {
  final Card? topCard;
  final void Function(List<Card>)? handleDiscard;
  const DiscardPilePlayer(this.topCard, this.handleDiscard, {super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: DragTarget<List<Card>>(
        onWillAccept: (data) => handleDiscard != null && data != null && data.isNotEmpty,
        onAccept: (data) {
          handleDiscard!(data);
        },
        builder: (context, _, __) {
          if (topCard == null) {
            return AspectRatio(
              // This is the aspect ratio of the card images we have
              aspectRatio: 224 / 312,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            );
          } else {
            return FaceCard(null, null);
          }
        },
      ),
    );
  }
}
