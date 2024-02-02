import 'dart:core';
import 'package:ripple/models/database_models/card.dart';

class SolitaireGameState {
  List<List<List<Card>>> columns = [];
  List<List<Card>> sets = [];

  SolitaireGameState(this.columns, this.sets);
}
