import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/cheat_game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

abstract class CheatNotifier<T extends CheatGameModel?>
    // ignore: invalid_use_of_internal_member
    extends GameNotifier<T> {
  Future<void> discardCards(User user, List<Card> cards);
  Future<void> callCheat(User user);
}

typedef CheatNotifierProvider<T extends CheatNotifier>
    // ignore: invalid_use_of_internal_member
    = AutoDisposeAsyncNotifierProviderImpl<T, CheatGameModel?> Function(String,
        {int? seed});
