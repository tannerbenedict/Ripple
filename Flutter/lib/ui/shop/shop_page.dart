import 'package:carousel_slider/carousel_slider.dart';
import 'package:ripple/globals.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/user.dart';
import '../../providers/login_info_provider.dart';

class ShopPage extends HookConsumerWidget {
  static const routeName = "shop";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var name = ['Black', 'White', 'Red', 'Blue', 'Green', 'Purple', 'Orange'];
    var arr = [
      'images/cardBack.png',
      'images/cardBack1.png',
      'images/cardBack2.png',
      'images/cardBack3.png',
      'images/cardBack4.png',
      'images/cardBack5.png',
      'images/cardBack6.png',
    ];
    final currentPage = useState(0);
    final controller = useState(CarouselController()).value;
    final user = ref.watch(loginInfoProvider.select((value) => value.user));
    final databaseUser = ref.watch(
        databaseRepositoryProvider.select((value) => value.getUser(user!.uid)));

    return FutureBuilder(
      future: databaseUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          final coins = user.coins;
          final cardBacks = user.cardBacks;
          cardBack = user.selectedCardBack;
          return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? Image.asset("./images/oak_background.jpg").image
                        : Image.asset("./images/dark_background.jpg").image,
                    fit: BoxFit.cover),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: const Text("Shop"),
                ),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Coins: $coins",
                          style: Theme.of(context).textTheme.headlineSmall),
                      CarouselSlider.builder(
                        itemCount: arr.length,
                        itemBuilder: (context, index, pageViewIndex) {
                          return _CarouselCard(() async {
                            await controller.animateToPage(pageViewIndex,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          }, arr[index], name[index]);
                        },
                        options: CarouselOptions(
                          autoPlay: false,
                          onPageChanged: (index, _) {
                            currentPage.value = index;
                          },
                          height: MediaQuery.of(context).size.height * 0.5,
                          viewportFraction: 0.3,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        ),
                        carouselController: controller,
                      ),
                      ElevatedButton(
                          onPressed:
                              user.selectedCardBack == arr[currentPage.value]
                                  ? null
                                  : () => setCardback(arr[currentPage.value],
                                      coins, cardBacks, context, ref),
                          child: Text(
                            cardBacks.contains(arr[currentPage.value])
                                ? user.selectedCardBack ==
                                        arr[currentPage.value]
                                    ? "Selected"
                                    : "Select"
                                : "Purchase",
                          )),
                    ]),
              ));
        } else if (snapshot.hasError) {
          return const Text("Something went wrong. Please check the logs");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  static setCardback(String current, int coins, List<String> cardBacks,
      BuildContext context, WidgetRef ref) async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    if (cardBacks.contains(current)) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Selected"),
          content: const Text("Cardback set to current selection"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.invalidate(databaseRepositoryProvider);
              },
              child: const Text("Close"),
            ),
          ],
        ),
      ).then((value) {
        ref.invalidate(databaseRepositoryProvider);
      });
      cardBack = current;
      await ref
          .read(databaseRepositoryProvider)
          .setCardBack(User.fromFirebaseUser(user!), current);
    } else if (coins >= 10) {
      cardBack = current;
      await ref
          .read(databaseRepositoryProvider)
          .purchaseCardBacks(User.fromFirebaseUser(user!), current);

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Purchased"),
            content: const Text(
                "Purchase successful! \nCardback set to current selection"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.invalidate(databaseRepositoryProvider);
                },
                child: const Text("Close"),
              ),
            ],
          ),
        ).then((value) {
          ref.invalidate(databaseRepositoryProvider);
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Failed"),
          content: const Text("Not enough coins"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        ),
      );
    }
  }
}

class _CarouselCard extends ConsumerWidget {
  final void Function() onTapCallback;
  final String imagePath;
  final String label;

  const _CarouselCard(this.onTapCallback, this.imagePath, this.label);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginInfoProvider.select((value) => value.user));
    final databaseUser = ref.watch(
        databaseRepositoryProvider.select((value) => value.getUser(user!.uid)));

    return FutureBuilder(
      future: databaseUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          // Fresh user data fetched from the database, should have your coins here,
          // as well as what card backs they have, what card back is selected, etc.
          final cardBacks = user.cardBacks;
          return Column(
            children: [
              if (!cardBacks.contains(imagePath)) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: onTapCallback,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Banner(
                          location: BannerLocation.topEnd,
                          color: Colors.grey,
                          message: "10 Coins",
                          child: Image.asset(imagePath),
                        )),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: GestureDetector(
                      onTap: onTapCallback,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.asset(imagePath),
                      )),
                ),
              ],
              Text(label, style: Theme.of(context).textTheme.headlineSmall),
            ],
          );
        } else if (snapshot.hasError) {
          return const Text("Something went wrong. Please check the logs");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
