import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/scum_game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

abstract class ScumNotifier<T extends ScumGameModel?>
    // ignore: invalid_use_of_internal_member
    extends GameNotifier<T> {
  Future<void> discardCards(List<Card> cards, User user);
  Future<void> pass(User user);
  Future<void> shuffleCards();
  Future<void> roundEnd();
}

typedef ScumNotifierProvider<T extends ScumNotifier>
    // ignore: invalid_use_of_internal_member
    = AutoDisposeAsyncNotifierProviderImpl<T, ScumGameModel?> Function(String,
        {int? seed});
