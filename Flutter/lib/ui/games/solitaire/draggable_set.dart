import 'package:flutter/material.dart';

import 'face_set.dart';

class DraggableSet extends FaceSet {
  final Widget childWhenDragging;
  final bool canDrag;

  DraggableSet(super.card, super.handleOnPressed, super.handleDrawInt, super.autoComplete,
      {this.canDrag = true,
      this.childWhenDragging = const SizedBox(height: 0, width: 0),
      super.showCard});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      maxSimultaneousDrags: canDrag ? 1 : 0,
      data: card == null ? null : [card!],
      dragAnchorStrategy: pointerDragAnchorStrategy,
      childWhenDragging: childWhenDragging,
      feedback: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: FractionalTranslation(
            translation: Offset(-0.5, -0.5), child: super.build(context)),
      ),
      child: super.build(context),
    );
  }
}
