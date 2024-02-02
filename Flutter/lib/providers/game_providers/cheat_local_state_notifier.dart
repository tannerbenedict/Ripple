import 'package:ripple/models/database_models/card.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheatLocalStateNotifier extends ChangeNotifier {
  final String lobbyCode;
  final List<Card> selectedCards;

  CheatLocalStateNotifier({
    required this.lobbyCode,
    this.selectedCards = const <Card>[],
  }) : super();

  void toggleSelectedCard(Card card) {
    if (selectedCards.contains(card)) {
      selectedCards.remove(card);
    } else {
      selectedCards.add(card);
    }
    notifyListeners();
  }

  void clearSelectedCards() {
    selectedCards.clear();
    notifyListeners();
  }
}

final cheatLocalStateNotifierProvider = ChangeNotifierProvider.autoDispose
    .family<CheatLocalStateNotifier, String>((ref, lobbyCode) {
  return CheatLocalStateNotifier(lobbyCode: lobbyCode, selectedCards: []);
});
