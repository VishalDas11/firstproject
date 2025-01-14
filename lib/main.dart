import 'package:firebase_core/firebase_core.dart';
import 'package:firstproject/controller/theme_controller.dart';
import 'package:firstproject/firebase_options.dart';
import 'package:firstproject/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {

WidgetsFlutterBinding.ensureInitialized();
// for status bar 
SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
// for orintation
SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp, DeviceOrientation.portraitDown
]).then((value) async {
  // initilize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
});

   Get.put(DarkThemeController()); // Inject DarkThemeController
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      home: SplashScreen()
    );
  }
}
