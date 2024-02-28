import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/two_player_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ripple/ui/games/player_avatar.dart';

class UserInfo extends ConsumerWidget {
  final String lobbyCode;
  final TwoPlayerNotifierProvider provider;
  final User user;

  const UserInfo({
    super.key,
    required this.lobbyCode,
    required this.provider,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (score, isPlayerTurn) = ref.watch(provider(lobbyCode).select((value) {
      final data = value.asData!.value!;
      return (
        data.playerScores[user.firebaseId] ?? 0,
        data.currentPlayer == user
      );
    }));

    var style = Theme.of(context).textTheme.titleSmall;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PlayerAvatar(player: user, isPlayerTurn: isPlayerTurn),
        Text(user.displayName?.truncate() ?? "Unknown", style: style),
        Text(
          "Score: $score",
          style: style,
        ),
      ],
    );
  }
}
