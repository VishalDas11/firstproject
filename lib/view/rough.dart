import 'package:firstproject/component/cutom_text_field.dart';
import 'package:firstproject/component/small_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RoughScreen extends StatelessWidget {
  const RoughScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(

        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(labelText: "Hello"),
              Gap(30),
              CustomTextField(labelText: "Hello"),
              Gap(30),
              CustomTextField(labelText: "Hello"),
              Gap(30),
              CustomTextField(labelText: "Hello"),
              Gap(30),
              CustomTextField(labelText: "Hello"),
              Gap(30),
              CustomTextField(labelText: "Hello"),
              Gap(30),
            ],
          ),
          // Container(
          //   color: Colors.black.withOpacity(0.2),
          //   width: Get.width*1,
          //   height: Get.height*1,
          //   child: Center(child: SmallLoader()))
        ],
      ),
    );
  }
}