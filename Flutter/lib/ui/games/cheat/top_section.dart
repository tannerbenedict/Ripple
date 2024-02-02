import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/cheat_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/cheat/player_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopSection extends ConsumerWidget {
  final String lobbyCode;
  final CheatNotifierProvider provider;
  const TopSection(
      {super.key, required this.lobbyCode, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginInfoProvider.select((value) => value.user));
    final otherPlayers = ref.watch(provider(lobbyCode).select((value) =>
        value.maybeWhen(
            orElse: () => [],
            data: (data) =>
                data!.otherPlayersInOrder(User.getRealOrDefaultUser(user)))));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: otherPlayers
          .getRange(1, 6)
          .map(
            (e) => Flexible(
              child: PlayerSection(
                lobbyCode: lobbyCode,
                provider: provider,
                player: e,
              ),
            ),
          )
          .toList(),
    );
  }
}
