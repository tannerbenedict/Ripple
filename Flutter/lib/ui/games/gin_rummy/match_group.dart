import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MatchGroup extends StatelessWidget {
  const MatchGroup(
      {super.key, required this.matchGroup, required this.cardSize});

  final List<Widget> matchGroup;
  final Size cardSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 400.ms,
      curve: Curves.easeIn,
      constraints: BoxConstraints.tight(Size(
          cardSize.width * matchGroup.length +
              (matchGroup.length - 1) * 8.0 +
              4.0,
          cardSize.height)),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8.0)),
      child: Stack(
        children: matchGroup,
      ),
    );
  }
}
