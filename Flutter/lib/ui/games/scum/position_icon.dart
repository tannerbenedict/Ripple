import 'package:ripple/models/database_models/scum_game_model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PositionIcon extends StatelessWidget {
  final PlayerPosition? position;
  const PositionIcon({required this.position, super.key});

  @override
  Widget build(BuildContext context) {
    Icon icon;
    switch (position) {
      case PlayerPosition.scum:
        icon = Icon(MdiIcons.skullCrossbones);
      case PlayerPosition.viceScum:
        icon = Icon(MdiIcons.skull);
      case PlayerPosition.vicePresident:
        icon = Icon(MdiIcons.chessQueen);
      case PlayerPosition.president:
        icon = Icon(MdiIcons.chessKing);
      default:
        icon = Icon(MdiIcons.pitchfork);
    }

    return icon;
  }
}
