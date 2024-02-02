import 'package:ripple/models/database_models/card.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScumLocalStateNotifier extends ChangeNotifier {
  final List<Card> selectedCards;
  final List<Card> invalidCardsTouched;

  ScumLocalStateNotifier({
    required this.selectedCards,
    required this.invalidCardsTouched,
  }) : super();

  void addSelectedCard(Card card) {
    selectedCards.add(card);
    notifyListeners();
  }

  void removeSelectedCard(Card card) {
    selectedCards.remove(card);
    notifyListeners();
  }

  void setInvalidCardsTouched(List<Card> cards) {
    invalidCardsTouched.clear();
    invalidCardsTouched.addAll(cards);
    notifyListeners();
  }

  void clearSelectedCards() {
    selectedCards.clear();
    notifyListeners();
  }

  void clearInvalidCardsTouched() {
    invalidCardsTouched.clear();
    notifyListeners();
  }
}

final scumLocalStateNotifierProvider = ChangeNotifierProvider.autoDispose
    .family<ScumLocalStateNotifier, String>((ref, lobbyCode) {
  return ScumLocalStateNotifier(
    selectedCards: [],
    invalidCardsTouched: [],
  );
});
