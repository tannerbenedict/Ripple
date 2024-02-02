import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/draggable_face_card.dart';
import 'package:ripple/ui/games/gin_rummy/gin_rummy.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedCard extends StatelessWidget {
  final Card card;
  final bool isDrawnCard;
  final bool showCard;
  final Function(Card)? onCardTapped;
  final Duration duration;
  final Curve curve;
  final Size size;
  final Offset location;
  final bool isOpponentHand;

  const AnimatedCard(this.card, this.onCardTapped, this.size, this.location,
      {this.isDrawnCard = false,
      this.showCard = true,
      this.duration = const Duration(milliseconds: 500),
      this.curve = Curves.easeInExpo,
      this.isOpponentHand = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        key: ValueKey(card),
        curve: curve,
        duration: duration,
        height: size.height,
        width: size.width,
        top: location.dy,
        left: location.dx,
        child: Animate(
          effects: isDrawnCard ? _drawnCardEffects : null,
          child: DraggableFaceCard(
            card,
            onCardTapped,
            showCard: showCard,
            canDrag: !isOpponentHand,
          ),
        ));
  }

  static final _drawnCardEffects = [
    ScaleEffect(
        curve: animationCurve,
        duration: animationDuration,
        begin: Offset(2, 2),
        end: Offset(1, 1)),
  ];
}
