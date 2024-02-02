import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/hearts_game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

abstract class HeartsNotifier<T extends HeartsGameModel?>
    // ignore: invalid_use_of_internal_member
    extends GameNotifier<T> {
  Future<void> shuffleCards();
  Future<void> roundEnd();
  Future<void> discardCard(Card card, User user);
}

typedef HeartsNotifierProvider<T extends HeartsNotifier>
    // ignore: invalid_use_of_internal_member
    = AutoDisposeAsyncNotifierProviderImpl<T, HeartsGameModel?> Function(String,
        {int? seed});
