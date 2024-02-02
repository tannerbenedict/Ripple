import 'package:ripple/globals.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/login_info_provider.dart';

class Statistics extends ConsumerWidget {
  static const routeName = "statistics";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(loginInfoProvider).user;
    final databaseUser = ref.watch(
        databaseRepositoryProvider.select((value) => value.getUser(user!.uid)));
    return FutureBuilder(
      future: databaseUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          coins = user.coins;
          gp = user.gamesPlayed;
          gw = user.gamesWon;
          twogp = user.solitaireGamesPlayed;
          twogw = user.solitaireGamesWon;
          threegp = user.ginRummyGamesPlayed;
          threegw = user.ginRummyGamesWon;
          fourgp = user.heartsGamesPlayed;
          fourgw = user.heartsGamesWon;
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
                length: 4,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                      automaticallyImplyLeading: true,
                      title: Text('Statistics'),
                      bottom: TabBar(
                        tabs: [
                          Tab(text: "General"),
                          Tab(text: "Two Player"),
                          Tab(text: "Three Player"),
                          Tab(text: "Four Player"),
                        ],
                      )),
                  body: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: TabBarView(children: [
                                  SingleChildScrollView(
                                    child: Column(children: [
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Games Played",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          gp.toString(),
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Games Won",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          gw.toString(),
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Current Coins",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          coins.toString(),
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                    ]),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(children: [
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Games Played",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          twogp.toString(),
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Games Won",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          twogw.toString(),
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Win Percentage",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          twogp == 0 ? "N/A" : "${(twogw * 100) ~/ twogp}%",
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                    ]),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(children: [
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Games Played",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          threegp.toString(),
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Games Won",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          threegw.toString(),
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Win Percentage",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          threegp == 0 ? "N/A" : "${(threegw * 100) ~/ threegp}%",
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                    ]),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(children: [
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Games Played",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          fourgp.toString(),
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Games Won",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          fourgw.toString(),
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                      Card(
                                          child: ListTile(
                                        title: Text(
                                          "Win Percentage",
                                          style: theme.textTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Text(
                                          fourgp == 0 ? "N/A" : "${(fourgw * 100) ~/ fourgp}%",
                                          style: theme.textTheme.headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                    ]),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                        Divider(color: Theme.of(context).colorScheme.primary),
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
