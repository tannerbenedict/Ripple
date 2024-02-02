# Family Game Night

## Dependencies & Setup

Ripple is written in Flutter and runs on Firebase. As such, you'll need to install Flutter and have a Firebase account. Because Flutter is a multi-platform framework, you'll need to install not just Flutter, but the Android SDKs and XCode as well. The Flutter website has great instructions for installing [Flutter](https://docs.flutter.dev/get-started/install), the [Android SDK](https://docs.flutter.dev/get-started/install/macos#android-setup), and [XCode](https://docs.flutter.dev/get-started/install/macos#ios-setup). We recommend installing the latest versions of each of these, to avoid any incompatibility issues.

**Note**: You only need to install the relevant components for the platform you wish to develop on, but that Family Game Night is supported officially on all three platforms. Additionally, if you aren't on a Mac, you cannot install XCode and thus cannot do iOS development.

After installing Flutter and friends, you'll also need to install the Firebase CLI. If you already have npm installed, you can simply run

```bash
npm install -g firebase-tools
```

If you don't have npm installed, you can also install a standalone binary. Simply follow the [instructions](https://firebase.google.com/docs/cli/) on Firebase's website.

Once you have the CLI installed, navigate to the root directory of this project and run `firebase emulators:start`. The CLI will then proceed to download, install, and setup each of the necessary emulators, namely the Auth, Firestore, and Hosting emulators.

### Additional Requirements for iOS

If you're planning on developing on iOS, you'll also need to install CocoaPods, which manages the native dependencies on iOS. For the most up-to-date installation instructions, simply go to their [homepage](https://cocoapods.org/).

Finally, after installing all other necessary dependencies, navigate to the Flutter directory and run `flutter pub get`. This will install each of the Dart packages from `pub.dev`.

## IDE Setup (Optional but Recommended)

Flutter has official plugins for both [VSCode](https://docs.flutter.dev/tools/vs-code) and [Android Studio](https://docs.flutter.dev/tools/android-studio). They have great documentation on their website explaining how to install these plugins and configure them. These plugins integrate with the IDE and automagically perform Hot Reload anytime you save a file, as well as integrating device discovery, selection, and many of the other cool Flutter tools such as the Widget Inspector directly in the IDE. If you use these IDE's, you should be using these plugins. If you don't, you probably use Vim or Emacs, in which case you're used to figuring out things all on your own, so good luck.

## Running the Application

### Running on the Web

To run the app on the web, it's as simple as installing Chrome or Microsoft Edge and then running `flutter run -d chrome`. If you don't have Chrome or Edge installed or don't want to open them, you can also run `flutter run -d web-server`, which will then host a local web server you can visit in the browser of your choice.

### Running on Android

To run the app on Android, you'll either need to have a emulator or actual Android device on hand. Once again, the Flutter website has great instructions on setting up the [Android Emulator](https://docs.flutter.dev/get-started/install/macos#set-up-the-android-emulator) or your own [physical device](https://docs.flutter.dev/get-started/install/macos#set-up-your-android-device).

After setting up your device of choice, navigate to the Flutter directory and run `flutter run`. A list of possible devices will show up. Simply choose the one that describes your device of choice and then wait while Gradle and Flutter build and install your app.

**Note**: If you're running the app on an actual physical device, you should instead run `flutter run --dart-define=EMULATOR_IP_ADDRESS<local_ip_here>`, where `<local_ip_here>` is your IP address on your LAN. This helps the physical device know where the Firebase emulators are actually running. Otherwise, if you try to do anything related to Firebase, you'll get an error about unreachable servers, as the device will try to reach out on `localhost`.

### Running on iOS

To run the app on iOS, you'll need either a configured physical device or a configured Simulator. The Flutter website has great instructions for configuring both a [physical device](https://docs.flutter.dev/get-started/install/macos#deploy-to-physical-ios-devices) and the [Simulator](https://docs.flutter.dev/get-started/install/macos#set-up-the-ios-simulator).

After setting up your device of choice, navigate to the Flutter directory and run `flutter run`. A list of possible devices will show up. Simply choose the one that describes your device of choice and then wait while the necessary dependencies are installed with CocoaPods, then while XCode and Flutter build and install your app. Note that the first build can take quite some time, possibly upwards of ten minutes, depending on your computer. Be patient!

**Note**: If you're running the app on an actual physical device, you should instead run `flutter run --dart-define=EMULATOR_IP_ADDRESS<local_ip_here>`, where `<local_ip_here>` is your IP address on your LAN. This helps the physical device know where the Firebase emulators are actually running. Otherwise, if you try to do anything related to Firebase, you'll get an error about unreachable servers, as the device will try to reach out on `localhost`.

## Deploying to Production

Once you're happy with the changes you've made, go ahead and make a merge request on the GitLab repository. If your merge request is approved, it will be deployed by one of us to the Family Game Night Firebase project. If you'd like to deploy FGN to your own Firebase project, you'll just need to enable Firebase Authentication, Firestore, and Hosting, log in on the Firebase CLI, and then run `firebase deploy` from the root directory. It will take a little while to build the indices on the Firestore table, but once it's done, you'll have your own hosted version of FGN running in the cloud.

## Final Notes & Tips

- One of the great things about Flutter compared to something like traditional iOS development is [Hot Reload](https://docs.flutter.dev/tools/hot-reload). You can make changes to your code, hit save, and almost immediately see those changes reflected on the device. Instead of writing all of your code at once, testing to see if it works, modifying, and then recompiling, you should instead start running on the device, then start slowly modifying things, seeing how your changes affect the app. Note that Hot Reload isn't perfect and isn't supported on the web. If you change a class's parent class or the "shape" of the class in memory, then state can't be preserved between reloads. If you start noticing weird behavior, such as duplicated widgets, try doing a Hot Restart instead. This is still much faster then completely recompiling the app.
- Use the Firebase emulators for development! You don't use any of your free tier quota or real money and you can wipe and modify the database to your hearts content. Please don't develop on prod. That's a terrible idea.
- Flutter can be... finicky. It makes it really easy to create the standard mobile interfaces you're used to seeing in most simple mobile apps, but the second you try to do something outside of the mold, like make a card move across the screen from one place to another, you basically have to take complete control. There are packages out there that attempt to make some of this easier (`flutter_animate` is incredibly nice for the simple animations for example), but at some point you'll probably have to take complete control of the layout of your app, possibly even painting. You have been warned.
