import 'package:firstproject/constant/color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions; // Optional list of actions to display on the right
  final bool automaticallyImplyLeading; // Whether to show a back button

   CustomAppBar({
     this.title,
    this.actions,
    this.automaticallyImplyLeading = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // Sets the height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? "", style: TextStyle(color: AppColor.secondary),),
      centerTitle: true, // Center the title text
      backgroundColor: Theme.of(context).primaryColor, // Use primary color
      iconTheme: Theme.of(context).iconTheme, // Inherit icon theme
      actions: actions, // Add optional actions
      automaticallyImplyLeading: automaticallyImplyLeading , // Back button
    );
  }
}
