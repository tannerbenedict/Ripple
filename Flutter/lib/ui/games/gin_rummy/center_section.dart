import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/gin_rummy_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/gin_rummy/action_button.dart';
import 'package:ripple/ui/games/gin_rummy/action_label.dart';
import 'package:ripple/ui/games/gin_rummy/deadwood_label.dart';
import 'package:ripple/ui/games/gin_rummy/discard_pile.dart';
import 'package:ripple/ui/games/gin_rummy/draw_pile.dart';
import 'package:ripple/ui/games/gin_rummy/gin_rummy.dart';
import 'package:ripple/ui/games/gin_rummy/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CenterSection extends ConsumerWidget {
  final String lobbyCode;
  final GinRummyNotifierProvider provider;
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
          fit: FlexFit.tight,
          child: UserInfo(lobbyCode: lobbyCode, provider: provider, user: user),
        ),
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
        Flexible(
          fit: FlexFit.tight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DeadwoodLabel(lobbyCode, provider),
              ActionMessage(lobbyCode, provider),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ActionButton(lobbyCode, provider).animate().fadeIn(
                      duration: animationDuration, curve: animationCurve),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
