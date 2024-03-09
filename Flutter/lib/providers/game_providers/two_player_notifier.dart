import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/two_player_game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

abstract class TwoPlayerNotifier<T extends TwoPlayerGameModel?>
    // ignore: invalid_use_of_internal_member
    extends GameNotifier<T> {
  Future<void> startNewRound();
  Future<void> playGameAgain();
  Future<void> drawDiscardPile(User user);
  Future<void> drawDrawPile(User user);
  Future<void> discardCard(Card card, User user);
  Future<void> flipCards(User user);
  Future<void> userFlipCard(User user, int index);
  Future<void> placeCard(Card card, User user, int index);
}

typedef TwoPlayerNotifierProvider<T extends TwoPlayerNotifier>
    // ignore: invalid_use_of_internal_member
    = AutoDisposeAsyncNotifierProviderImpl<T, TwoPlayerGameModel?>
        Function(String, {int? seed});
