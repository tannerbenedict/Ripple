import 'package:ripple/ui/profile/input_background.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  static const routeName = "privacy_policy";

  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy and Contact Info")),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: MediaQuery.of(context).platformBrightness == Brightness.light
              ? Image.asset("./images/oak_background.jpg").image
              : Image.asset("./images/dark_background.jpg").image,
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: InputBackground(
              child: Scrollbar(
                child: SingleChildScrollView(
                  primary: true,
                  child: SizedBox(
                    width: width / 2,
                    child: Column(
                      children: [
                        Text(
                          "Privacy Policy",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          "We use Firebase as our backend as a service. As such, most of our privacy policy is the same as theirs. Namely, we store the email address that you provide upon sign up. If you do not update your username, it defaults to this email address, meaning that other users will see your email address. If you provide us with a new username, we store this information. Other users are allowed to access this information so that they can see who they're playing against. Additionally, we store statistics on your gameplay, such as how many games you have played, how many games you've won, your win-loss rate, how many in-game coins you have earned, and your lowest move count in Solitaire. These statistics are used solely for your own edification. They are not sold to third-parties."
                          "\n"
                          "We also store gameplay content, which consists of the state of the game as you and other users play. This is used to allow you to resume your game if you close the app or navigate away from it and to allow for online functionality. This information is not sold to third-parties, but it is accessible to other users. We also store a list of your in-app friends. This list is not sold to third-parties and is only used to allow you to play with your friends. We also store a list of the messages that you have sent to other users as part of the in-game text chat functionality. This information is not sold to third-parties and is used solely to allow you to communicate with other users."
                          "\n"
                          "Your password is stored by Firebase and is not accessible to us in any way. Firebase stores a specific user identifier that is associated with your account for the purposes of authentication and authorization. This identifier is used whenever you play online. Additionally, the Firebase libraries we use send the Firebase user agent to Firebase, which consists of the following information: device, OS, app bundle ID, and developer platform. We do not sell your information to third parties. We do not use your information for any purpose other than to provide you with the services of this app."
                          "\n"
                          "If you are not logged in, we store no information about you. All solo play happens on device and is not stored anywhere. If you are logged in, we store the information described above. If you would like to delete your account, please contact us using the information below.",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text("Contact Info",
                            style: Theme.of(context).textTheme.displaySmall),
                        Text(
                          "If you have any questions about this privacy policy or have any other concerns, please contact us at familygamenight77@gmail.com.",
                          style: Theme.of(context).textTheme.bodyLarge,
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
    );
  }
}
