import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/fanned_hand.dart';
import 'package:ripple/ui/games/gin_rummy/animated_hand.dart';
import 'package:ripple/ui/games/gin_rummy/gin_rummy_bot_logic.dart';
import 'package:ripple/ui/games/gin_rummy/gin_rummy.dart';
import 'package:ripple/ui/games/gin_rummy/user_info.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ripple/providers/game_providers/gin_rummy_notifier.dart';

import '../face_card.dart';
import 'match_group.dart';

class TopSection extends ConsumerWidget {
  final GinRummyNotifierProvider provider;
  final String lobbyCode;
  const TopSection(this.lobbyCode, this.provider, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));

    final (opponent, showCards, drawnCard) =
        ref.watch(provider(lobbyCode).select((value) {
      final data = value.asData!.value!;
      final opponent =
          data.players.firstWhere((e) => e.firebaseId != user.firebaseId);

      return (
        opponent,
        data.gameStatus == GameStatus.roundEnded ||
            data.gameStatus == GameStatus.finished,
        data.drawnCard,
      );
    }));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(child: SizedBox.expand()),
        Flexible(
          flex: 3,
          child: AnimatedSwitcher(
            duration: animationDuration,
            switchInCurve: animationCurve,
            switchOutCurve: animationCurve,
            transitionBuilder: (child, animation) => SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ),
              ),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
            child: RotatedBox(
              quarterTurns: showCards ? 0 : 2,
              child: FannedHand(
                key: ValueKey(showCards),
                gameNotifierProvider: provider,
                lobbyCode: lobbyCode,
                player: opponent,
                cardOverlap: 0.25,
                sorter: showCards
                    ? (cards) {
                        final matched = GinRummyLogic.getMatched(cards);
                        final deadwood =
                            GinRummyLogic.getDeadwood(cards, matched);

                        return [
                          ...matched.expand((element) => element),
                          ...deadwood
                        ];
                      }
                    : (cards) {
                        return cards..sort(Card.sortByValue);
                      },
                builder: (context, card) {
                  final effects = <Effect>[];
                  if (showCards) {
                    effects.add(
                      FlipEffect(
                        curve: animationCurve,
                        duration: animationDuration,
                        direction: Axis.horizontal,
                      ),
                    );
                  }
                  if (card == drawnCard) {
                    effects.add(
                      SlideEffect(
                        curve: animationCurve,
                        duration: animationDuration,
                        begin: const Offset(0, -1),
                      ),
                    );
                  }
                  return FaceCard(card, null, showCard: showCards)
                      .animate(effects: effects);
                },
              ),
            ),
          ),
        ),
        Flexible(
            fit: FlexFit.tight,
            child: UserInfo(
              lobbyCode: lobbyCode,
              user: opponent,
              provider: provider,
            )),
      ],
    );
  }
}
