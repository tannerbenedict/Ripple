import 'package:ripple/globals.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/ui/games/player_avatar.dart';
import 'package:ripple/ui/profile/input_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/login_info_provider.dart';

class UserInfoPage extends HookConsumerWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormBuilderState>()).value;
    final updatingUsername = useState(false);
    final loggingOut = useState(false);
    final user = ref.watch(loginInfoProvider.select((value) => value.user));
    final textController = useTextEditingController();
    textController.text = user?.displayName ?? "";
    final size = MediaQuery.of(context).size;
    final databaseUser = ref.watch(
        databaseRepositoryProvider.select((value) => value.getUser(user!.uid)));

    Future<void> handleFormSubmit() async {
      if (!formKey.currentState!.saveAndValidate()) {
        return;
      }

      try {
        updatingUsername.value = true;
        await ref
            .read(loginInfoProvider.notifier)
            .updateUsername(textController.text);
        updatingUsername.value = false;
      } catch (e) {
        print("Encountered an unexpected error trying to update username: $e");
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something unexpected happened. Please try again!"),
          ),
        );
        updatingUsername.value = false;
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Username updated!"),
          ),
        );
      }
    }

    return FutureBuilder(
        future: databaseUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            cardBack = user.selectedCardBack;
            coins = user.coins;
            purchased = user.cardBacks;
            gp = user.gamesPlayed;
            gw = user.gamesWon;
            twogp = user.twoPlayerGamesPlayed;
            twogw = user.twoPlayerGamesWon;
            return SizedBox(
              height: size.height,
              width: size.width / 2,
              child: Center(
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: FormBuilder(
                    key: formKey,
                    child: InputBackground(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PlayerAvatar(player: user, isPlayerTurn: false),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Tooltip(
                                    triggerMode: TooltipTriggerMode.tap,
                                    message:
                                        "Your avatar is randomly generated from your username. Try changing it!",
                                    child: Icon(Icons.info_outline)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FormBuilderTextField(
                              decoration: InputDecoration(
                                labelText: "Username",
                                hintText: "Enter your username",
                              ),
                              controller: textController,
                              name: "username",
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(),
                                ],
                              ),
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => handleFormSubmit(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: updatingUsername.value
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () => handleFormSubmit(),
                                    child: Text(
                                      "Update Username",
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: loggingOut.value
                                ? CircularProgressIndicator()
                                : ElevatedButton.icon(
                                    onPressed: () async {
                                      try {
                                        loggingOut.value = true;
                                        await FirebaseAuth.instance.signOut();
                                        loggingOut.value = false;
                                      } on FirebaseAuthException catch (e) {
                                        print(
                                            "Encountered an unexpected error trying to logout: $e");
                                        loggingOut.value = false;
                                      }
                                    },
                                    icon: Icon(
                                      Icons.logout,
                                    ),
                                    label: Text(
                                      "Logout",
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Text("Something went wrong. Please check the logs");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
