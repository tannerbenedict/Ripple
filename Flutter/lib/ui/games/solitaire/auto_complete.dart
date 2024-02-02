import 'package:ripple/ui/games/solitaire/solitaire_game_state.dart';
import 'package:flutter/material.dart';

class AutoComplete extends StatelessWidget {
  final SolitaireGameState state;

  AutoComplete({required this.state});

  @override
  Widget build(BuildContext context) {
    // Build your UI using the data from CustomData
    return Column(
      children: [
        Text('List 1: ${state.columns}'),
        Text('List 2: ${state.sets}'),
      ],
    );
  }
}