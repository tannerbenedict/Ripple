import 'dart:async';
import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:ripple/ui/games/gin_rummy/animated_card.dart';
import 'package:ripple/ui/games/gin_rummy/gin_rummy.dart';
import 'package:flutter/material.dart' hide Card;

class AnimatedHand extends StatefulWidget {
  final List<List<Card>> matched;
  final List<Card> deadwood;
  final bool showCards;
  final Card? drawnCard;
  final FutureOr<void> Function(Card)? onCardTapped;
  final FutureOr<void> Function(Card)? onCardAccepted;
  final bool Function(Card?)? shouldAcceptCard;
  final bool isOpponentHand;

  AnimatedHand({
    required this.isOpponentHand,
    required this.matched,
    required this.deadwood,
    this.showCards = true,
    this.drawnCard,
    this.onCardTapped,
    this.onCardAccepted,
    this.shouldAcceptCard,
    super.key,
  });

  @override
  State<AnimatedHand> createState() => _AnimatedHandState();
}

class _AnimatedHandState extends State<AnimatedHand> {
  static const _matchOverlapPercentage = 0.5;
  static const _padding = 8.0;

  static final _duration = Duration(milliseconds: 800);
  static final _curve = CatmullRomCurve.precompute([
    const Offset(0.25, 0.5),
    const Offset(0.75, 1.1),
  ]);

  List<List<Card>> get matched => widget.matched;

  List<Card> get deadwood => widget.deadwood;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final cardSize = _calcCardSize(constraints.biggest, matched, deadwood);
      final centeringOffset = _calcCenteringOffset(
          constraints.biggest, cardSize, matched, deadwood);
      final matchGroupOffset =
          _calcMatchGroupOffset(matched, cardSize, matched.length);

