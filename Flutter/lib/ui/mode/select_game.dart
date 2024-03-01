import 'package:carousel_slider/carousel_slider.dart';
import 'package:ripple/app/router.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/lobby_provider.dart';
import 'package:ripple/ui/games/game_background.dart';
import 'package:ripple/ui/lobby/join_game.dart';
import 'package:ripple/ui/lobby/lobby.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

extension GameTypeImage on GameType {
  String get image {
    switch (this) {
      case GameType.twoPlayer:
        return 'images/tanner.png';
    }
  }
}

extension GameTypeOnMode on Iterable<GameType> {
  List<GameType> get soloGames => GameType.values;
  List<GameType> get onlineGames => GameType.values;
}

enum Action {
  create,
  join;
}

class SelectGame extends ConsumerStatefulWidget {
  static const soloRouteName = "selectSoloGame";
  static const onlineRouteName = "selectOnlineGame";
  final GameMode mode;
  final Action action;

  SelectGame({super.key, required this.mode, required this.action});

  @override
  ConsumerState<SelectGame> createState() => _SelectGameState();
}

class _SelectGameState extends ConsumerState<SelectGame> {
  late List<GameType> _games;
  var _loading = false;
  var _currentPage = 0;
  final _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    _games = widget.mode == GameMode.solo
        ? GameType.values.soloGames
        : GameType.values.onlineGames;
  }

  Future<void> _handleNavigation(BuildContext context) async {
    var type = _games[_currentPage];

    if (widget.mode == GameMode.online) {
      if (widget.action == Action.create) {
        final code = generateLobbyCode();
        final notifier = ref.read(type.provider(code).notifier);
        await notifier.createNewGame();
        await ref
            .read(lobbyNotifierProvider(code).notifier)
            .createNewLobby(type);
        if (context.mounted) {
          context.goNamed(LobbyPage.routeName,
              pathParameters: {'lobbyCode': code, 'gameType': type.toString()});
        }
      } else {
        context.goNamed(JoinGamePage.routeName);
      }
    } else {
      context.goNamed(type.soloRouteName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Select Game')),
        body: GameBackground(
          makeFullScreen: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CarouselSlider.builder(
                itemCount: _games.length,
                itemBuilder: (context, index, pageViewIndex) {
                  return _CarouselCard(() async {
                    if (_currentPage == pageViewIndex && context.mounted) {
                      _handleNavigation(context);
                    }

                    await _controller.animateToPage(pageViewIndex,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  }, _games[index].image, _games[index].screenName);
                },
                options: CarouselOptions(
                  autoPlay: false,
                  onPageChanged: (index, _) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  height: MediaQuery.of(context).size.height * 0.5,
                  viewportFraction: 0.3,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                ),
                carouselController: _controller,
              ),
              AnimatedSmoothIndicator(
                  onDotClicked: (int index) => _controller.animateToPage(index),
                  activeIndex: _currentPage,
                  count: _games.length,
                  effect: SlideEffect(
                      activeDotColor: Theme.of(context).colorScheme.primary)),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => _handleNavigation(context),
                      child: Text("Play Game")),
            ],
          ),
        ));
  }
}

class _CarouselCard extends StatelessWidget {
  final void Function() onTapCallback;
  final String imagePath;
  final String label;

  const _CarouselCard(this.onTapCallback, this.imagePath, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTapCallback,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image.asset(imagePath),
            ),
          ),
        ),
        Text(label, style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}
