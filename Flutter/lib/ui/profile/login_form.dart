import 'package:ripple/ui/profile/input_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../providers/login_info_provider.dart';

class LoginForm extends ConsumerStatefulWidget {
  static const routeName = "login";

  final void Function() onLogin;
  const LoginForm(this.onLogin, {super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? _email;
  String? _password;
  bool isLoading = false;

  Future<void> _handleLogin() async {
    if (isLoading == true) {
      return;
    }

    // Get rid of the keyboard if it's on the screen.
    FocusManager.instance.primaryFocus?.unfocus();

    if (!_formKey.currentState!.saveAndValidate()) {
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      await ref.read(loginInfoProvider.notifier).login(_email!, _password!);
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid email"),
            ),
          );
          break;
        case "user-not-found":
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User not found"),
            ),
          );
          break;
        case "wrong-password":
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Wrong password"),
            ),
          );
          break;
        default:
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "Something unexpected happened! Please check the logs"),
              ),
            );
          }
          print(e);
      }
      setState(() {
        isLoading = false;
      });
      return;
    }

    widget.onLogin();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: Center(
            child: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: screenHeight,
                child: Center(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: InputBackground(
                      child: FormBuilder(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                autofocus: true,
                                keyboardType: TextInputType.emailAddress,
                                name: "email",
                                decoration: const InputDecoration(
                                    label: Text("Email"),
                                    hintText: "Enter your email"),
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.email(),
                                  ],
                                ),
                                onChanged: (value) => setState(
                                  () {
                                    _email = value;
                                  },
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                              FormBuilderTextField(
                                name: "password",
                                obscureText: true,
                                decoration: const InputDecoration(
                                    label: Text("Password"),
                                    hintText: "Enter your password"),
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(8),
                                  ],
                                ),
                                onChanged: (value) => setState(
                                  () {
                                    _password = value;
                                  },
                                ),
                                onSubmitted: (_) => _handleLogin(),
                              ),
                              if (isLoading)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: _handleLogin,
                                    child: Text("Login",
                                        style: TextStyle(
                                            color: MediaQuery.of(context)
                                                        .platformBrightness ==
                                                    Brightness.light
                                                ? Colors.black
                                                : Colors.white)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
