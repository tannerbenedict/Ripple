import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/profile/friends/friend_requests.dart';
import 'package:ripple/ui/profile/friends/friends_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendsMainPage extends ConsumerWidget {
  static const routeName = "friends";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginInfoProvider).user;
    final databaseUser = ref.watch(
        databaseRepositoryProvider.select((value) => value.getUser(user!.uid)));
    return FutureBuilder(
      future: databaseUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? Image.asset("./images/oak_background.jpg").image
                        : Image.asset("./images/dark_background.jpg").image,
                    fit: BoxFit.cover),
              ),
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                      automaticallyImplyLeading: true,
                      title: Text("Friends"),
                      bottom: const TabBar(tabs: [
                        Tab(text: "My Friends"),
                        Tab(text: "Manage Friends"),
                      ])),
                  body: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TabBarView(children: [
                                  FriendList(user.firebaseId),
                                  FriendRequestList(user.firebaseId),
                                ]),
                              ),
                              Divider(
                                  color: Theme.of(context).colorScheme.primary),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        } else if (snapshot.hasError) {
          return const Text("Something went wrong. Please check the logs");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
