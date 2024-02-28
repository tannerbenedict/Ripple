
import 'package:ripple/providers/game_providers/two_player_notifier.dart';
import 'package:ripple/providers/game_providers/two_player_notifier_online.dart';
import 'package:ripple/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum WinnerStatus {
  winner,
  loser;
}

class GameOver extends ConsumerWidget {
  final String lobbyCode;
  final WinnerStatus status;
  final TwoPlayerNotifierProvider provider;

  const GameOver(this.lobbyCode, this.status, this.provider, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final provider = ref.watch(ginRummyNotifierProvider(lobbyCode).notifier);
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: status == WinnerStatus.winner
          ? const Text("You Win")
          : const Text("You Lose"),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('Would you like to play again or return home?'),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text(
            'Play Again',
          ),
          onPressed: () async {
            ref.read(provider(lobbyCode).notifier).playingAgain();

            final (routeName, params) =
                ref.read(provider(lobbyCode).notifier).getLobbyRoutingInfo();

            context.goNamed(routeName, pathParameters: params);
            context.pop();
          },
        ),
        ElevatedButton(
          child: Text(
            'Return Home',
          ),
          onPressed: () {
            if (lobbyCode != "") {
              ref
                  .read(twoPlayerNotifierOnlineProvider(lobbyCode).notifier)
                  .notPlayingAgain();
            }
            context.goNamed(HomePage.routeName);

            // context.goNamed(HomePage.routeName);
            // context.pop();
            // ref
            //     .read(ginRummyNotifierProvider(lobbyCode).notifier)
            //     .notPlayingAgain();

            // context.goNamed(HomePage.routeName);
          },
        )
      ],
    );
  }
}