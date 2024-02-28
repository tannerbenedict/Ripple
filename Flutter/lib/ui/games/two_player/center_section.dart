import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/two_player_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/two_player/draw_pile.dart';
import 'package:ripple/ui/games/two_player/discard_pile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ripple/ui/games/two_player/user_info.dart';

class CenterSection extends ConsumerWidget {
  final String lobbyCode;
  final TwoPlayerNotifierProvider provider;
  const CenterSection({
    super.key,
    required this.lobbyCode,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
            child: DiscardPile(
          lobbyCode,
          provider,
        )),
        Flexible(
            child: DrawPile(
          lobbyCode,
          provider,
        )),
      ],
    );
  }
}
