import 'package:firstproject/constant/color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final double? textsize;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor, this.textsize ,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(text, style: TextStyle(color: AppColor.secondary, fontSize: textsize ?? 14), ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ), 
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
