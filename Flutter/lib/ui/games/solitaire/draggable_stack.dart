import 'package:ripple/models/database_models/card.dart';
import 'package:flutter/material.dart' hide Card;
import 'dart:async';

class DraggableStack extends StatefulWidget {
  final Widget childWhenDragging;
  final List<Card>? card;
  final int handleDiscardInt;
  final FutureOr<void> Function(List<Card>, int)? handleOnPressed;
  final bool canDrag;
  final bool showCard;
  final double height;
  final double width;
  final int biggestLength;
  final int numHiddenCards;
  final bool autoComplete;

  DraggableStack(
      {this.card,
      this.handleOnPressed,
      this.handleDiscardInt = 0,
      this.canDrag = true,
      this.childWhenDragging = const SizedBox(height: 0, width: 0),
      this.showCard = true,
      this.height = 0,
      this.width = 0,
      this.biggestLength = 1,
      this.numHiddenCards = 0,
      this.autoComplete = false,
      super.key});

  @override
  State<DraggableStack> createState() => _DraggableStackState();
}

class _DraggableStackState extends State<DraggableStack> {
  bool drag = false;
  int index = 0;

  double calculateTop(int index) {
    return index * 48 * calculateHeight() / 312;
  }

  double calculateHeight() {
    var height = widget.height;
    var biggestLength = widget.biggestLength;
    return (height - 32) / (48 * (biggestLength - 1) / 312 + 1);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    var card = widget.card;
    var numHiddenCards = widget.numHiddenCards;
    var height = widget.height;
    var width = widget.width;
    var canDrag = widget.canDrag;
    var showCard = widget.showCard;
    var handleOnPressed = widget.handleOnPressed;
    var autoComplete = widget.autoComplete;

    int cardLength = card == null ? 0 : card.length;
    for (int i = 0; i < cardLength + numHiddenCards; i++) {
      if (i < numHiddenCards) {
        cards.add(Positioned(
          top: calculateTop(i),
          width: width,
          height: calculateHeight(),
          child: IconButton(
              padding: EdgeInsets.only(left: 8, right: 8),
              icon: Card.back,
              style: Theme.of(context).iconButtonTheme.style?.copyWith(
                  padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
              onPressed: null),
        ));
      } else {
        if (!drag || i < index) {
          cards.add(Positioned(
              top: calculateTop(i),
              width: width,
              height: calculateHeight(),
              child: Draggable(
                maxSimultaneousDrags: !autoComplete && canDrag ? 1 : 0,
                data: card!.sublist(i - numHiddenCards, card.length),
                onDragStarted: () {
                  setState(() {
                    drag = true;
                    index = i;
                  });
                },
                onDragCompleted: () {
                  setState(() {
                    drag = false;
                  });
                },
                onDraggableCanceled: (_, __) {
                  setState(() {
                    drag = false;
                  });
                },
                feedback: SizedBox(
                    width: width,
                    height: height,
                    child: Stack(children: feedbackCol(i))),
                child: IconButton(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    icon: showCard
                        ? card[i - numHiddenCards].front
                        : Card.back,
                    style: Theme.of(context).iconButtonTheme.style?.copyWith(
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(0))),
                    onPressed: !autoComplete && handleOnPressed != null
                        ? () {
                            handleOnPressed(
                                card.sublist(i - numHiddenCards, card.length),
                                widget.handleDiscardInt);
                          }
                        : null),
              )));
        }
      }
    }

    return Stack(children: cards);
  }

  List<Widget> feedbackCol(int index) {
    List<Widget> widgets = [];
    var card = widget.card;
    var numHiddenCards = widget.numHiddenCards;
    var width = widget.width;
    var showCard = widget.showCard;

    int count = 0;

    for (int j = index - numHiddenCards; j < card!.length; j++) {
      widgets.add(Positioned(
        top: calculateTop(count),
        width: width,
        height: calculateHeight(),
        child: IconButton(
            padding: EdgeInsets.only(left: 8, right: 8),
            icon: showCard ? card[j].front : Card.back,
            style: Theme.of(context).iconButtonTheme.style?.copyWith(
                padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
            onPressed: null),
      ));
      count++;
    }

    return widgets;
  }
}
