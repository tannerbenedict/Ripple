import 'package:ripple/providers/game_invite_provider.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/home/friends_button.dart';
import 'package:ripple/ui/home/profile_button.dart';
import 'package:ripple/ui/lobby/join_game.dart';
import 'package:ripple/ui/mode/select_game.dart';
import 'package:ripple/ui/privacy_policy/privacy_policy.dart';
import 'package:ripple/ui/profile/friends/friends_main_page.dart';
import 'package:ripple/ui/profile/profile_main_page.dart';
import 'package:ripple/ui/shop/shop_page.dart';
import 'package:ripple/ui/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomePage extends ConsumerWidget {
  static const routeName = "homePage";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? Image.asset("./images/oak_background.jpg").image
                      : Image.asset("./images/dark_background.jpg").image,
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (await _verifyLoggedIn(context, ref) &&
                              context.mounted) {
                            context.goNamed(Statistics.routeName);
                          }
                        },
                        icon: Icon(
                          Icons.bar_chart_rounded,
                        ),
                        iconSize: MediaQuery.of(context)
                            .textScaler
                            .scale(iconScalingFactor),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (await _verifyLoggedIn(context, ref) &&
                              context.mounted) {
                            context.goNamed(ShopPage.routeName);
                          }
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                        ),
                        iconSize: MediaQuery.of(context)
                            .textScaler
                            .scale(iconScalingFactor),
                      ),
                      if (kIsWeb)
                        IconButton(
                          onPressed: () =>
                              context.goNamed(PrivacyPolicy.routeName),
                          icon: const Icon(Icons.privacy_tip_outlined),
                          iconSize: MediaQuery.of(context)
                              .textScaler
                              .scale(iconScalingFactor),
                        ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: _buildImageWidget(context),
                      ),
                      Flexible(
                        child: _buildLogo(context),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  context.goNamed(SelectGame.soloRouteName);
                                },
                                label: Text(
                                  "Solo Play",
                                ),
                                icon: Icon(
                                  Icons.person_rounded,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    selectHostOrJoinGame(context, ref),
                                label: Text(
                                  "Play with Friends",
                                ),
                                icon: Icon(
                                  Icons.people_alt_rounded,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ProfileButton(),
                      FriendsButton(
                          iconScalingFactor: iconScalingFactor,
                          verifyLoggedIn: _verifyLoggedIn),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildImageWidget(BuildContext context) => Image(
        image: MediaQuery.of(context).platformBrightness == Brightness.light
            ? Image.asset("./images/title.png").image
            : Image.asset("./images/whiteTitle.png").image,
      );

  Widget _buildLogo(BuildContext context) => Image(
        image: MediaQuery.of(context).platformBrightness == Brightness.light
            ? Image.asset("./images/logo.png").image
            : Image.asset("./images/whiteLogo.png").image,
      );

  Future<bool> _verifyLoggedIn(BuildContext context, WidgetRef ref) async {
    if (ref.read(loginInfoProvider).user == null) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Not Logged In"),
          content: const Text(
              "You must be logged in to use this feature. Would you like to login now?"),
          actions: [
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text("Close"),
            ),
            ElevatedButton(
                onPressed: () {
                  context.pop();
                  context.pushNamed(ProfileMainPage.routeName);
                },
                child: const Text("Login"))
          ],
        ),
      );
      return false;
    }
    return true;
  }

  void selectHostOrJoinGame(BuildContext context, WidgetRef ref) async {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        useSafeArea: true,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    if (await _verifyLoggedIn(context, ref) &&
                        context.mounted) {
                      context.goNamed(SelectGame.onlineRouteName,
                          pathParameters: {"action": "create"});
                    }
                  },
                  label: Text(
                    "Host Game",
                  ),
                  icon: Icon(
                    Icons.person_add_alt_1_rounded,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (await _verifyLoggedIn(context, ref) &&
                        context.mounted) {
                      context.goNamed(JoinGamePage.routeName);
                    }
                  },
                  label: Text(
                    "Join Game",
                  ),
                  icon: Icon(
                    Icons.person_search_rounded,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
