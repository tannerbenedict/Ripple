import 'dart:core';
import 'package:ripple/models/database_models/cheat_game_model.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/game_providers/cheat_notifier.dart';
import 'package:ripple/providers/game_providers/cheat_notifier_online.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/components/auto_hiding_app_bar.dart';
import 'package:ripple/ui/games/cheat/top_section.dart';
import 'package:ripple/ui/chat/chat_room.dart';
import 'package:ripple/ui/games/game_background.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:ripple/ui/home/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_section.dart';
import 'center_section.dart';

class Cheat extends ConsumerStatefulWidget {
  final String lobbyCode;
  final CheatNotifierProvider cheatProvider;
  final GameMode gameMode;

  const Cheat({
    super.key,
    required this.lobbyCode,
    required this.cheatProvider,
    required this.gameMode,
  });

  @override
  ConsumerState<Cheat> createState() => _CheatState();
}

class _CheatState extends ConsumerState<Cheat> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(loginInfoProvider
        .select((value) => User.getRealOrDefaultUser(value.user)));
    final game = ref.watch(widget
        .cheatProvider(widget.lobbyCode)
        .select((value) => value.whenData((value) {
              final playerScore = value?.playerScores[user.firebaseId];

              final otherScores = value?.playerScores.entries
                  .where((element) => element.key != user.firebaseId)
                  .map((e) => e.value);

              return (
                playerScore,
                otherScores,
                value?.gameStatus,
                value?.playersNotPlaying,
                value?.playersPlaying
              );
            })));

    return game.when(
      data: (data) {
        final (
          playerScore,
          otherScores,
          gameStatus,
          playersNotPlaying,
          playersPlaying
        ) = data;
        if (playerScore == null ||
            otherScores == null ||
            playersNotPlaying == null ||
            playersPlaying == null) {
          return Scaffold(
            appBar: AppBar(title: const Text("Cheat")),
            body:
                const Center(child: Text("We're sorry, something went wrong")),
          );
        }

        if ((gameStatus == GameStatus.finished ||
                gameStatus == GameStatus.inLobby) &&
            playersNotPlaying.isEmpty &&
            playersPlaying.isEmpty) {
          if (playerScore >= CheatGameModel.numberRoundsToWin) {
            _showWinnerBox(context, ref);
          } else if (otherScores
              .any((element) => element >= CheatGameModel.numberRoundsToWin)) {
            _showLoserBox(context, ref);
          }
        }

        return PopScope(
            canPop: false,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AutoHidingAppBar(
                title: Column(children: [
                  Text("Cheat", style: Theme.of(context).textTheme.titleLarge),
                  if (widget.gameMode == GameMode.online)
                    Text("Code: ${widget.lobbyCode}",
                        style: Theme.of(context).textTheme.titleSmall),
                ]),
                actions: [
                  if (widget.gameMode == GameMode.online)
                    IconButton(
                      icon: const Icon(Icons.message_outlined),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) =>
                            ChatRoom(widget.lobbyCode, user.firebaseId),
                      ),
                    ),
                  _buildHelpButton(context),
                ],
              ),
              body: GameBackground(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TopSection(
                          lobbyCode: widget.lobbyCode,
                          provider: widget.cheatProvider),
                    ),
                    Flexible(
                      child: CenterSection(
                          lobbyCode: widget.lobbyCode,
                          provider: widget.cheatProvider),
                    ),
                    Flexible(
                        child: BottomSection(
                      lobbyCode: widget.lobbyCode,
                      provider: widget.cheatProvider,
                    )),
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
          .winCheat(User.fromFirebaseUser(user));
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
                ref
                    .read(widget.cheatProvider(widget.lobbyCode).notifier)
                    .playingAgain();

                final (routeName, params) = ref
                    .read(widget.cheatProvider(widget.lobbyCode).notifier)
                    .getLobbyRoutingInfo();

                context.goNamed(routeName, pathParameters: params);
                context.pop();
              },
            ),
            ElevatedButton(
              child: Text(
                'Return Home',
              ),
              onPressed: () {
                ref
                    .read(widget.cheatProvider(widget.lobbyCode).notifier)
                    .notPlayingAgain();
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
          .loseCheat(User.fromFirebaseUser(user));
    }

    return WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        barrierDismissible: false,
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
                ref
                    .read(widget.cheatProvider(widget.lobbyCode).notifier)
                    .playingAgain();

                final (routeName, params) = ref
                    .read(widget.cheatProvider(widget.lobbyCode).notifier)
                    .getLobbyRoutingInfo();

                context.goNamed(routeName, pathParameters: params);
                context.pop();
              },
            ),
            ElevatedButton(
              child: Text(
                'Return Home',
              ),
              onPressed: () {
                ref
                    .read(widget.cheatProvider(widget.lobbyCode).notifier)
                    .notPlayingAgain();
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
        automaticallyImplyLeading: true,
        centerTitle: true,
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
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(tabs: [
                Tab(text: "Game Objective"),
                Tab(text: "Playing the Game"),
                Tab(text: "Winning"),
                Tab(text: "Controls"),
              ]),
            ),
            Expanded(
              child: TabBarView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(
                          "To be the first player to get rid of all of their cards. This is done by either having the correct cards or being able to bluff that one does. The first player to win 5 rounds wins the game."),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(
                          "A random player is chosen to go first. They lead the game and must \"play\" Any number of aces. \n\nPlay continues clockwise and each following player must either play any number of cards of the next card ie 2,3,4 or bluff and say that they are playing those cards. \n\nCalling Cheat - On their turn, If one suspects that a player has lied about the cards they have played, they can call \"Cheat\". \n\nIf the player did not lie, the player who called cheat takes all the cards in the discard pile.\n\nIf the player did lie, that player must take all the cards in the discard pile.\n\nPlay continues until someone runs out of cards."),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(
                          "To Win, one must be the first person to play all of their cards."),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(
                          "To play a single card drage the card to the discard pile.\n\nTo play multiple cards click on the cards you want to play and then drag one to the discard pile.\n\nTo call Cheat! simply click/tap on the cheat button."),
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    ));
  }
}
