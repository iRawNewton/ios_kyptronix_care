import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'getstarted/getstarted.dart';
import 'screens/2selectuser/homescreen.dart';

void main() async {
  // splash screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  // one signal
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId('84adfc0e-af05-439b-a44d-b4e3e18eb94d');
  OneSignal.shared.promptUserForPushNotificationPermission().then((value) {
    debugPrint('accepted permission: $value');
  });
  final prefs = await SharedPreferences.getInstance();
  final showGetStarted = prefs.getBool('showGetStarted') ?? true;
  runApp(MyApp(showGetStarted: showGetStarted));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.showGetStarted});
  final bool showGetStarted;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // for splash screen
    void initialize() async {
      await Future.delayed(const Duration(seconds: 2));
      FlutterNativeSplash.remove();
    }

    initialize();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Client Onboarding Mobile App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: showGetStarted ? const MyAppGetStarted() : const MyUsers(),
    );
  }
}