      return RepaintBoundary(
        child: DragTarget<Card>(
          onWillAccept: widget.shouldAcceptCard,
          onAccept: widget.onCardAccepted,
          builder: (context, _, __) => Stack(
              children: widget.showCards
                  ? [
                      ..._createMatchedCards(
                          constraints.biggest, cardSize, centeringOffset),
                      if (widget.matched.isNotEmpty &&
                          widget.deadwood.isNotEmpty)
                        AnimatedPositioned(
                            duration: _duration,
                            curve: _curve,
                            left: matchGroupOffset.dx +
                                centeringOffset.dx -
                                _padding,
                            height: constraints.biggest.height,
                            child: VerticalDivider(
                              indent: (cardSize * 0.25).height,
                              endIndent: (cardSize * 0.25).height,
                              width: 2 * padding,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ..._createDeadwoodCards(
                          constraints.biggest, cardSize, centeringOffset)
                    ]
                  : _createHiddenCards(constraints.biggest, cardSize)),
        ),
      );
    });
  }

  List<Widget> _createHiddenCards(Size constraints, Size cardSize) {
    final playerHand = [...deadwood, ...matched.expand((element) => element)];
    final paddingSpace = (playerHand.length + 1) * _padding;
    final cardSpace = playerHand.length * cardSize.width;
    final centeringOffset =
        Offset((constraints.width - paddingSpace - cardSpace) / 2, 0);
    final hand = <Widget>[];

    for (final (i, card) in playerHand.indexed) {
      final cardLocation =
          _calcCardLocation(i, centeringOffset, cardSize, constraints);
      hand.add(AnimatedCard(
          key: ValueKey(card),
          card,
          widget.onCardTapped,
          cardSize,
          cardLocation,
          showCard: widget.showCards,
          isDrawnCard: card == widget.drawnCard,
          isOpponentHand: widget.isOpponentHand));
    }

    return hand;
  }

  List<Widget> _createDeadwoodCards(
      Size constraints, Size cardSize, Offset centeringOffset) {
    final handDeadwood = <Widget>[];
    var deadwoodStartLocation = centeringOffset;
    if (matched.isNotEmpty) {
      deadwoodStartLocation +=
          _calcMatchGroupOffset(matched, cardSize, matched.length);
    }

    for (final (i, card) in deadwood.indexed) {
      final cardLocation =
          _calcCardLocation(i, deadwoodStartLocation, cardSize, constraints);
      handDeadwood.add(AnimatedCard(
        key: ValueKey(card),
        card,
        widget.onCardTapped,
        cardSize,
        cardLocation,
        isDrawnCard: card == widget.drawnCard,
        showCard: widget.showCards,
        curve: _curve,
        duration: _duration,
      ));
    }

    return handDeadwood;
  }

  List<Widget> _createMatchedCards(
      Size constraints, Size cardSize, Offset centeringOffset) {
    final handMatches = <Widget>[];
    for (final (i, group) in widget.matched.indexed) {
      final matchGroupOffset = _calcMatchGroupOffset(matched, cardSize, i);
      for (final (j, card) in group.indexed) {
        final cardLocation = _calcMatchGroupCardLocation(
            j, cardSize, constraints, matchGroupOffset + centeringOffset);
        handMatches.add(AnimatedCard(
          key: ValueKey(card),
          card,
          widget.onCardTapped,
          cardSize,
          cardLocation,
          isDrawnCard: card == widget.drawnCard,
          showCard: widget.showCards,
          curve: _curve,
          duration: _duration,
        ));
      }
    }

    return handMatches;
  }

  Offset _calcCardLocation(
    int cardNumber,
    Offset startLocation,
    Size cardSize,
    Size constraints,
  ) =>
      Offset(
          (cardSize.width + _padding) * cardNumber +
              _padding +
              startLocation.dx,
          (constraints.height - cardSize.height) / 2);

  Offset _calcMatchGroupCardLocation(int cardNumber, Size cardSize,
          Size constraints, Offset centeringOffset) =>
      Offset(
          (cardSize.width - _matchOverlapPercentage * cardSize.width) *
                  cardNumber +
              centeringOffset.dx,
          (constraints.height - cardSize.height) / 2 + centeringOffset.dy);

  Offset _calcMatchGroupOffset(
      List<List<Card>> matched, Size cardSize, int groupNum) {
    var width = 0.0;

    for (var i = 0; i < groupNum; i++) {
      // Width of all the cards minus the overlap of the cards
      width += matched[i].length * cardSize.width -
          (matched[i].length - 1) * cardSize.width * _matchOverlapPercentage +
          _padding;
    }
    return Offset(
        width,
        // No need to shift in the y direction, that's accounted for by constraints
        // not by match group locations.
        0);
  }

  Size _calcCardSize(
      Size constraints, List<List<Card>> matched, List<Card> deadwood) {
    if (!widget.showCards) {
      final leftOverSpace = constraints.width -
          (deadwood.length + matched.expand((element) => element).length + 1) *
              _padding;
      var cardWidth = leftOverSpace /
          (deadwood.length + matched.expand((element) => element).length);
      var cardHeight = cardWidth * FaceCard.aspectRatio;

      if (cardHeight > constraints.height) {
        cardHeight = constraints.height;
        cardWidth = constraints.height / FaceCard.aspectRatio;
      }
      return Size(cardWidth, cardHeight);
    }
    // This is some rather complicated math that determines the card width
    // based on the number of cards in the deadwood as well as doing some
    // fancy summation math to determine the amount of space the match groups need.
    final leftOverSpace =
        (constraints.width - (deadwood.length + matched.length) * _padding);
    final matchGroupFactor = matched.fold(
        0.0,
        (previousValue, element) =>
            previousValue +
            element.length -
            (element.length - 1) * _matchOverlapPercentage);

    var cardWidth = (leftOverSpace) / (deadwood.length + matchGroupFactor);
    var cardHeight = cardWidth * FaceCard.aspectRatio;
    if (cardHeight > constraints.height) {
      cardHeight = constraints.height;
      cardWidth = cardHeight / FaceCard.aspectRatio;
    }
    return Size(cardWidth, cardHeight);
  }

  Offset _calcCenteringOffset(Size constraints, Size cardSize,
      List<List<Card>> matched, List<Card> deadwood) {
    final deadwoodSpace = deadwood.length * cardSize.width;
    final matchGroupSpace =
        _calcMatchGroupOffset(matched, cardSize, matched.length);
    final paddingSpace = (deadwood.length + matched.length + 1) * _padding;
    final totalSpace = deadwoodSpace + matchGroupSpace.dx + paddingSpace;
    if (totalSpace >= constraints.width) {
      return Offset.zero;
    } else {
      return Offset(
          (constraints.width -
                  (deadwoodSpace + matchGroupSpace.dx + paddingSpace)) /
              2,
          0);
    }
  }
}
