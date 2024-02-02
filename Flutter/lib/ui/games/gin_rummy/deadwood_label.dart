import 'package:ripple/models/user.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ripple/providers/game_providers/gin_rummy_notifier.dart';

class DeadwoodLabel extends ConsumerWidget {
  final GinRummyNotifierProvider provider;
  final String lobbyCode;
  const DeadwoodLabel(
    this.lobbyCode,
    this.provider, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    final totalDeadwood = ref.watch(provider(lobbyCode)
        .select((value) => value.asData!.value!.calcPlayerDeadwood(user)));

    return Text(
      'Deadwood: $totalDeadwood',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
