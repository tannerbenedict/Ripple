import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/cheat_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/games/cheat/player_section.dart';
import 'package:ripple/ui/games/cheat/message_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'discard_pile.dart';

class CenterSection extends ConsumerWidget {
  final String lobbyCode;
  final CheatNotifierProvider provider;

  const CenterSection({
    super.key,
    required this.lobbyCode,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginInfoProvider.select((value) => value.user));
    final (leftPlayer, rightPlayer, currentFaceValue) =
        ref.watch(provider(lobbyCode).select((data) {
      final others = data.asData!.value!
          .otherPlayersInOrder(User.getRealOrDefaultUser(user));
      return (others[0], others[6], data.asData!.value!.currentFaceValue);
    }));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: PlayerSection(
            lobbyCode: lobbyCode,
            provider: provider,
            player: leftPlayer,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Playing ",
                  ),
                  WidgetSpan(
                    child: Icon(currentFaceValue.asIcon),
                    baseline: TextBaseline.ideographic,
                    alignment: PlaceholderAlignment.baseline,
                  )
                ],
                style:
                    DefaultTextStyle.of(context).style.copyWith(fontSize: 18),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: DiscardPile(
                  lobbyCode: lobbyCode,
                  provider: provider,
                ),
              ),
            ],
          ),
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MessageSection(lobbyCode: lobbyCode, provider: provider),
        )),
        Flexible(
          child: PlayerSection(
            lobbyCode: lobbyCode,
            provider: provider,
            player: rightPlayer,
          ),
        )
      ],
    );
  }
}
