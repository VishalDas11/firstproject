import 'dart:developer';

import 'package:firstproject/api/api.dart';
import 'package:firstproject/component/chat_card.dart';
import 'package:firstproject/component/custom_appbar.dart';
import 'package:firstproject/component/spring_widget.dart';
import 'package:firstproject/constant/color.dart';
import 'package:firstproject/controller/auth_controller.dart';
import 'package:firstproject/controller/getx_controller.dart';
import 'package:firstproject/controller/theme_controller.dart';
import 'package:firstproject/model/user_model.dart';
import 'package:firstproject/view/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final authService = AuthService();
 final controller = Get.put(StataController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DarkThemeController>(
      builder: (themeController) => Scaffold(
        backgroundColor: themeController.colorCanvas,
        appBar: CustomAppBar(
          title: "Home Screen",
          
          actions: [
           
                
          
            SpringWidget(
              onTap: ()=> Get.to(()=> ProfileScreen(chatUserModel: Api.me!, authService: authService,)),
              child: Icon(CupertinoIcons.ellipsis_vertical, color: whiteColor,)),
              Gap(12)
          ],
        ),
        body: StreamBuilder(
          stream: Api.getallUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
            }

            if (snapshot.hasData) {
              var data = snapshot.data?.docs;
              controller.list.value =
                  data!.map((e) => ChatUserModel.fromJson(e.data())).toList() ??
                      [];
              log("list ${controller.list}");
            }

            if (controller.list.isNotEmpty) {
              return Obx(()=>
                 ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    itemCount: controller.list.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return UserChatCard(
                        themeController: themeController,
                        chatUserModel: controller.list[index],
                      );
                    }),
              );
            } else {
              return Center(
                child: Text(
                  "No Connection Found",
                  style:
                      TextStyle(fontSize: 20, color: themeController.colorText),
                ),
              );
            }
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add_comment_outlined),
          ),
        ),
      ),
    );
  }
}
