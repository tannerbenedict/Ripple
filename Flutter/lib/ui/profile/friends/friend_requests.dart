import 'package:ripple/providers/friend_providers/friend_requests_provider.dart';
import 'package:ripple/providers/friends_provider.dart';
import 'package:ripple/ui/components/scrollable_centered.dart';
import 'package:ripple/ui/profile/input_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FriendRequestList extends HookConsumerWidget {
  final String _user;
  const FriendRequestList(this._user);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendRequestProvider = ref.watch(friendRequestsProvider(_user));

    // scroll controller
    final scrollController = useScrollController();
    useEffect(() {
      if (!scrollController.hasClients) return null;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 200), curve: Curves.easeOut));
      return null;
    }, [friendRequestProvider.asData?.value]);

    // adding friends text box
    final textController = useTextEditingController();
    final input = useState("");
    useEffect(() {
      textController.addListener(() {
        input.value = textController.text;
      });
      return null;
    }, [input]);

    return friendRequestProvider.when(
      data: (friendRequests) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Add Friends",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.left),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: InputBackground(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: "Enter friend's email...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onSubmitted: (_) async {
                      var status = await handleSendRequestByEmail(
                          ref, textController, input.value);

                      // user not found
                      if (status == 1) {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                _showDialog(context, "User not Found"));
                        // already friends
                      } else if (status == 2) {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                _showDialog(context, "Already Friends"));
                      } else {
                        // success
                        showDialog(
                            context: context,
                            builder: (context) =>
                                _showDialog(context, "Friend Request Sent"));
                      }
                    },
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Friend Requests",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            _friendRequests(context, ref, friendRequests),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        return _showError(error);
      },
    );
  }

  Widget _friendRequests(BuildContext context, WidgetRef ref,
      List<FriendRequestForView> friendRequests) {
    if (friendRequests.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Text(
          "No pending friend requests",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    } else {
      return Flexible(
        flex: 1,
        child: ListView.separated(
          //controller: scrollController,
          itemCount: friendRequests.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(children: [
                InputBackground(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        friendRequests[index].displayName,
                      ),
                      Row(children: [
                        IconButton(
                          onPressed: () async {
                            await handleAcceptRequest(
                                ref, friendRequests[index].userId);
                          },
                          icon: Icon(Icons.check_circle_outline_rounded),
                          tooltip: "Accept",
                        ),
                        IconButton(
                          onPressed: () async {
                            await handleIgnoreRequest(
                                ref, friendRequests[index].userId);
                          },
                          icon: Icon(Icons.cancel_outlined),
                          tooltip: "Ignore",
                        ),
                      ]),
                    ],
                  ),
                ),
              ]),
            );
          },
          separatorBuilder: (context, index) => SizedBox(),
        ),
      );
    }
  }

  Widget _showDialog(BuildContext context, String title, {String? body}) {
    return AlertDialog(
        title: Text(
          title,
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
        content: body != null
            ? SingleChildScrollView(
                child: Text(body),
              )
            : null);
  }

  Widget _showError(Object error) {
    print("Error occurred when rendering friend request list: $error");
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

  Future<int> handleSendRequestByEmail(WidgetRef ref,
      TextEditingController textController, String friendEmail) async {
    int status = -1;
    try {
      status = await ref
          .read(friendRequestsProvider(_user).notifier)
          .sendRequestByEmail(friendEmail);
    } catch (err) {
      print("Error occurred adding friend: $err");
    }

    if (status == 0) {
      textController.clear();
    }
    return status;
  }

  handleAcceptRequest(WidgetRef ref, String friendId) async {
    try {
      await ref.read(friendsProvider(_user).notifier).addFriend(friendId);
      await ref
          .read(friendRequestsProvider(_user).notifier)
          .ignoreRequest(friendId);
    } catch (err) {
      print("Error occurrred accepting friend request: $err");
    }
  }

  handleIgnoreRequest(WidgetRef ref, String friendId) async {
    try {
      await ref
          .read(friendRequestsProvider(_user).notifier)
          .ignoreRequest(friendId);
    } catch (err) {
      print("Error occurred ignoring friend request: $err");
    }
  }
}
