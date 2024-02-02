import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/cheat_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MessageSection extends ConsumerWidget {
  final String lobbyCode;
  final CheatNotifierProvider provider;

  const MessageSection({
    super.key,
    required this.lobbyCode,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginInfoProvider
        .select((value) => User.getRealOrDefaultUser(value.user)));
    final (
      isRoundEnd,
      calledCheat,
      cheatCaller,
      previousPlayer,
      lastCards,
      previousValue,
      roundWinner
    ) = ref.watch(provider(lobbyCode).select((value) => value.maybeWhen(
          orElse: () => (false, false, null, null, null, null, null),
          data: (data) => (
            data!.isRoundEnd,
            data.calledCheat,
            data.playerWhoCalledCheat,
            data.playerWhoPlayed,
            data.lastPlayedCards,
            data.previousFaceValue,
            data.potentialWinner
          ),
        )));

    Widget child;
    final style = DefaultTextStyle.of(context).style.copyWith(fontSize: 18);

    if (isRoundEnd) {
      child = Text.rich(TextSpan(
        children: [
          TextSpan(
              text:
                  "${roundWinner!.displayName?.truncate(maxLength: 10)} won the round!"),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.ideographic,
            child: Icon(
              MdiIcons.trophy,
            ),
          ),
        ],
        style: style,
      ));
    } else if (calledCheat) {
      child = Text(
          "${cheatCaller!.displayName?.truncate(maxLength: 10)} called cheat!",
          style: style);
    } else if (previousPlayer != null &&
        (lastCards != null && lastCards.isNotEmpty) &&
        previousValue != null) {
      child = Text.rich(TextSpan(style: style, children: [
        TextSpan(
            text:
                "${previousPlayer == user ? "You" : previousPlayer.displayName?.truncate(maxLength: 10)} played ${lastCards.length} "),
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.ideographic,
          child: Icon(
            previousValue.asIcon,
          ),
        ),
        if (lastCards.length > 1) TextSpan(text: "'s"),
      ]));
    } else {
      child = SizedBox.expand();
    }

    return Center(child: child);
  }
}
