import 'dart:async';

import 'package:ripple/providers/friend_providers/friend_requests_provider.dart';
import 'package:ripple/providers/game_invite_provider.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/profile/friends/friends_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FriendsButton extends ConsumerWidget {
  final double iconScalingFactor;
  final FutureOr<bool> Function(BuildContext, WidgetRef) verifyLoggedIn;
  const FriendsButton(
      {super.key,
      required this.iconScalingFactor,
      required this.verifyLoggedIn});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginInfoProvider).user;
    var badgeNum = 0;
    if (user != null) {
      badgeNum = ref.watch(friendRequestsProvider(user.uid).select((value) =>
          value.maybeWhen(data: (data) => data.length, orElse: () => 0)));
      badgeNum += ref.watch(gameInvitesProvider(user.uid).select((value) =>
          value.maybeWhen(data: (data) => data.length, orElse: () => 0)));
    }

    return Badge(
      backgroundColor: Theme.of(context).colorScheme.primary,
      label: Text(badgeNum.toString()),
      isLabelVisible: badgeNum > 0,
      child: IconButton(
        onPressed: () async {
          if (await verifyLoggedIn(context, ref) && context.mounted) {
            context.goNamed(FriendsMainPage.routeName);
          }
        },
        icon: Icon(
          Icons.people,
        ),
        iconSize: MediaQuery.of(context).textScaler.scale(iconScalingFactor),
      ),
    );
  }
}
