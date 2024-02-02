import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/models/database_models/lobby_model.dart';
import 'package:ripple/providers/game_providers/game_notifier.dart';
import 'package:ripple/providers/lobby_provider.dart';
import 'package:ripple/ui/components/scrollable_centered.dart';
import 'package:ripple/ui/profile/input_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JoinGamePage<T extends GameNotifier> extends ConsumerStatefulWidget {
  static const routeName = "joinGame";
  const JoinGamePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinGamePageState();
}

class _JoinGamePageState<T extends GameNotifier>
    extends ConsumerState<JoinGamePage<T>> {
  final _formKey = GlobalKey<FormBuilderState>();
  var _findingGame = false;
  var _code = "";

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() == false) {
      return;
    }
    setState(() {
      _findingGame = true;
    });

    final notifier = ref.read(lobbyNotifierProvider(_code).notifier);
    LobbyModel lobby;
    try {
      lobby = await notifier.joinGame();
      var gameNotifier = ref.read(lobby.gameType.provider(_code).notifier);
      await gameNotifier.joinGame();

      if (context.mounted) {
        if (lobby.gameStatus == GameStatus.playing) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final (routeName, params) = gameNotifier.getGameRoutingInfo();
            context.goNamed(routeName, pathParameters: params);
          });
        } else {
          final (routeName, params) = gameNotifier.getLobbyRoutingInfo();
          context.goNamed(routeName, pathParameters: params);
        }
      }
    } on GameNotFoundException {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text(
                "That game doesn't exist! Please make sure you've entered the right code and then try again."),
            actions: [
              ElevatedButton(
                  onPressed: () => context.pop(), child: const Text("Close"))
            ],
          ),
        );
      }
    } catch (e) {
      print("Encountered an unexpected error: $e");
      rethrow;
    } finally {
      setState(() {
        _findingGame = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(title: Text("Join Game")),
          body: ScrollableCentered(
            child: InputBackground(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                        name: "lobbyCode",
                        decoration: const InputDecoration(
                            hintText: "Enter a lobby code"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a lobby code";
                          }
                          return null;
                        },
                        onChanged: (value) => setState(() {
                          _code = value == null ? "" : value.toUpperCase();
                        }),
                        onSubmitted: (_) => _submitForm(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _findingGame
                          ? const CircularProgressIndicator()
                          : ElevatedButton.icon(
                              onPressed: _submitForm,
                              icon: Icon(
                                Icons.send,
                              ),
                              label: Text(
                                "Join Game",
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
