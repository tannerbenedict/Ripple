import 'dart:core';
import 'dart:math';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/database_models/scum_game_model.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/game_providers/scum_notifier.dart';
import 'package:ripple/providers/game_providers/scum_notifier_online.dart';
import 'package:ripple/providers/game_providers/scum_notifier_solo.dart';
import 'package:ripple/ui/chat/chat_room.dart';
import 'package:ripple/ui/components/auto_hiding_app_bar.dart';
import 'package:ripple/ui/games/game_background.dart';
import 'package:ripple/ui/games/scum/discard_pile.dart';
import 'package:ripple/ui/games/scum/opponent_section.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:ripple/models/user.dart';
import 'package:ripple/ui/home/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'player_section.dart';

const botDelay = Duration(seconds: 1);

class Scum extends ConsumerWidget {
  static const onlineRouteName = "scumOnline";
  final String lobbyCode;
  const Scum({super.key, required this.lobbyCode, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));

    ScumNotifierProvider provider = scumOnlineNotifierProvider.call;
    if (lobbyCode == "") {
      provider = scumSoloNotifierProvider.call;
    }

    final game =
        ref.watch(provider(lobbyCode).select((value) => value.whenData((value) {
              return (
                value!.players,
                value.isRoundEnd,
                value.host,
                value.currentPlayer,
                value.gameStatus,
                value.playersNotPlaying,
                value.playersPlaying,
                value.positions,
                value.roundNumber
              );
            })));
    return game.when(
      data: (scumGame) {
        final (
          players,
          isRoundEnd,
          host,
          currentPlayer,
          gameStatus,
          playersNotPlaying,
          playersPlaying,
          positions,
          roundNumber
        ) = scumGame;
        final otherPlayersInOrder =
            players.otherPlayersInOrder(user.firebaseId);

        if ((gameStatus == GameStatus.finished ||
                gameStatus == GameStatus.inLobby) &&
            playersNotPlaying.isEmpty &&
            playersPlaying.isEmpty) {
          if (positions[user.firebaseId] == PlayerPosition.president) {
            _showWinnerBox(context, ref);
          } else {
            _showLoserBox(context, ref);
          }
        }

        if (gameStatus == GameStatus.playing) {
          if (lobbyCode == "" &&
              currentPlayer != null &&
              currentPlayer.firebaseId != user.firebaseId) {
            ref
                .read(scumSoloNotifierProvider(lobbyCode).notifier)
                .takeBotTurn(currentPlayer);
          }
        }

        return PopScope(
            canPop: false,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AutoHidingAppBar(
                title: Column(children: [
                  Text("Scum", style: Theme.of(context).textTheme.titleLarge),
                  if (lobbyCode != "")
                    Text("Code: $lobbyCode",
                        style: Theme.of(context).textTheme.titleSmall),
                ]),
                actions: [
                  _buildHelpButton(context),
                  if (lobbyCode != "")
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ChatRoom(lobbyCode, user.firebaseId);
                              });
                        },
                        icon: const Icon(Icons.message_outlined))
                ],
              ),
              body: GameBackground(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Second Player
                            Flexible(
                              child: OpponentSection(
                                lobbyCode: lobbyCode,
                                opponent: otherPlayersInOrder[1],
                                rotationAngle: 135 * pi / 180,
                              ),
                            ),
                            // Third Player
                            Flexible(
                              child: OpponentSection(
                                lobbyCode: lobbyCode,
                                opponent: otherPlayersInOrder[2],
                                rotationAngle: 180 * pi / 180,
                              ),
                            ),
                            // Fourth Player
                            Flexible(
                              child: OpponentSection(
                                lobbyCode: lobbyCode,
                                opponent: otherPlayersInOrder[3],
                                rotationAngle: 225 * pi / 180,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // First Player
                            Flexible(
                              child: OpponentSection(
                                lobbyCode: lobbyCode,
                                opponent: otherPlayersInOrder[0],
                                rotationAngle: 90 * pi / 180,
                              ),
                            ),
                            Column(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Text("Round: ${-roundNumber + 7} of 6",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!),
                                ),
                                Flexible(
                                  flex: 7,
                                  child: SizedBox(
                                    //height: MediaQuery.sizeOf(context).height,
                                    width: MediaQuery.sizeOf(context).width / 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DiscardPile(
                                        lobbyCode: lobbyCode,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // Fifth Player
                            Flexible(
                              child: OpponentSection(
                                lobbyCode: lobbyCode,
                                opponent: otherPlayersInOrder[4],
                                rotationAngle: 270 * pi / 180,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: PlayerSection(lobbyCode: lobbyCode),
                    ),
                  ],
                ),
              ),
            ));
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }

  void _showWinnerBox(BuildContext context, WidgetRef ref) async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    if (user != null) {
      await ref
          .read(databaseRepositoryProvider)
          .winScum(User.fromFirebaseUser(user));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have earned 1 coin!"),
      ));
    }

    return WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('You Win'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Would you like to play again or return home?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                'Play Again',
              ),
              onPressed: () {
                if (lobbyCode != "") {
                  ref
                      .read(scumOnlineNotifierProvider(lobbyCode).notifier)
                      .playingAgain();

                  final (routeName, params) = ref
                      .read(scumOnlineNotifierProvider(lobbyCode).notifier)
                      .getLobbyRoutingInfo();

                  context.goNamed(routeName, pathParameters: params);
                  context.pop();
                } else {
                  ref
                      .read(scumSoloNotifierProvider(lobbyCode).notifier)
                      .reset();
                  context.pop();
                }
              },
            ),
            ElevatedButton(
              child: Text(
                'Return Home',
              ),
              onPressed: () {
                if (lobbyCode != "") {
                  ref
                      .read(scumOnlineNotifierProvider(lobbyCode).notifier)
                      .notPlayingAgain();
                }
                context.goNamed(HomePage.routeName);
              },
            )
          ],
        ),
      );
    });
  }

  void _showLoserBox(BuildContext context, WidgetRef ref) async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));

    if (user != null) {
      await ref
          .read(databaseRepositoryProvider)
          .loseScum(User.fromFirebaseUser(user));
    }

    return WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('You Lose'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Would you like to play again or return home?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                'Play Again',
              ),
              onPressed: () {
                if (lobbyCode != "") {
                  ref
                      .read(scumOnlineNotifierProvider(lobbyCode).notifier)
                      .playingAgain();

                  final (routeName, params) = ref
                      .read(scumOnlineNotifierProvider(lobbyCode).notifier)
                      .getLobbyRoutingInfo();

                  context.goNamed(routeName, pathParameters: params);
                  context.pop();
                } else {
                  ref
                      .read(scumSoloNotifierProvider(lobbyCode).notifier)
                      .reset();
                  context.pop();
                }
              },
            ),
            ElevatedButton(
              child: Text(
                'Return Home',
              ),
              onPressed: () {
                if (lobbyCode != "") {
                  ref
                      .read(scumOnlineNotifierProvider(lobbyCode).notifier)
                      .notPlayingAgain();
                }
                context.goNamed(HomePage.routeName);
              },
            )
          ],
        ),
      );
    });
  }

  Widget _buildHelpButton(BuildContext context) => IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
      },
      icon: Icon(Icons.question_mark_outlined));

  Widget _buildPopupDialog(BuildContext context) {
    return Dialog(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text("How to Play",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: Theme.of(context).colorScheme.background,
              child: TabBar(tabs: [
                Tab(text: "Game Objective"),
                Tab(text: "Playing the Game"),
                Tab(text: "Symbols"),
                Tab(text: "Controls")
              ]),
            ),
            Expanded(
              child: TabBarView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(
                          "To be the player President at the end of the game. After 6 Rounds the game ends and the player who ends as president wins."),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(
                          "The president starts by leading (face up) any single card or any set of cards of equal rank (for example three fives). Each player in turn must then either pass (i.e. not play any cards), or play face up a card or set of cards, which beats the previous play. \n \nAny higher single card beats a single card. A set of cards can only be beaten by a higher set containing the same number of cards. So for example if the previous player played two sixes you can beat this with two kings, or two sevens, but not with a single king, and not with three sevens (though you could play two of them and hang onto the third).\n\nIt is not necessary to beat the previous play just because you can - passing is always allowed. Also passing does not prevent you from playing the next time your turn comes round.\n\nThe play continues as many times around the table as necessary until someone makes a play which everyone else passes. The Trick ends, and the player who played last (and highest) to the previous \"trick\" starts again by leading any card or set of equal cards. The first player who is out of cards is awarded the highest social rank - this is President. Second, is Vice President, Third and Fourth are commoners. The second to last is Vice Scum. The last player to be left with any cards is known as the Scum.\n\nTurn Order goes as follows:\nPresident - Vice President - Person 1 - Person 2 - Vice Scum - Scum"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                        child: RichText(
                            text: TextSpan(children: [
                      TextSpan(
                          text:
                              "The positions are defined with icons follows: \n\n President : "),
                      WidgetSpan(child: Icon(MdiIcons.chessKing)),
                      TextSpan(text: "\n\n Vice President : "),
                      WidgetSpan(child: Icon(MdiIcons.chessQueen)),
                      TextSpan(text: "\n\n Commoner : "),
                      WidgetSpan(child: Icon(MdiIcons.pitchfork)),
                      TextSpan(text: "\n\nVice Scum : "),
                      WidgetSpan(child: Icon(MdiIcons.skull)),
                      TextSpan(text: "\n\n Scum : "),
                      WidgetSpan(child: Icon(MdiIcons.skullCrossbones)),
                    ]))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                      child: SingleChildScrollView(
                    child: Text(
                        "To play a card either drag a single card to the discard pile.\nTo play mulitple cards click them and then drag one to the discard pile.\nTo Pass simply click the pass button."),
                  )),
                ),
              ]),
            )
          ],
        ),
      ),
    ));
  }
}
