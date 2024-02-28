import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/two_player_notifier.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ripple/ui/games/two_player/player_hand.dart';
import 'package:ripple/ui/games/two_player/user_info.dart';

import '../face_card.dart';

class TopSection extends ConsumerWidget {
  final TwoPlayerNotifierProvider provider;
  final String lobbyCode;
  const TopSection(this.lobbyCode, this.provider, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));

    final (opponent) = ref.watch(provider(lobbyCode).select((value) {
      final data = value.asData!.value!;
      final opponent =
          data.players.firstWhere((e) => e.firebaseId != user.firebaseId);

      return (opponent);
    }));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(child: SizedBox.expand()),
        Flexible(
          child: PlayerHand(
            gameNotifierProvider: provider,
            lobbyCode: lobbyCode,
            player: opponent,
            builder: (context, card) {
              return FaceCard(card, null);
            },
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
