import 'dart:math';

import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/scum_local_state_notifier.dart';
import 'package:ripple/providers/game_providers/scum_notifier.dart';
import 'package:ripple/providers/game_providers/scum_notifier_online.dart';
import 'package:ripple/providers/game_providers/scum_notifier_solo.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/face_card.dart';
import 'package:ripple/ui/games/scum/scum_bot_logic.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscardPile extends ConsumerWidget {
  // Maps a player index to the direction that the player is in,
  // relative to the center.
  static const _offsetMap = {
    0: Offset(-1, 0),
    1: Offset(-1, -1),
    2: Offset(0, -1),
    3: Offset(1, -1),
    4: Offset(1, 0),
    5: Offset(0, 1),
  };

  static const _cardOverlap = 0.25;

  final String lobbyCode;
  const DiscardPile({
    required this.lobbyCode,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    ScumNotifierProvider provider = scumOnlineNotifierProvider.call;
    if (lobbyCode == "") {
      provider = scumSoloNotifierProvider.call;
    }
    final (cardsPlayed, canDiscard, appearOffset, trickWinner) =
        ref.watch(provider(lobbyCode).select((value) {
      final result = value.asData!.value!;

      final otherPlayersInOrder =
          result.players.otherPlayersInOrder(user.firebaseId);

      final previousPlayer =
          result.lastPlayed.isEmpty ? null : result.lastPlayed.last;

      return (
        result.cardsPlayed,
        result.canDiscard(user),
        previousPlayer == null
            ? null
            : _offsetMap[previousPlayer.firebaseId == user.firebaseId
                ? 5
                : otherPlayersInOrder.indexWhere((element) =>
                    element.firebaseId == previousPlayer.firebaseId)],
        result.getTrickWinner,
      );
    }));

    return DragTarget<List<Card>>(
      onWillAccept: (data) {
        return canDiscard && data != null && data.isNotEmpty;
      },
      onAccept: (data) async {
        if (ScumLogic.canDiscardCards(
            data, cardsPlayed.map((e) => e.cards).toList())) {
          ref
              .read(scumLocalStateNotifierProvider(lobbyCode).notifier)
              .clearInvalidCardsTouched();
          await ref.read(provider(lobbyCode).notifier).discardCards(data, user);
          ref
              .read(scumLocalStateNotifierProvider(lobbyCode).notifier)
              .clearSelectedCards();
        } else {
          ref
              .read(scumLocalStateNotifierProvider(lobbyCode).notifier)
              .setInvalidCardsTouched(data);
        }
      },
      builder: (context, _, __) {
        // AnimatedSwitcher doesn't support doing different transitions
        // for leaving vs entering (*cough* the web does tho *cough*),
        // so we use it to fade in/out
        // and then use flutter_animate to animate the new cards in.
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: cardsPlayed.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    child: trickWinner != null
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${trickWinner.displayName?.truncate() ?? "Opponent"} won the trick!",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          )
                            .animate()
                            .slideY(
                                begin: -0.25,
                                end: 0,
                                duration: 400.ms,
                                curve: Curves.easeOutCubic)
                            .scale(
                                begin: const Offset(1.2, 1.2),
                                end: const Offset(1, 1),
                                duration: 400.ms)
                            .fadeIn(duration: 400.ms)
                            .fadeOut(duration: 400.ms, delay: 2.seconds)
                        : const SizedBox.expand(),
                  )
                : LayoutBuilder(
                    key: ValueKey(cardsPlayed.last.cards
                        .map((e) => e.hashCode)
                        .reduce((value, element) => value ^ element)),
                    builder: (context, constraints) {
                      final cards = cardsPlayed.last.cards;
                      var cardHeight = constraints.maxHeight;
                      var cardWidth = cardHeight / FaceCard.aspectRatio;

                      if (cardWidth > constraints.maxWidth) {
                        cardWidth = constraints.maxWidth;
                        cardHeight = cardWidth * FaceCard.aspectRatio;
                      }
                      final totalCardSpace = cardWidth * cards.length -
                          (cards.length - 1) * _cardOverlap * cardWidth;
                      final padding =
                          max((constraints.maxWidth - totalCardSpace) / 2, 0);

                      final top = (constraints.maxHeight - cardHeight) / 2;

                      return Stack(
                        children: cards.indexed.map((e) {
                          final (index, card) = e;

                          final left = index * cardWidth -
                              index * cardWidth * _cardOverlap +
                              padding;

                          return Positioned(
                            top: top,
                            left: left,
                            height: cardHeight,
                            width: cardWidth,
                            child: FaceCard(card, null),
                          );
                        }).toList(),
                      ).animate(effects: [
                        SlideEffect(
                            begin: appearOffset,
                            end: Offset.zero,
                            duration: const Duration(milliseconds: 500))
                      ]);
                    }));
      },
    );
  }
}
