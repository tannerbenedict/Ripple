import 'package:flutter/material.dart';

import 'face_column.dart';

class DraggableColumn extends FaceColumn {
  final Widget childWhenDragging;
  final bool canDrag;

  DraggableColumn(super.card, super.handleOnPressed,
      {this.canDrag = true,
      this.childWhenDragging = const SizedBox(height: 0, width: 0),
      super.showCard});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      maxSimultaneousDrags: canDrag ? 1 : 0,
      data: card,
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
