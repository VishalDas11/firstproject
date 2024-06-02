import 'package:firstproject/component/custom_appbar.dart';
import 'package:firstproject/component/custom_button.dart';
import 'package:firstproject/component/cutom_text_field.dart';
import 'package:firstproject/component/round_button.dart';
import 'package:firstproject/constant/color.dart';
import 'package:firstproject/controller/auth_controller.dart';
import 'package:firstproject/controller/getx_controller.dart';
import 'package:firstproject/controller/theme_controller.dart';
import 'package:firstproject/view/home_screen.dart';
import 'package:firstproject/view/singnup.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final StataController controller = Get.put(StataController());
  final authService = AuthService();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DarkThemeController>(
        builder: (themeController) => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: themeController.colorCanvas,
              appBar: CustomAppBar(title: "ChatApp"),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor)),
                      Gap(40),
                      CustomTextField(
                        labelText: "Email",
                        hintText: "Enter your email",
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.loginEmailController,
                        validator: (value) => controller.validateEmail(value)
                            ? null
                            : "Invalid email",
                      ),
                      Gap(20),
                      CustomTextField(
                        labelText: "Password",
                        hintText: "Enter your password",
                        obscureText: true,
                        controller: controller.loginPassController,
                        validator: (value) => value.length < 8
                            ? "Password must be at least 8 characters"
                            : null,
                        suffixIcon: Icons.visibility,
                      ),
                      Gap(30),
                      
                      Obx(()=>
                         RoundButton(
                          loading: controller.loading.value,
                            title: "Login",
                            onTap: () async {
                              if (formkey.currentState!.validate()) {
                                await authService.login(
                                    controller.loginEmailController.text,
                                    controller.loginPassController.text);
                              }
                            },
                            height: 40),
                      ),
                      Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                                color: themeController
                                    .colorText), // Adjust color as needed
                          ),
                          TextButton(
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            onPressed: () {
                              Get.to(() => SignUpScreen());
                            },
                            child: Text("SingUp"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
