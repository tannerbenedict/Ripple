import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../profile/profile_main_page.dart';

const iconScalingFactor = 40.0;

class ProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.goNamed(ProfileMainPage.routeName);
        },
        icon: Icon(
          Icons.person,
        ),
        iconSize: MediaQuery.of(context).textScaler.scale(iconScalingFactor));
  }
}
