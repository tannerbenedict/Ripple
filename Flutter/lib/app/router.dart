import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/providers/game_providers/cheat_notifier_online.dart';
import 'package:ripple/providers/game_providers/cheat_notifier_solo.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/game_providers/gin_rummy_notifier_online.dart';
import 'package:ripple/providers/game_providers/gin_rummy_notifier_solo.dart';
import 'package:ripple/ui/games/cheat/cheat.dart';
import 'package:ripple/ui/games/gin_rummy/gin_rummy.dart';
import 'package:ripple/ui/games/hearts/hearts.dart';
import 'package:ripple/ui/games/scum/scum.dart';
import 'package:ripple/ui/games/solitaire/solitaire.dart';
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
    switch (this) {
      case GameType.solitaire:
        throw ArgumentError("Solitaire is not a multiplayer game");
      default:
        return "$baseRoute/:lobbyCode";
    }
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
        name: GameType.cheat.soloRouteName,
        path: GameType.cheat.soloPath,
        builder: (context, state) => Cheat(
          lobbyCode: generateLobbyCode(),
          cheatProvider: cheatSoloNotifierProvider.call,
          gameMode: GameMode.solo,
        ),
      ),
      GoRoute(
        name: GameType.scum.soloRouteName,
        path: GameType.scum.soloPath,
        builder: (context, state) => const Scum(lobbyCode: ""),
      ),
      GoRoute(
        name: GameType.hearts.soloRouteName,
        path: GameType.hearts.soloPath,
        builder: (context, state) => const Hearts(lobbyCode: ""),
      ),
      GoRoute(
        name: GameType.ginRummy.soloRouteName,
        path: GameType.ginRummy.soloPath,
        builder: (context, state) => GinRummy(
          lobbyCode: generateLobbyCode(),
          provider: ginRummySoloNotifierProvider.call,
          gameMode: GameMode.solo,
        ),
      ),
      GoRoute(
        name: GameType.ginRummy.onlineRouteName,
        path: GameType.ginRummy.onlinePath,
        builder: (context, state) => GinRummy(
          lobbyCode: state.pathParameters["lobbyCode"]!,
          provider: ginRummyNotifierOnlineProvider.call,
          gameMode: GameMode.online,
        ),
      ),
      GoRoute(
        name: GameType.scum.onlineRouteName,
        path: GameType.scum.onlinePath,
        builder: (context, state) => Scum(
          lobbyCode: state.pathParameters["lobbyCode"]!,
        ),
      ),
      GoRoute(
        name: GameType.hearts.onlineRouteName,
        path: GameType.hearts.onlinePath,
        builder: (context, state) =>
            Hearts(lobbyCode: state.pathParameters["lobbyCode"]!),
      ),
      GoRoute(
        name: GameType.cheat.onlineRouteName,
        path: GameType.cheat.onlinePath,
        builder: (context, state) => Cheat(
          lobbyCode: state.pathParameters["lobbyCode"]!,
          cheatProvider: cheatOnlineNotifierProvider.call,
          gameMode: GameMode.online,
        ),
      ),
      //GoRoute(
      // name: GameType.hearts.soloRouteName,
      //  path: GameType.hearts.soloPath,
      // builder: (context, state) => const HeartsSolo(),
      //),
      // GoRoute(
      //   name: GameType.scum.soloRouteName,
      //   path: GameType.scum.soloPath,
      //   builder: (context, state) => const ScumSolo(),
      // ),
      GoRoute(
        name: GameType.solitaire.soloRouteName,
        path: GameType.solitaire.soloPath,
        builder: (context, state) => const Solitaire(),
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
