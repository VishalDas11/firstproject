import 'package:firstproject/component/spring_widget.dart';
import 'package:firstproject/component/user_imageview.dart';
import 'package:firstproject/controller/theme_controller.dart';
import 'package:firstproject/model/user_model.dart';
import 'package:flutter/material.dart';

class UserChatCard extends StatelessWidget {
  const UserChatCard({super.key, required this.themeController, required this.chatUserModel});

  final DarkThemeController themeController;
  final ChatUserModel chatUserModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SpringWidget(
        onTap: (){},
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          leading: UserImageView(
            radius: 25,
            url: chatUserModel.image.toString()),
        
          title: Text("${chatUserModel.name}", style: TextStyle(color: themeController.colorText),),
        
          subtitle: Text("${chatUserModel.about}", style: TextStyle(color: themeController.colorText2),),
        
          trailing: Text("12:00", style: TextStyle(color: themeController.colorText2),),
        ),
      ),
    );
  }
}