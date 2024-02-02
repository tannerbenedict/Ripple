import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/draggable_face_card.dart';
import 'package:ripple/ui/games/fanned_hand.dart';
import 'package:ripple/ui/games/gin_rummy/action_button.dart';
import 'package:ripple/ui/games/gin_rummy/gin_rummy.dart';
import 'package:ripple/ui/games/gin_rummy/gin_rummy_bot_logic.dart';
import 'package:ripple/ui/games/gin_rummy/user_info.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ripple/providers/game_providers/gin_rummy_notifier.dart';

class BottomSection extends ConsumerWidget {
  final GinRummyNotifierProvider provider;
  final String lobbyCode;

  const BottomSection(
    this.lobbyCode,
    this.provider, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    final (playerHand, canDraw, topDiscardCard, canDiscard, drawnCard) =
        ref.watch(provider(lobbyCode).select((value) {
      final data = value.asData!.value!;
      return (
        data.playerHands[user.firebaseId]!,
        data.playerCanDrawDrawPile(user) && data.playerCanDrawDiscardPile(user),
        data.discardPile.lastOrNull,
        data.playerCanDiscard(user),
        data.drawnCard,
      );
    }));

    final matches = GinRummyLogic.getMatched(playerHand);
    final deadwoodCards = GinRummyLogic.getDeadwood(playerHand, matches);
    final deadwood = GinRummyLogic.calculateDeadwood(deadwoodCards);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 4,
          child: DragTarget<Card>(
            onWillAccept: (data) => canDraw && !playerHand.contains(data),
            onAccept: (data) async {
              if (data == topDiscardCard) {
                await ref
                    .read(provider(lobbyCode).notifier)
                    .drawDiscardPile(user);
              } else {
                await ref.read(provider(lobbyCode).notifier).drawDrawPile(user);
              }
            },
            builder: (context, _, __) => FannedHand(
                gameNotifierProvider: provider,
                lobbyCode: lobbyCode,
                player: user,
                cardOverlap: 0.25,
                sorter: (cards) {
                  final matched = GinRummyLogic.getMatched(cards);
                  final deadwood = GinRummyLogic.getDeadwood(cards, matched);

                  return [...matched.expand((element) => element), ...deadwood];
                },
                builder: (context, card) {
                  return DraggableFaceCard(
                    card,
                    canDiscard
                        ? (data) async => await ref
                            .read(provider(lobbyCode).notifier)
                            .discardCard(data, user)
                        : null,
                    showCard: true,
                    canDrag: canDiscard,
                    data: card,
                  ).animate(
                      effects: drawnCard == card
                          ? [
                              FadeEffect(
                                duration: animationDuration,
                                curve: animationCurve,
                                begin: 0,
                                end: 1,
                              ),
                              SlideEffect(
                                  duration: animationDuration,
                                  curve: animationCurve,
                                  begin: const Offset(0, -1))
                            ]
                          : []);
                }),
          ),
        ),
      ],
    );
  }
}
