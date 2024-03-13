import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ripple/app/ripple.dart';
import 'package:ripple/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const emulatorIpAddress =
    String.fromEnvironment("EMULATOR_IP_ADDRESS", defaultValue: "localhost");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator(emulatorIpAddress, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(emulatorIpAddress, 8080);
    Animate.restartOnHotReload = true;
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(ProviderScope(child: Ripple()));
}
