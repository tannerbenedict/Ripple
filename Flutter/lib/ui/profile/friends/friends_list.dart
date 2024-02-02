import 'package:ripple/providers/friends_provider.dart';
import 'package:ripple/ui/profile/friends/game_invites.dart';
import 'package:ripple/ui/profile/input_background.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FriendList extends HookConsumerWidget {
  final String _user;
  const FriendList(this._user);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendProvider = ref.watch(friendsProvider(_user));

    return friendProvider.when(data: (friends) {
      return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Image.asset("./images/oak_background.jpg").image
                    : Image.asset("./images/dark_background.jpg").image,
                fit: BoxFit.cover),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: RawScrollbar(
                  child: SingleChildScrollView(
                primary: true,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 16.0),
                        child: Text("Friends",
                            style: Theme.of(context).textTheme.headlineLarge),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _friendList(context, ref, friends),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 16.0),
                          child: Text("Game Invites",
                              style: Theme.of(context).textTheme.headlineLarge)),
                      SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(children: [GameInvites(_user)])),
                      ),
                    ]),
              ))));
    }, loading: () {
      return Text("");
    }, error: (Object error, StackTrace stackTrace) {
      print("Error occurred with friends provider: $error");
      return Text("");
    });
  }

  Widget _friendList(
    BuildContext context,
    WidgetRef ref,
    List<FriendForView> friends,
  ) {
    if (friends.isEmpty) {
      return Text(
        "No one here yet. Start adding friends!",
        style: Theme.of(context).textTheme.bodyLarge,
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.30,
          child: ListView.separated(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: InputBackground(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        friends[index].displayName,
                      ),
                      IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () async {
                          // showing alert dialog for removing friend
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                "Are you sure you want\nto remove ${friends[index].displayName}\nfrom your friends?",
                                textAlign: TextAlign.center,
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                ElevatedButton(
                                  style: Theme.of(context)
                                          .elevatedButtonTheme
                                          .style
                                          ?.copyWith(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .error),
                                          ) ??
                                      ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .errorContainer,
                                          foregroundColor: Theme.of(context)
                                              .colorScheme
                                              .error),
                                  onPressed: () async {
                                    Navigator.of(context).pop();

                                    // clicked yes, remove friend
                                    await handleRemoveFriend(
                                        ref, friends[index].userId);
                                  },
                                  child: const Text("Yes"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    // clicked no, close the popup message
                                    Navigator.of(context).maybePop();
                                  },
                                  child: const Text("No"),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(Icons.remove_circle_outline),
                        tooltip: "Remove friend",
                      ),
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
  }

  Future<void> handleRemoveFriend(WidgetRef ref, String friendId) async {
    try {
      await ref.read(friendsProvider(_user).notifier).removeFriend(friendId);
    } catch (err) {
      print("Error occurred removing friend: $err");
    }
  }
}
