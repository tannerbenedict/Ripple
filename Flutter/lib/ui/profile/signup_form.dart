import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/components/scrollable_centered.dart';
import 'package:ripple/ui/profile/input_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignupForm extends ConsumerStatefulWidget {
  static const routeName = "signup";

  final void Function() onSignup;
  const SignupForm(this.onSignup, {super.key});

  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? _email;
  String? _password;
  bool isLoading = false;

  Future<void> _handleSignup() async {
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
      await ref.read(loginInfoProvider.notifier).signUp(
            _email!,
            _password!,
          );
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Your password is too weak. Make sure there is a mix of upper and lowercase letters, numbers, and special characters."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An account with that email already exists."),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An unexpected error occurred, please try again."),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
      return;
    } catch (e) {
      // Something really weird went wrong, let the login state handle it,
      // just tell the user to try again.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Encountered an unexpected error, please try again."),
        ),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }
    widget.onSignup();
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
          appBar: AppBar(
            title: const Text("Sign Up"),
          ),
          body: ScrollableCentered(
            child: InputBackground(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FormBuilderTextField(
                      keyboardType: TextInputType.emailAddress,
                      name: "email",
                      decoration: const InputDecoration(
                        hintText: "Enter your email",
                        label: Text("Email"),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                    ),
                    FormBuilderTextField(
                      name: "password",
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Enter your password",
                        label: Text("Password"),
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(8),
                        ],
                      ),
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      textInputAction: TextInputAction.done,
                      name: "confirm_password",
                      decoration: const InputDecoration(
                        hintText: "Confirm your password",
                        label: Text("Confirm Password"),
                      ),
                      obscureText: true,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(8),
                          (val) {
                            if (_password != val) {
                              return "Passwords do not match";
                            }
                            return null;
                          }
                        ],
                      ),
                      onSubmitted: (_) => _handleSignup(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _handleSignup,
                              child: Text("Submit",
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
        ));
  }
}
