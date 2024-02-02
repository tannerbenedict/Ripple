import 'package:ripple/models/database_models/card.dart';
import 'package:flutter/material.dart' hide Card;


class OutlinedCardPile extends StatelessWidget {
  final List<Card>? topCard;
  final void Function(List<Card>)? handleTap;
  final Widget? icon;
  final bool canTap;

  const OutlinedCardPile(this.topCard, this.handleTap, this.icon, this.canTap,
      {super.key});

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 5, color: Theme.of(context).colorScheme.background),
          color: Colors.transparent,
        ),
        width: 224,
        height: 312,
        child: AspectRatio(
            aspectRatio: 224 / 312, child: SizedBox.expand(child: icon)));

    if (MediaQuery.sizeOf(context).width < 1580 ||
        MediaQuery.sizeOf(context).height < 648) {
      child = AspectRatio(
          aspectRatio: 224 / 312,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 5, color: Theme.of(context).colorScheme.background),
                color: Colors.transparent,
              ),
              width: 224,
              height: 312,
              child: AspectRatio(
                  aspectRatio: 224 / 312,
                  child: SizedBox.expand(child: icon))));
    }
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
            onTap: canTap
                ? () {
                    handleTap!(topCard!);
                  }
                : null,
            child: child));
  }
}
