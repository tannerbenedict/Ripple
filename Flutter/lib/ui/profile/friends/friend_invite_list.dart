import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/providers/friends_provider.dart';
import 'package:ripple/providers/game_invite_provider.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/ui/profile/input_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FriendInviteList extends HookConsumerWidget {
  final String user;
  final String lobbyCode;
  final GameNotifierProvider notifierProvider;

  const FriendInviteList(this.user, this.lobbyCode, this.notifierProvider);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendProvider = ref.watch(friendsProvider(user));
    final (gameFull, gameType) =
        ref.watch(notifierProvider(lobbyCode).select((value) => value.maybeWhen(
              data: (data) => (data!.canStartGame(data.host), data.gameType),
              orElse: () => (false, null),
            )));
    final invitedFriends = useState(<String>{});

    // scroll controller
    final scrollController = useScrollController();
    useEffect(() {
      if (!scrollController.hasClients) return null;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 200), curve: Curves.easeOut));
      return null;
    }, [friendProvider.asData?.value]);

    // watch players joining and check if lobby is full
    if (gameFull) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.pop();
      });
    }

    return friendProvider.when(
      data: (friends) {
        return Dialog(
            insetPadding:
                EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Invite Friends to Lobby',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ]),
              (friends.isEmpty)
                  ? Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "No one here to invite. Start adding friends!",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ))
                  : Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: friends.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Column(children: [
                            InputBackground(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  friends[index].displayName,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    invitedFriends.value = {
                                      ...invitedFriends.value,
                                      friends[index].userId
                                    };
                                    await handleGameInvite(
                                        ref,
                                        friends[index].userId,
                                        lobbyCode,
                                        gameType!);
                                  },
                                  icon: Icon(invitedFriends.value
                                          .contains(friends[index].userId)
                                      ? Icons.check
                                      : Icons.add_outlined),
                                  tooltip: "Invite friend",
                                ),
                              ],
                            ))
                          ]));
                        },
                        separatorBuilder: (context, index) => SizedBox(),
                      ),
                    )
            ]));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stack) {
        print("Error occurred loading friends: $error");
        return _showError(error);
      },
    );
  }

  Future<void> handleGameInvite(
      WidgetRef ref, String friendId, String lobbyCode, GameType type) async {
    await ref
        .read(gameInvitesProvider(user).notifier)
        .sendInvite(friendId, lobbyCode, type);
  }

  Widget _showError(Object error) {
    print(error);
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Icon(Icons.error),
        subtitle: Text(
          "Error loading friends!",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
