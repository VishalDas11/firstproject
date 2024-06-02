import 'package:firstproject/controller/auth_controller.dart';
import 'package:firstproject/controller/theme_controller.dart';
import 'package:firstproject/view/home_screen.dart';
import 'package:firstproject/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async'; // Import for Future.delayed

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authService = AuthService();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
    _handleSession();
  }

  Future<void> _handleSession() async {
    try {
      // Delay for 3 seconds
      await Future.delayed(const Duration(seconds: 3));

      final isLoggedIn = await authService.isUserLoggedIn();
      if (isLoggedIn) {
        Get.to(() => HomeScreen());
      } else {
        Get.to(() => LoginScreen());
      }
    } catch (error) {
      print(error); // Log the error for debugging
      // Handle errors gracefully (e.g., show an error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DarkThemeController>(builder: (themeController) => Scaffold(
      backgroundColor: themeController.colorCanvas,
      body: Center(child: Text("Splash Screen")),
    ));
  }
}
