import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/database_models/lobby_model.dart';
import 'package:ripple/models/game_invite.dart';
import 'package:ripple/providers/game_invite_provider.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/lobby_provider.dart';
import 'package:ripple/ui/profile/input_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameInvites extends HookConsumerWidget {
  final String _user;
  const GameInvites(this._user);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inviteProvider = ref.watch(gameInvitesProvider(_user));

    return inviteProvider.when(data: (invites) {
      if (invites.isEmpty) {
        return Text(
          "No pending game invitations",
          style: Theme.of(context).textTheme.bodyLarge,
        );
      } else {
        return Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.25,
            child: ListView.separated(
              itemCount: invites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: InputBackground(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${invites[index].fromPlayer.displayName} invited you to join their ${invites[index].gameType.screenName} game!",
                        ),
                        Row(children: [
                          IconButton(
                            onPressed: () async {
                              await handleAcceptInvite(
                                context,
                                ref,
                                invites[index],
                              );
                            },
                            icon: Icon(Icons.arrow_forward),
                            tooltip: "Join",
                          ),
                          IconButton(
                            onPressed: () async {
                              await handleDeclineInvite(
                                  context, ref, invites[index]);
                            },
                            icon: Icon(Icons.cancel_rounded),
                            tooltip: "Ignore",
                          ),
                        ]),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(),
            ),
          ),
        );
      }
    }, loading: () {
      return Text("");
    }, error: (Object error, StackTrace stackTrace) {
      print("Error occurred displaying game invites: $error");
      return Text("");
    });
  }

  Future<void> handleAcceptInvite(
      BuildContext context, WidgetRef ref, GameInvite invite) async {
    // join the game
    final notifier = ref.read(lobbyNotifierProvider(invite.lobbyCode).notifier);
    LobbyModel lobby;
    try {
      lobby = await notifier.joinGame();
      var gameNotifier =
          ref.read(lobby.gameType.provider(invite.lobbyCode).notifier);
      await gameNotifier.joinGame();

      if (context.mounted) {
        if (lobby.gameStatus == GameStatus.playing) {
          final (routeName, params) = gameNotifier.getGameRoutingInfo();
          context.goNamed(routeName, pathParameters: params);
        } else {
          final (routeName, params) = gameNotifier.getLobbyRoutingInfo();
          context.goNamed(routeName, pathParameters: params);
        }
      }

      await ref.read(gameInvitesProvider(_user).notifier).acceptInvite(invite);
    } on GameFullException {
      print(
          "GameFullException when joining game from invite: ${invite.lobbyCode}");
      if (!context.mounted) {
        return;
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Lobby is full!",
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).maybePop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              ));

      await handleDeclineInvite(context, ref, invite);
    } on GameNotFoundException {
      print("GameNotFoundException when joining game from invite");
    } catch (e) {
      print("Encountered an unexpected error joining game: $e");
      rethrow;
    }
  }

  Future<void> handleDeclineInvite(
      BuildContext context, WidgetRef ref, GameInvite invite) async {
    // update database
    await ref.read(gameInvitesProvider(_user).notifier).declineInvite(invite);
  }
}
