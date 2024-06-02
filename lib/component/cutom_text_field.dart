import 'package:firstproject/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Function(String)? validator;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final String? initialValue;
  final double? radius;
  final Function(String)? onSaved;

  CustomTextField({
    required this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.initialValue,
    this.prefixIcon,
    this.radius,
    this.onSaved,
  });

  final themeController = Get.put(DarkThemeController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Prevent excessive width
      children: [
       
        Expanded(
          child: TextFormField(
            initialValue: initialValue,
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              hintStyle: TextStyle(color: themeController.colorText2),
              suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
              prefixIcon: prefixIcon != null ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(prefixIcon, size: 22.0),
              ) : null,
              prefixIconColor: Theme.of(context).primaryColor,
              contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 30.0),
              ),
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: (value) => validator!(value!),
            onSaved: (value)=> onSaved!(value!),
          ),
        ),
      ],
    );
  }
}
