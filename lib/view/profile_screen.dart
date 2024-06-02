import 'dart:io';
import 'dart:ui';

import 'package:firstproject/api/api.dart';
import 'package:firstproject/component/custom_appbar.dart';
import 'package:firstproject/component/cutom_text_field.dart';
import 'package:firstproject/component/small_loader.dart';
import 'package:firstproject/component/spring_widget.dart';
import 'package:firstproject/constant/color.dart';
import 'package:firstproject/controller/auth_controller.dart';
import 'package:firstproject/controller/getx_controller.dart';
import 'package:firstproject/controller/theme_controller.dart';
import 'package:firstproject/model/user_model.dart';
import 'package:firstproject/utils/utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen(
      {super.key, required this.chatUserModel, required this.authService});

  final ChatUserModel chatUserModel;
  final AuthService authService;
  final _formkey = GlobalKey<FormState>();
  final controller = Get.put(StataController());
  final isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DarkThemeController>(
      builder: (themeController) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          onWillPop: () => Future.value(false),
          child: Scaffold(
            backgroundColor: themeController.colorCanvas,
            appBar: CustomAppBar(
              title: "Profile Screen",
              automaticallyImplyLeading: true,
            ),
            body: Obx(()=>
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                           Stack(
                            children: [
                               Padding(
                                    padding: const EdgeInsets.only( top: 50),
                                    child: Container(
                                        width: 110,
                                        height: 110,
                                        // padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                                        decoration: BoxDecoration(
                                           
                                            shape: BoxShape.circle,
                                            image: controller.pickedImage.value != null
                                                ? DecorationImage(
                                                    image: FileImage(File(
                                                      controller.pickedImage.value!.path,
                                                    )),
                                                    fit: BoxFit.cover)
                                                : DecorationImage(
                                                    image: NetworkImage(Api.me!.image.toString()),
                                                    fit: BoxFit.cover)),
                                      ),
                                  ),
                                   
                                 
                            
                             Positioned(
                              bottom: 10.0, // Adjust positioning as needed
                              right: 1,
                              
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade200, // Background color for circle
                                radius: 15.0, // Adjust radius as desired
                                child: IconButton(
                                  icon: Icon(Icons.edit, size: 18.0, color: Theme.of(context).primaryColor), // Edit icon customization
                                  onPressed: () {
                                    showBottomSheet(context);
                                  },
                                ),
                              ),
                            ),
                            ],
                           ),
                           
                            Gap(20),
                            Text(
                              "${chatUserModel.email}",
                              style: TextStyle(fontSize: 18, color: themeController.colorText),
                            ),
                            Gap(80),
                            CustomTextField(
                              onSaved: (val) => Api.me!.name = val ?? "",
                              validator: (val) => val != null && val.isNotEmpty ? null : "Required Field",
                              labelText: "Name",
                              initialValue: chatUserModel.name,
                              prefixIcon: Icons.person,
                              radius: 10,
                            ),
                            Gap(30),
                            CustomTextField(
                              onSaved: (val) => Api.me!.about = val ?? "",
                              validator: (val) => val != null && val.isNotEmpty ? null : "Required Field",
                              labelText: "About",
                              initialValue: chatUserModel.about,
                              prefixIcon: Icons.inbox,
                              radius: 10,
                            ),
                            Gap(50),
                            ElevatedButton.icon(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  isLoading.value = true;
                                  Api.updateSelfInfo().then((value) {
                                    Utils.showToast("Profile Update Successfully");
                                    isLoading.value = false;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.edit,
                                color: whiteColor,
                              ),
                              label: Text(
                                "Update",
                                style: TextStyle(color: whiteColor),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple.shade400,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  minimumSize: Size(180, 40)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if(controller.isloading.value)
                   Container(
                                  width: Get.width * 1,
                                  height: Get.height * 1,
                                  color: Colors.black.withOpacity(0.2),
                                  child: Center(child: SmallLoader(),),
                                ),
               
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: FloatingActionButton.extended(
                onPressed: () {
                  authService.logout();
                },
                label: Text("Logout",
                    style: TextStyle(color: themeController.colorText, fontSize: 16)),
                icon: Icon(Icons.logout, color: themeController.colorIcon2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return SizedBox(
            height: Get.height * 0.22,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpringWidget(
                  onTap: () {
                    isLoading.value = true;
                    Get.find<StataController>()
                        .pickImage(ImageSource.gallery)
                        .then((_) => isLoading.value = false);
                  },
                  child: SizedBox(width: 80, height: 80, child: Image.asset('assets/images/gallery.png')),
                ),
                SpringWidget(
                  onTap: () {
                    isLoading.value = true;
                    Get.find<StataController>()
                        .pickImage(ImageSource.camera)
                        .then((_) => isLoading.value = false);
                  },
                  child: SizedBox(width: 80, height: 80, child: Image.asset('assets/images/camera.png')),
                )
              ],
            ),
          );
        });
  }
}
