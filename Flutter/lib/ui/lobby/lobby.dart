import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/lobby_provider.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/chat/chat_room.dart';
import 'package:ripple/ui/games/hearts/player_avatar.dart';
import 'package:ripple/ui/lobby/ok_dialog.dart';
import 'package:ripple/ui/profile/friends/friend_invite_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LobbyPage extends HookConsumerWidget {
  static const routeName = "lobbyPage";
  final String lobbyCode;
  final GameNotifierProvider notifierProvider;
  LobbyPage({
    super.key,
    required this.lobbyCode,
    required this.notifierProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAlreadyShown = useState(<User>[]);
    final game = ref.watch(notifierProvider(lobbyCode));
    final notifier = ref.read(notifierProvider(lobbyCode).notifier);
    final loginState = ref.watch(loginInfoProvider);

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? Image.asset("./images/oak_background.jpg").image
                      : Image.asset("./images/dark_background.jpg").image,
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // watch how many players have joined and check if lobby is full yet
          appBar: game.when(data: (data) {
            bool isReadyToStart =
                data == null ? false : data.canStartGame(data.host);

            return AppBar(
              title: Text("${game.asData?.value?.gameType.screenName} Lobby"),
              leading: BackButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "Are you sure you want\nto leave the lobby?",
                        textAlign: TextAlign.center,
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        ElevatedButton(
                          style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style
                                  ?.copyWith(
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).colorScheme.error),
                                  ) ??
                              ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  foregroundColor:
                                      Theme.of(context).colorScheme.error),
                          onPressed: () {
                            ref
                                .read(notifierProvider(lobbyCode).notifier)
                                .notPlayingAgain();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Yes"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).maybePop();
                          },
                          child: const Text("No"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.person_add),
                  tooltip: "Invite friends",
                  onPressed: () {
                    isReadyToStart
                        ? showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                    "Lobby is full",
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
                                ))
                        : showDialog(
                            context: context,
                            builder: (context) => FriendInviteList(
                                User.fromFirebaseUser(loginState.user!)
                                    .firebaseId,
                                lobbyCode,
                                notifierProvider));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.message_outlined),
                  tooltip: "Chat",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ChatRoom(lobbyCode,
                          User.fromFirebaseUser(loginState.user!).firebaseId),
                    );
                  },
                ),
              ],
            );
          }, loading: () {
            return null;
          }, error: (Object error, StackTrace stackTrace) {
            return null;
          }),
          body: game.when(
            data: (data) {
              if (data == null) {
                return Text(
                    "Sorry, but it looks like your game doesn't exist. Please try to create or join another game.");
              }

              for (var player in data.playersNotPlaying) {
                if (!usersAlreadyShown.value.contains(player) &&
                    !data.playersPlaying.contains(player) &&
                    player != User.fromFirebaseUser(loginState.user!)) {
                  usersAlreadyShown.value = [
                    ...usersAlreadyShown.value,
                    player
                  ];
                  _showPlayerLeftDialog(context, player);
                }
              }

              if (data.playersNotPlaying.contains(data.host)) {
                ref.read(notifierProvider(lobbyCode).notifier).updateHost();
              }

              if (data.gameStatus == GameStatus.playing) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final (routeName, params) = notifier.getGameRoutingInfo();
                  context.goNamed(routeName, pathParameters: params);
                });
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Your lobby code is $lobbyCode",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final player = data.playersPlaying[index];

                            return ListTile(
                              leading: PlayerAvatar(
                                player: player,
                                isPlayerTurn: data.host == player,
                              ),
                              title: Text(player.displayName ?? "Anonymous"),
                            );
                          },
                          separatorBuilder: (_, __) => const Divider(),
                          itemCount: data.playersPlaying.length),
                    ),
                    if (data.playersPlaying.length <
                        data.gameType.requiredPlayerCount)
                      Center(
                        child: Text(
                          "Waiting for ${data.gameType.requiredPlayerCount - data.playersPlaying.length} more player${data.gameType.requiredPlayerCount - data.playersPlaying.length > 1 ? "s" : ""}",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          onPressed: data.canStartGame(
                                  User.fromFirebaseUser(loginState.user!))
                              ? () async {
                                  await notifier.startGame();
                                  await ref
                                      .read(lobbyNotifierProvider(lobbyCode)
                                          .notifier)
                                      .startGame();
                                }
                              : null,
                          icon: const Icon(Icons.start),
                          label: const Text("Start")),
                    )
                  ],
                ),
              );
            },
            error: (error, stackTrace) =>
                Text("Sorry, something went wrong. Please try again."),
            loading: () => CircularProgressIndicator(),
          ),
        ));
  }

  void _showPlayerLeftDialog(BuildContext context, User user) async {
    return WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
          context: context, builder: (BuildContext context) => OkDialog(user));
    });
  }
}
