import 'dart:core';
import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/game_providers/hearts_notifier.dart';
import 'package:ripple/providers/game_providers/hearts_notifier_online.dart';
import 'package:ripple/providers/game_providers/hearts_notifier_solo.dart';
import 'package:ripple/ui/components/auto_hiding_app_bar.dart';
import 'package:ripple/ui/games/hearts/center_section.dart';
import 'package:ripple/ui/games/hearts/hearts_bot_logic.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:ripple/ui/home/home_page.dart';
import 'package:ripple/ui/chat/chat_room.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ripple/providers/login_info_provider.dart';

import '../fanned_hand.dart';
import 'top_section.dart';
import 'bottom_section.dart';

const botDelay = Duration(seconds: 1);

class Hearts extends ConsumerStatefulWidget {
  final String lobbyCode;
  const Hearts({super.key, required this.lobbyCode, this.child});
  final Widget? child;

  @override
  ConsumerState<Hearts> createState() => _HeartsState();
}

class _HeartsState extends ConsumerState<Hearts> {
  Card? _invalidCardTouched;
  static final _twoOfClubs = Card(faceValue: 2, suit: Suit.clubs);

  @override
  Widget build(BuildContext context) {
    HeartsNotifierProvider provider = heartsOnlineNotifierProvider.call;
    if (widget.lobbyCode == "") {
      provider = heartsSoloNotifierProvider.call;
    }
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));
    final neededInfo = ref.watch(
        provider(widget.lobbyCode).select((value) => value.whenData((value) => (
              value!.playerScores,
              value.turnOrder,
              value.currentPlayer,
              value.gameStatus,
              value.playersNotPlaying,
              value.playersPlaying,
              value.heartsBroken
            ))));
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width -
        (MediaQuery.of(context).padding.right +
            MediaQuery.of(context).padding.left);
    return neededInfo.when(
      data: (data) {
        final (
          playerScores,
          turnOrder,
          currentPlayer,
          gameStatus,
          playersNotPlaying,
          playersPlaying,
          heartsBroken,
        ) = data;
        final playerIndex = turnOrder
            .indexWhere((element) => element.firebaseId == user.firebaseId);
        final leftPlayer = turnOrder[(playerIndex + 1) % 4];
        final topPlayer = turnOrder[(playerIndex + 2) % 4];
        final rightPlayer = turnOrder[(playerIndex + 3) % 4];
        final sortedScores = (playerScores.entries.toList()
          ..sort((first, second) => first.value.compareTo(second.value)));

        final canDiscard =
            currentPlayer == user && gameStatus == GameStatus.playing;

        Future<void> handleDiscard(Card card) async {
          final (playerHand, cardLed, heartsBroken) =
              ref.read(provider(widget.lobbyCode).select((value) => (
                    value.asData!.value!.playerHands[user.firebaseId]!,
                    value.asData!.value!.cardLed,
                    value.asData!.value!.heartsBroken
                  )));
          var possibilites = <Card>[];
          if (playerHand.any((card) => card.sameCard(_twoOfClubs))) {
            possibilites.add(
                playerHand.where((card) => card.sameCard(_twoOfClubs)).first);
          } else {
            possibilites = HeartsLogic.getPossibleCardsToPlay(
                playerHand, cardLed, heartsBroken);
          }
          if (possibilites.contains(card)) {
            setState(() {
              _invalidCardTouched = null;
            });
            await ref
                .read(provider(widget.lobbyCode).notifier)
                .discardCard(card, user);
          } else {
            setState(() {
              _invalidCardTouched = card;
            });
          }
        }

        if ((gameStatus == GameStatus.finished ||
                gameStatus == GameStatus.inLobby) &&
            playersNotPlaying.isEmpty &&
            playersPlaying.isEmpty) {
          if (sortedScores.last.value >= 100) {
            if (sortedScores.first.key == user.firebaseId) {
              _showWinnerBox(context, ref);
            } else {
              _showLoserBox(context, ref);
            }
          }
        }

        if (gameStatus == GameStatus.playing) {
          if (widget.lobbyCode == "" &&
              currentPlayer != null &&
              currentPlayer.firebaseId != user.firebaseId) {
            ref
                .read(heartsSoloNotifierProvider(widget.lobbyCode).notifier)
                .takeBotTurn(currentPlayer);
          }
        }

        return PopScope(
            canPop: false,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AutoHidingAppBar(
                title: Column(children: [
                  Text("Hearts", style: Theme.of(context).textTheme.titleLarge),
                  if (widget.lobbyCode != "")
                    Text("Code: ${widget.lobbyCode}",
                        style: Theme.of(context).textTheme.titleSmall),
                ]),
                alwaysVisible: false,
                actions: [
                  _buildHelpButton(context),
                  if (widget.lobbyCode != "")
                    IconButton(
                      icon: Icon(Icons.message_outlined),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              ChatRoom(widget.lobbyCode, user.firebaseId),
                        );
                      },
                    ),
                ],
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? Image.asset("./images/oak_background.jpg").image
                          : Image.asset("./images/dark_background.jpg").image,
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: SizedBox(
                      height: height,
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: TopSection(
                            isPlayerTurn: currentPlayer == topPlayer,
                            lobbyCode: widget.lobbyCode,
                            player: topPlayer,
                          )),
                          Flexible(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                    child: RotatedBox(
                                  quarterTurns: 1,
                                  child: FannedHand(
                                    gameNotifierProvider: provider,
                                    lobbyCode: widget.lobbyCode,
                                    player: leftPlayer,
                                  ),
                                )),
                                Flexible(
                                  flex: 4,
                                  child: CenterSection(
                                      lobbyCode: widget.lobbyCode,
                                      leftPlayer: leftPlayer,
                                      bottomPlayer: user,
                                      rightPlayer: rightPlayer,
                                      topPlayer: topPlayer,
                                      broken: heartsBroken,
                                      handleDiscard:
                                          canDiscard ? handleDiscard : null),
                                ),
                                Flexible(
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: FannedHand(
                                      gameNotifierProvider: provider,
                                      lobbyCode: widget.lobbyCode,
                                      player: rightPlayer,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                              child: BottomSection(
                            lobbyCode: widget.lobbyCode,
                            handleOnCardTapped:
                                canDiscard ? handleDiscard : null,
                            invalidCardTouched: _invalidCardTouched,
                          ))
                        ],
                      ),
                    ),
                  ),
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
          .winHearts(User.fromFirebaseUser(user));
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
                if (widget.lobbyCode != "") {
                  ref
                      .read(heartsOnlineNotifierProvider(widget.lobbyCode)
                          .notifier)
                      .playingAgain();

                  final (routeName, params) = ref
                      .read(heartsOnlineNotifierProvider(widget.lobbyCode)
                          .notifier)
                      .getLobbyRoutingInfo();

                  context.goNamed(routeName, pathParameters: params);
                  context.pop();
                } else {
                  ref
                      .read(
                          heartsSoloNotifierProvider(widget.lobbyCode).notifier)
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
                if (widget.lobbyCode != "") {
                  ref
                      .read(heartsOnlineNotifierProvider(widget.lobbyCode)
                          .notifier)
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
          .loseHearts(User.fromFirebaseUser(user));
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
                if (widget.lobbyCode != "") {
                  ref
                      .read(heartsOnlineNotifierProvider(widget.lobbyCode)
                          .notifier)
                      .playingAgain();

                  final (routeName, params) = ref
                      .read(heartsOnlineNotifierProvider(widget.lobbyCode)
                          .notifier)
                      .getLobbyRoutingInfo();

                  context.goNamed(routeName, pathParameters: params);
                  context.pop();
                } else {
                  ref
                      .read(
                          heartsSoloNotifierProvider(widget.lobbyCode).notifier)
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
                if (widget.lobbyCode != "") {
                  ref
                      .read(heartsOnlineNotifierProvider(widget.lobbyCode)
                          .notifier)
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
        shape: RoundedRectangleBorder(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text("How to Play",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DefaultTabController(
                        length: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              color: Theme.of(context).colorScheme.background,
                              child: TabBar(tabs: [
                                Tab(text: "Game Objective"),
                                Tab(text: "Playing the Game"),
                                Tab(text: "Scoring"),
                                Tab(text: "Controls"),
                              ]),
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Scrollbar(
                                      child: Text(
                                          "To be the player with the lowest score at the end of the game. When one player hits a score of 100 or higher, the game ends; and the player with the lowest score wins."),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      child: Text(
                                          "The player holding the 2 of clubs after the pass makes the opening lead. \n \nEach player must follow suit if possible. If a player is void of the suit led, a card of any other suit may be discarded. However, if a player has no clubs when the first trick is led, a heart or the queen of spades cannot be discarded. The highest card of the suit led wins a trick and the winner of that trick leads next. There is no trump suit. \n \n Hearts may not be led until a heart has been discarded. The queen does not have to be discarded at the first opportunity. \n \nThe queen can be led at any time."),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      child: Text(
                                          "At the end of each hand, players count the number of hearts they have taken as well as the queen of spades, if applicable.  \n \nEach heart - 1 point \n \nThe Q - 13 points \n \nThe aggregate total of all scores for each hand must be a multiple of 26. \n \nThe game is played to 100 points. \n \nWhen a player takes all 13 hearts and the queen of spades in one hand, instead of losing 26 points, that player scores zero and each of his opponents score an additional 26 points."),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      child: Text(
                                          "To play a card either drag the card to the individual discard pile, or simply just click/tap the card you want to discard."),
                                    ),
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
