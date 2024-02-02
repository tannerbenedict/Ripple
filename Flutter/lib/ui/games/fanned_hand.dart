import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LayoutDirection {
  horizontal,
  vertical,
}

//
// AnimatedContainer(
//                       margin: EdgeInsets.all(0),
//                       duration: const Duration(milliseconds: 200),
//                       curve: Curves.easeOut,
//                       foregroundDecoration: BoxDecoration(
//                         backgroundBlendMode: BlendMode.darken,
//                         // Highlight the card if it is selected, but not if it's being
//                         // dragged, otherwise we end up with a weird transparent black square on screen.
//                         color:
//                             (widget.selectedCards?.contains(card) ?? false) &&
//                                     _cardBeingDragged != card
//                                 ? Colors.black.withOpacity(0.75)
//                                 : Colors.transparent,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: DraggableFaceCard(
//                         widget.showCards ? card : null,
//                         widget.handleOnCardTapped,
//                         canDrag: widget.canDrag,
//                         data: widget.selectedCards ?? card,
//                         onDragStart: () {
//                           widget.handleOnCardDragStart?.call(card);
//                           setState(() => _cardBeingDragged = card);
//                         },
//                         onDragStop: (_) {
//                           widget.handleOnCardDragStop?.call(card);
//                           setState(() => _cardBeingDragged = null);
//                         },
//                       ).animate(
//                           autoPlay: true,
//                           effects:
//                               widget.invalidCardsTouched?.contains(card) ??
//                                       false
//                                   ? [
//                                       ShakeEffect(
//                                         duration:
//                                             const Duration(milliseconds: 500),
//                                         curve: Curves.easeInOut,
//                                       )
//                                     ]
//                                   : []),
//                     )
//
typedef CardSorter = List<Card> Function(List<Card>);

typedef CardBuilder = Widget Function(BuildContext context, Card card);

List<Card> defaultCardSorter(List<Card> cards) {
  return cards;
}

Widget defaultCardBuilder(BuildContext context, Card card) {
  return FaceCard(
    card,
    null,
    showCard: false,
  );
}

class FannedHand extends ConsumerWidget {
  static const _surroundingPadding = 8.0;

  final String lobbyCode;
  final GameNotifierProvider gameNotifierProvider;
  final User player;
  final CardSorter sorter;
  final CardBuilder builder;
  final Duration animationDuration;
  final double maxRotationAngle;
  final Curve rotationCurve;
  final double cardOverlap;
  final bool shiftCards;

  const FannedHand({
    super.key,
    required this.player,
    required this.lobbyCode,
    required this.gameNotifierProvider,
    this.builder = defaultCardBuilder,
    this.sorter = defaultCardSorter,
    this.animationDuration = const Duration(milliseconds: 500),
    this.cardOverlap = 0.8,
    this.rotationCurve = Curves.linear,
    this.maxRotationAngle = 10,
    this.shiftCards = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerHand = ref.watch(gameNotifierProvider(lobbyCode).select(
        (value) => value.asData!.value!.playerHands[player.firebaseId]!));

    final rotationTween =
        Tween(begin: -maxRotationAngle, end: maxRotationAngle);
    final offsetTween = Tween(begin: -1.0, end: 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        var cardWidth = constraints.maxWidth /
            (playerHand.length - (playerHand.length - 1) * cardOverlap);
        var cardHeight = FaceCard.aspectRatio * cardWidth;

        if (cardHeight > constraints.maxHeight) {
          cardHeight = constraints.maxHeight;
          cardWidth = cardHeight / FaceCard.aspectRatio;
        }

        final totalCardSpace = cardWidth * playerHand.length -
            cardWidth * (playerHand.length - 1) * cardOverlap;
        final padding = max((constraints.maxWidth - totalCardSpace) / 2, 0);

        return Padding(
          padding: const EdgeInsets.all(_surroundingPadding),
          child: Stack(
            clipBehavior: Clip.none,
            children: sorter(playerHand).indexed.map((e) {
              final (index, card) = e;
              final baseCurveValue = playerHand.length == 1
                  // If there is only one card, we don't want to divide by
                  // zero, so we just return 0.5.
                  ? 0.5
                  : rotationCurve.transform(index / (playerHand.length - 1));
              final offset =
                  shiftCards ? offsetTween.transform(baseCurveValue) : 0;
              final rotation = rotationTween.transform(baseCurveValue);
              final top = (
                      // Shift the cards so we get a nice curve effect. 0.25
                      // is a magic number that looks good.
                      (constraints.maxHeight - cardHeight) / 2 +
                          (cardHeight * offset * 0.25).abs()) -
                  _surroundingPadding;
              final left = index * cardWidth -
                  index * cardWidth * cardOverlap +
                  padding -
                  _surroundingPadding;

              return AnimatedPositioned(
                key: ValueKey(card),
                duration: animationDuration,
                top: top,
                left: left,
                height: cardHeight,
                width: cardWidth,
                child: RepaintBoundary(
                  child: AnimatedRotation(
                    duration: animationDuration,
                    turns: (rotation * pi / 180) / (2 * pi),
                    child: builder(context, card),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
