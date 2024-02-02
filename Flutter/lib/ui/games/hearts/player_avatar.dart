import 'package:ripple/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:random_avatar/random_avatar.dart';

class PlayerAvatar extends StatelessWidget {
  final User player;
  final bool isPlayerTurn;

  const PlayerAvatar({
    super.key,
    required this.player,
    required this.isPlayerTurn,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedContainer(
        key: ValueKey(player),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          border: Border.all(
            color: isPlayerTurn
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
            width: 4,
          ),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          child: RandomAvatar(player.firebaseId == "player"
            ? "player"
              : player.displayName ?? player.email ?? player.firebaseId),
        ).animate(
            onPlay: (controller) => controller.repeat(
                reverse: true, period: const Duration(seconds: 2)),
            effects: isPlayerTurn
                ? [
                    ShimmerEffect(
                      duration: const Duration(seconds: 2),
                      colors: [
                        Colors.transparent,
                        Theme.of(context).colorScheme.primary,
                        Colors.transparent
                      ],
                    )
                  ]
                : []),
      ),
    );
  }
}
