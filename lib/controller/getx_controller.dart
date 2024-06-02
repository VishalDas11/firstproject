import 'dart:io';

import 'package:firstproject/api/api.dart';
import 'package:firstproject/controller/auth_controller.dart';
import 'package:firstproject/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';

class StataController extends GetxController{

  final signupEmailController = TextEditingController();
  final signUpPassController = TextEditingController();
   final loginEmailController = TextEditingController();
  final loginPassController = TextEditingController();
  RxBool isloading = false.obs;
  RxBool loading = false.obs;
    Rxn<File> pickedImage = Rxn<File>(); // Reactive variable for the image file
   RxList<ChatUserModel> list = <ChatUserModel>[].obs;
   ImageSource? imageSource;


   @override
  void onInit()async {

    // TODO: implement onInit
    super.onInit();
    await Api.getSelfInformation();
    
  }
 

  bool validateEmail(String email) {
    final emailRegex = RegExp(
        r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}");
    return emailRegex.hasMatch(email);
  }



  Future<void> pickImage(ImageSource imageSource) async {
    loading.value = true;
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
     
      pickedImage.value = File(pickedFile.path);
      Api.updateProfilePicture(File(pickedImage.value!.path));
       loading.value = false;
      update(); // Update the UI with the new image
    } else {
      loading.value= false;
      Get.snackbar('Error', 'No image selected');
    }
    Get.back();
  }
}
