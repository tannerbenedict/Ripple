import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/providers/game_providers/two_player_notifier.dart';
import 'package:ripple/ui/chat/chat_room.dart';
import 'package:ripple/ui/components/auto_hiding_app_bar.dart';
import 'package:ripple/ui/games/game_background.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:ripple/providers/login_info_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ripple/ui/games/two_player/bottom_section.dart';
import 'package:ripple/ui/games/two_player/center_section.dart';
import 'package:ripple/ui/games/two_player/game_over.dart';
import 'package:ripple/ui/games/two_player/top_section.dart';

const padding = 8.0;
final animationDuration = 500.ms;
const animationCurve = Curves.easeIn;

class TwoPlayer extends HookConsumerWidget {
  static const soloRouteName = "twoPlayerRippleSolo";
  static const onlineRouteName = "twoPlayerRippleOnline";

  const TwoPlayer({
    super.key,
    required this.lobbyCode,
    required this.provider,
    required this.gameMode,
  });

  final GameMode gameMode;
  final String lobbyCode;
  final TwoPlayerNotifierProvider provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = User.getRealOrDefaultUser(
        ref.read(loginInfoProvider.select((value) => value.user)));

    final gameState = ref
        .watch(provider(lobbyCode).select((value) => value.whenData((value) => (
              value!.gameStatus,
              value.playerScores,
              value.playersNotPlaying,
              value.playersPlaying,
            ))));
    return PopScope(
        canPop: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AutoHidingAppBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Ripple"),
                gameMode == GameMode.online
                    ? Text(
                        "Lobby Code: $lobbyCode",
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            actions: [
              if (gameMode == GameMode.online)
                IconButton(
                  icon: Icon(Icons.message_outlined),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          ChatRoom(lobbyCode, user.firebaseId),
                    );
                  },
                ),
              _buildHelpButton(context),
            ],
          ),
          body: GameBackground(
            child: gameState.when(
              data: (data) {
                final (
                  gameStatus,
                  playerScores,
                  playersNotPlaying,
                  playersPlaying,
                ) = data;
                if ((gameStatus == GameStatus.finished ||
                        gameStatus == GameStatus.inLobby) &&
                    playersNotPlaying.isEmpty &&
                    playersPlaying.isEmpty) {
                final opp = playersPlaying
                    .where((player) => player.firebaseId != user.firebaseId);
                final playerScore = playerScores[user.firebaseId]!;
                final oppScore = playerScores[opp.first.firebaseId]!;
                  if ((playerScore <= -100 || oppScore >= 100) && playerScore < oppScore) {
                    _showWinnerBox(context, ref);
                  } else {
                    _showLoserBox(context, ref);
                  }
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TopSection(lobbyCode, provider),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CenterSection(
                          lobbyCode: lobbyCode, provider: provider),
                    ),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BottomSection(lobbyCode, provider),
                      ),
                    ),
                  ],
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  const Text("Something went wrong. Please check the logs"),
            ),
          ),
        ));
  }

  void _showWinnerBox(BuildContext context, WidgetRef ref) async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    if (user != null) {
      await ref
          .read(databaseRepositoryProvider)
          .winTwoPlayer(User.fromFirebaseUser(user));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have earned 1 coin!"),
      ));
    }

    return WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) =>
              GameOver(lobbyCode, WinnerStatus.winner, provider));
    });
  }

  void _showLoserBox(BuildContext context, WidgetRef ref) async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    if (user != null) {
      await ref
          .read(databaseRepositoryProvider)
          .loseTwoPlayer(User.fromFirebaseUser(user));
    }

    return WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (context) => GameOver(lobbyCode, WinnerStatus.loser, provider),
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
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: Theme.of(context).colorScheme.background,
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(tabs: [
                Tab(text: "Game Objective"),
                Tab(text: "Playing the Game"),
                Tab(text: "Scoring"),
              ]),
            ),
            Expanded(
              child: TabBarView(children: [
                Scrollbar(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Each player uses their hand to form combinations of three or more cards, to get more than the 100 points required to win the game before their opponent does so when played over several hands"),
                    ),
                  ),
                ),
                Scrollbar(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "The player who did not deal the cards starts the game, with the option to pick up the upturned card next to the stock deck, meaning that one of their cards must be discarded. If the said card is of no interest, the player passes without discarding. The opponent may, in turn, take that card and discard another, and if they are not interested, they pass without discarding. Then the first player can now take the top card off the stock deck, discarding another. The game continues, with each player in turn being able to take the top card off the stock deck or the discard pile, then discarding a card, but which may not be the same card that they just picked up from the discard pile. \n \nThe game consists of players grouping the 10 cards in their hand to make minimum combinations of three cards of the same rank or runs of the same suit. The ace can be combined with the deuce but not with the king (K). A player can fold when their hand contains only unmatched cards worth a total value of no more than 10 points, making a Knock. As soon as a player discards their last card, they show all of their cards, announcing the number of points that are left without combining. It is not compulsory to Knock, a player can prolong the game in order to improve their hand. The best hand is to make Gin, consisting of placing down the ten cards combined. \n \nIn either case, when a player folds, exposing all of their cards, the opponent does the same, having the opportunity to get rid of those cards that were left unmatched and being able to combine cards with those exposed by the player who Knocked or announced Gin. \n \nWhen a player announces Gin they win the partial game, whereas if a player Knocks, either that player or the opposing player can win it. The player wins if the value of their unmatched cards is less than the value of the opponent’s unmatched cards and the opponent wins if the value of their unmatched cards is equal to or less than that of the one that Knocked. \n \nThe cards of the opponent to the one who announced Gin or Knocked are valued after having discarded the cards that they have not combined and that link with combinations of the hand laid down by the one declared Gin or Knock."),
                    ),
                  ),
                ),
                Scrollbar(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "A game ends when sufficient partial games have been played to allow one player to get 100 or more points. \n \nThe player who makes Gin, scores 25 points plus the value of the opponent’s unmatched cards. If the player who Knocks wins the game, they score the difference in the value of their unmatched cards with those of their opponent, while if the opponent wins, they score 25 points plus the difference in the value of the unmatched cards between both players. If there is no difference, the 25 point bonus remains."),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    ));
  }
}
