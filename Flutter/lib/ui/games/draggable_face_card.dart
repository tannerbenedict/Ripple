import 'dart:async';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:flutter/material.dart' hide Card;

class DraggableFaceCard extends StatelessWidget {
  final Card? card;
  final FutureOr<void> Function(Card card)? handleOnPressed;
  final FutureOr<void> Function(Card card)? handleCardRejected;
  final FutureOr<void> Function()? onDragStart;
  final FutureOr<void> Function(DraggableDetails)? onDragStop;
  final Object? data;
  final bool showCard;
  final Widget? childWhenDragging;
  final bool canDrag;
  final ColorFilter? filter;

  DraggableFaceCard(
    this.card,
    this.handleOnPressed, {
    this.canDrag = true,
    this.childWhenDragging = const SizedBox(height: 0, width: 0),
    this.showCard = true,
    this.handleCardRejected,
    this.onDragStart,
    this.onDragStop,
    this.data,
    this.filter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final child = FaceCard(
      card,
      handleOnPressed,
      showCard: showCard,
      filter: filter,
    );
    return LayoutBuilder(
      builder: (context, constraints) => Draggable(
          maxSimultaneousDrags: canDrag ? 1 : 0,
          data: data ?? card,
          dragAnchorStrategy: pointerDragAnchorStrategy,
          childWhenDragging: childWhenDragging,
          onDragStarted: onDragStart,
          onDragEnd: onDragStop,
          onDraggableCanceled: (velocity, offset) {
            if (handleCardRejected != null && card != null) {
              handleCardRejected!(card!);
            }
            onDragStop?.call(DraggableDetails(
              wasAccepted: false,
              offset: offset,
              velocity: velocity,
            ));
          },
          feedback: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: FractionalTranslation(
              translation: Offset(-0.5, -0.5),
              child: child,
            ),
          ),
          child: child),
    );
  }
}
