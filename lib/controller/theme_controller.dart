import 'package:firstproject/constant/color.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class DarkThemeController extends GetxController {
  final _darkTheme = false.obs;

  bool get isDarkTheme => _darkTheme.value;

  @override
  void onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    _darkTheme.value = prefs.getBool('darkTheme') ?? false;
  }

  void toggleTheme() async {
    _darkTheme.value = !_darkTheme.value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkTheme', _darkTheme.value);
    update();
  }

  Color get colorCanvas => isDarkTheme ? darkCanvas : lightCanvas;
  Color get colorCard => isDarkTheme ? darkCardColor : lightCardColor;
  Color get colorTabSelected => isDarkTheme ? Colors.white : primaryColor;
  Color get colorTabUnselected =>
      isDarkTheme ? const Color(0xFF686872) : Colors.grey[350]!;
  Color get colorText => isDarkTheme ? Colors.white : Colors.black;
  Color get colorTextReverse => isDarkTheme ? Colors.black : Colors.white;
  Color get colorText2 =>
      isDarkTheme ? const Color(0xFF919191) : const Color(0xFF919191);
  Color get colorText3 =>
      isDarkTheme ? const Color(0xFF919191) : Colors.black87;

  Color get colorIcon => primaryColor;
  Color get colorIcon2 => isDarkTheme ? Colors.white : Colors.black;
  Color get colorIcon3 =>
      isDarkTheme ? const Color(0xFF919191) : const Color(0xFF919191);
  Color get colorCursor => isDarkTheme ? Colors.white : Colors.black;

  Color get colorField =>
      isDarkTheme ? const Color.fromARGB(255, 41, 41, 46) : Colors.white;

  Color get colorTextTitle => isDarkTheme ? Colors.white : Colors.black;
  Color get colorTextSubtitle =>
      isDarkTheme ? Colors.grey.shade300 : Colors.grey.shade700;

  SystemUiOverlayStyle get systemUiOverlayStyle => SystemUiOverlayStyle(
        statusBarBrightness: isDarkTheme ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkTheme ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: colorCanvas,
        statusBarColor: colorCanvas,
        systemNavigationBarDividerColor: Colors.transparent,
      );
  // Add other color properties here

  SystemUiOverlayStyle get systemUiOverlayStyleBottom => SystemUiOverlayStyle(
        statusBarBrightness: isDarkTheme ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkTheme ? Brightness.dark : Brightness.light,
       
        statusBarColor: Colors.transparent,
      );
}
//    theme buttton
 // ListTile(
            //   leading: Text("Mode", style: TextStyle(color: themeController.colorText, fontSize: 20),),
            //   trailing: Switch.adaptive(
            //         activeColor: Theme.of(context).primaryColor,
            //         value: themeController.isDarkTheme,
            //         onChanged: ((value) => themeController.toggleTheme()),
            //       ),
            // ),
