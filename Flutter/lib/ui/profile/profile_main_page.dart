import 'package:ripple/ui/profile/login_form.dart';
import 'package:ripple/ui/profile/signup_form.dart';
import 'package:ripple/ui/profile/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/login_info_provider.dart';

class ProfileMainPage extends ConsumerWidget {
  static const routeName = "profile";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginInfoProvider).user;
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
            title: const Text("Profile"),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SafeArea(
                child: user == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              onPressed: () =>
                                  context.goNamed(LoginForm.routeName),
                              child: Text(
                                "Login",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              onPressed: () =>
                                  context.goNamed(SignupForm.routeName),
                              child: Text(
                                "Sign Up",
                              ),
                            ),
                          ),
                        ],
                      )
                    : const UserInfoPage(),
              ),
            ),
          ),
        ));
  }
}
