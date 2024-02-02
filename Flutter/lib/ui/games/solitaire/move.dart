import 'dart:core';
import 'package:ripple/models/database_models/card.dart';

class Move {
  String from;
  int fromIndex;
  String to;
  int toIndex;
  List<Card> what;
  int colHiddenRevealed;

  // Generative constructor with initializing formal parameters:
  Move(this.from, this.fromIndex, this.to, this.toIndex, this.what, this.colHiddenRevealed);
}