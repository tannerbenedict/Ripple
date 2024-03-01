import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/game_providers/two_player_notifier.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ripple/ui/games/two_player/player_card.dart';

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
  final TwoPlayerNotifierProvider gameNotifierProvider;
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
                PlayerCard(lobbyCode, gameNotifierProvider, playerHand[0], 0),
                PlayerCard(lobbyCode, gameNotifierProvider, playerHand[1], 1),
                PlayerCard(lobbyCode, gameNotifierProvider, playerHand[2], 2),
                PlayerCard(lobbyCode, gameNotifierProvider, playerHand[3], 3),
                PlayerCard(lobbyCode, gameNotifierProvider, playerHand[4], 4),
              ],
            )),
            Flexible(
                child: Row(
              children: [
                PlayerCard(lobbyCode, gameNotifierProvider, playerHand[5], 5),
                PlayerCard(lobbyCode, gameNotifierProvider, playerHand[6], 6),
                PlayerCard(lobbyCode, gameNotifierProvider, playerHand[7], 7),
                PlayerCard(lobbyCode, gameNotifierProvider, playerHand[8], 8),
                PlayerCard(lobbyCode, gameNotifierProvider, playerHand[9], 9),
              ],
            )),
          ],
        )
      ],
    );
  }
}
