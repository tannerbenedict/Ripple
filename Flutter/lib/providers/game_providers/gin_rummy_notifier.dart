import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/gin_rummy_game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

abstract class GinRummyNotifier<T extends GinRummyGameModel?>
    // ignore: invalid_use_of_internal_member
    extends GameNotifier<T> {
  Future<void> passTurn(User user);
  Future<void> knock(Card cardToDiscard, User user);
  Future<void> startNewRound();
  Future<void> playGameAgain();
  Future<void> drawDiscardPile(User user);
  Future<void> drawDrawPile(User user);
  Future<void> discardCard(Card card, User user);
}

typedef GinRummyNotifierProvider<T extends GinRummyNotifier>
    // ignore: invalid_use_of_internal_member
    = AutoDisposeAsyncNotifierProviderImpl<T, GinRummyGameModel?>
        Function(String, {int? seed});
