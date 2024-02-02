import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/cheat_local_state_notifier.dart';
import 'package:ripple/providers/game_providers/cheat_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/fanned_stack.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _playerIndexDirectionMap = [
  Offset(-1, 0),
  Offset(-1, -1),
  Offset(-0.5, -1),
  Offset(0, -1),
  Offset(0.5, -1),
  Offset(1, -1),
  Offset(1, 0),
  Offset(0, 1)
];

class DiscardPile extends ConsumerWidget {
  final String lobbyCode;
  final CheatNotifierProvider provider;
  const DiscardPile({
    super.key,
    required this.lobbyCode,
    required this.provider,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginInfoProvider.select((value) => value.user));
    final (
      lastPlayedCards,
      isPlayerTurn,
      isRoundEnd,
      cheatCalled,
      otherPlayersInOrder,
      playerWhoPlayed,
      playerWhoGotCards,
    ) = ref.watch(provider(lobbyCode).select((value) => value.maybeWhen(
        orElse: () => (<Card>[], false, false, false, <User>[], null, null),
        data: (data) {
          return (
            data!.lastPlayedCards,
            data.currentPlayer == User.getRealOrDefaultUser(user),
            data.isRoundEnd,
            data.calledCheat,
            data.otherPlayersInOrder(User.getRealOrDefaultUser(user)),
            data.playerWhoPlayed,
            data.playerWhoGotCards,
          );
        })));

    return DragTarget<List<Card>>(
      onWillAccept: (data) {
        return data != null &&
            data.isNotEmpty &&
            isPlayerTurn &&
            !isRoundEnd &&
            !cheatCalled;
      },
      onAccept: (data) async {
        await ref
            .read(provider(lobbyCode).notifier)
            .discardCards(User.getRealOrDefaultUser(user), data);
        ref
            .read(cheatLocalStateNotifierProvider(lobbyCode).notifier)
            .clearSelectedCards();
      },
      builder: (context, _, __) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (child, animation) {
            // We're basically defaulting to a fade transition and only
            // using a slide transition to bring cards in when played and out
            // when someone "wins" them.
            if (child is Container ||
                (animation.status == AnimationStatus.reverse &&
                    playerWhoGotCards == null) ||
                playerWhoPlayed == null ||
                animation.status == AnimationStatus.dismissed ||
                animation.status == AnimationStatus.completed) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
              // someone played some cards, figure out where they came from,
            } else if (animation.status == AnimationStatus.forward &&
                playerWhoGotCards == null) {
              final index = playerWhoPlayed == User.getRealOrDefaultUser(user)
                  ? 7
                  : otherPlayersInOrder.indexOf(playerWhoPlayed);

              final beginOffset = _playerIndexDirectionMap[index];
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: beginOffset, end: Offset.zero),
                ),
                child: child,
              );
              // Someone "won" some cards, figure out where they should go.
            } else {
              final index = playerWhoGotCards == User.getRealOrDefaultUser(user)
                  ? 7
                  : otherPlayersInOrder
                      .indexWhere((element) => element == playerWhoGotCards);

              final beginOffset = _playerIndexDirectionMap[index];
              // At this point, the animation will be running in reverse, so
              // we need to flip the begin and end offsets.
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: animation.drive(
                    Tween(begin: beginOffset, end: Offset.zero),
                  ),
                  child: child,
                ),
              );
            }
          },
          child: lastPlayedCards?.isEmpty ?? true
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onBackground,
                        width: 4),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                )
              : FannedStack(
                  key: ValueKey(lastPlayedCards!.reducedHashCode),
                  cards: lastPlayedCards,
                  showCards: cheatCalled,
                ),
        );
      },
    );
  }
}
