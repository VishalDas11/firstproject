import 'dart:io';
import 'package:firstproject/controller/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmallLoader extends StatelessWidget {
  const SmallLoader({
    Key? key,
    this.adaptive = false,
    this.color,
  }) : super(key: key);
  final bool adaptive;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DarkThemeController>(
      builder: (themeController) => Platform.isIOS
          ? CupertinoActivityIndicator(
              color: color ?? themeController.colorIcon2,
            )
          : SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                    color ?? themeController.colorIcon2),
              ),
            ),
    );
  }
}




