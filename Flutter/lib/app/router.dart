import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/game_providers/two_player_notifier_online.dart';
import 'package:ripple/providers/game_providers/two_player_notifier_solo.dart';
import 'package:ripple/ui/games/two_player/two_player_ripple.dart';
import 'package:ripple/ui/home/home_page.dart';

import 'package:ripple/ui/lobby/join_game.dart';
import 'package:ripple/ui/lobby/lobby.dart';
import 'package:ripple/ui/mode/select_game.dart';
import 'package:ripple/ui/privacy_policy/privacy_policy.dart';
import 'package:ripple/ui/profile/friends/friends_main_page.dart';
import 'package:ripple/ui/profile/login_form.dart';
import 'package:ripple/ui/profile/profile_main_page.dart';
import 'package:ripple/ui/profile/signup_form.dart';
import 'package:ripple/ui/shop/shop_page.dart';
import 'package:ripple/ui/statistics/statistics.dart';
import 'package:go_router/go_router.dart';

class InvalidParameterValueError extends Error {}

extension GameTypeRoutes on GameType {
  String get onlineRouteName => "online/$name";

  String get onlinePath {
    final baseRoute = onlineRouteName;
    return "$baseRoute/:lobbyCode";
  }

  String get soloRouteName => "solo/$name";
  String get soloPath => soloRouteName;
}

final router = GoRouter(routes: [
  GoRoute(
    path: "/",
    name: HomePage.routeName,
    builder: (context, state) => const HomePage(),
    routes: [
      GoRoute(
          name: ProfileMainPage.routeName,
          path: "profile",
          builder: (context, state) => ProfileMainPage(),
          routes: [
            GoRoute(
              name: LoginForm.routeName,
              path: "login",
              builder: (context, state) => LoginForm(
                () => context.goNamed(ProfileMainPage.routeName),
              ),
            ),
            GoRoute(
              name: SignupForm.routeName,
              path: "signup",
              builder: (context, state) => SignupForm(
                () => context.goNamed(ProfileMainPage.routeName),
              ),
            )
          ]),
      GoRoute(
        name: GameType.twoPlayer.soloRouteName,
        path: GameType.twoPlayer.soloPath,
        builder: (context, state) => TwoPlayer(
          lobbyCode: generateLobbyCode(),
          provider: twoPlayerSoloNotifierProvider.call,
          gameMode: GameMode.solo,
        ),
      ),
      GoRoute(
        name: GameType.twoPlayer.onlineRouteName,
        path: GameType.twoPlayer.onlinePath,
        builder: (context, state) => TwoPlayer(
          lobbyCode: state.pathParameters["lobbyCode"]!,
          provider: twoPlayerNotifierOnlineProvider.call,
          gameMode: GameMode.online,
        ),
      ),
      GoRoute(
        name: SelectGame.soloRouteName,
        path: SelectGame.soloRouteName,
        builder: (context, state) => SelectGame(
          mode: GameMode.solo,
          action: Action.create,
        ),
      ),
      GoRoute(
        path: "${SelectGame.onlineRouteName}/:action",
        name: SelectGame.onlineRouteName,
        builder: (context, state) => SelectGame(
            mode: GameMode.online,
            action: Action.values.byName(state.pathParameters["action"] ?? "")),
      ),
      GoRoute(
          path: "lobby/:gameType/:lobbyCode",
          name: LobbyPage.routeName,
          builder: (context, state) => LobbyPage(
              lobbyCode: state.pathParameters["lobbyCode"]!,
              notifierProvider: GameType.values
                  .byName(state.pathParameters["gameType"] ?? "")
                  .provider)),
      GoRoute(
          path: "joinGame",
          name: JoinGamePage.routeName,
          builder: (context, state) => JoinGamePage()),
      GoRoute(
        name: Statistics.routeName,
        path: "statistics",
        builder: (context, state) => Statistics(),
      ),
      GoRoute(
          name: ShopPage.routeName,
          path: ShopPage.routeName,
          builder: (context, state) => ShopPage()),
      GoRoute(
          name: PrivacyPolicy.routeName,
          path: PrivacyPolicy.routeName,
          builder: (context, state) => PrivacyPolicy()),
      GoRoute(
          name: FriendsMainPage.routeName,
          path: FriendsMainPage.routeName,
          builder: (context, state) => FriendsMainPage()),
    ],
  )
]);
