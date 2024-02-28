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

typedef CardBuilder = Widget Function(BuildContext context, Card card);

Widget defaultCardBuilder(BuildContext context, Card card) {
  return FaceCard(
    card,
    null,
    showCard: true,
  );
}

class PlayerHand extends ConsumerWidget {
  static const _surroundingPadding = 8.0;

  final String lobbyCode;
  final GameNotifierProvider gameNotifierProvider;
  final User player;
  final Duration animationDuration;
  final CardBuilder builder;

  const PlayerHand({
    required this.player,
    required this.lobbyCode,
    required this.gameNotifierProvider,
    this.animationDuration = const Duration(milliseconds: 500),
    this.builder = defaultCardBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerHand = ref.watch(gameNotifierProvider(lobbyCode).select(
        (value) => value.asData!.value!.playerHands[player.firebaseId]!));

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
                child: Row(
              children: [
                defaultCardBuilder(context, playerHand[0]),
                defaultCardBuilder(context, playerHand[1]),
                defaultCardBuilder(context, playerHand[2]),
                defaultCardBuilder(context, playerHand[3]),
                defaultCardBuilder(context, playerHand[4]),
              ],
            )),
            Flexible(
                child: Row(
              children: [
                defaultCardBuilder(context, playerHand[5]),
                defaultCardBuilder(context, playerHand[6]),
                defaultCardBuilder(context, playerHand[7]),
                defaultCardBuilder(context, playerHand[8]),
                defaultCardBuilder(context, playerHand[9]),
              ],
            )),
          ],
        )
      ],
    );
  }
}
