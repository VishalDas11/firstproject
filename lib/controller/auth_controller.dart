import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstproject/api/api.dart';
import 'package:firstproject/controller/getx_controller.dart';
import 'package:firstproject/model/user_model.dart';
import 'package:firstproject/utils/utils.dart';
import 'package:firstproject/view/home_screen.dart';
import 'package:firstproject/view/login_screen.dart';
import 'package:get/get.dart';

class AuthService {
  static  FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore  = FirebaseFirestore.instance;

  // // for stor self infoemation
  // static late ChatUserModel me;

  final controller = Get.put(StataController());

  // static User get user => _auth.currentUser!;

    // for checking if user is exist or not
   bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }
      // for signup
  Future<UserCredential?> signUp(String email, String password) async {
    controller.loading.value = false;
    try {
      controller.loading.value = true;
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential != null) {
        controller.signupEmailController.clear();
        controller.signUpPassController.clear();
        await Api.createUser();
        Get.to(() => LoginScreen());
        controller.loading.value = false;
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      controller.loading.value = false;
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils.showToast("The account already exists for that email.");
      }
      return null;
    } catch (e) {
      controller.loading.value = false;
      print(e);
      return null;
    }
  }
      // for login
  Future<UserCredential?> login(String email, String password) async {
    controller.loading.value = false;
    try {
      controller.loading.value = true;
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential != null) {
        controller.loginEmailController.clear();
        controller.loginPassController.clear();
        Get.to(() => HomeScreen());
        controller.loading.value = false;
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      controller.loading.value = false;
      if (e.code == 'user-not-found') {
        Utils.showToast("No user found for that email..");
      } else if (e.code == 'wrong-password') {
        Utils.showToast("Wrong password provided for that user");
      }
      return null;
    } catch (e) {
      controller.loading.value = false;
      print(e);
      return null;
    }
  }
      // for logout
  Future<void> logout() async {
    try {

      await _auth.signOut();
      Get.off(()=> LoginScreen());
      Utils.showToast("Logout Successfuly");
    } catch (e) {
      print(e);
      Utils.showToast("Error $e");
    }
  }
     
    //  // for getting self information

    //  static Future<void> getSelfInformation ()async{
    //   await firestore.collection('users').doc(user.uid).get().then((user) async {
    //       if(user!= null){
    //           me = ChatUserModel.fromJson(user.data()!);
    //       }
    //       else{
    //         await createUser().then((value) => getSelfInformation());
    //       }
    //   });
    //  }
     
    //   // for creating a new user
    //  static Future<void> createUser()async{
    //   final time = DateTime.now().millisecondsSinceEpoch.toString();

    //   final chatUser = ChatUserModel(
    //     id: user.uid,
    //     name: user.displayName,
    //     email: user.email,
    //     createsAt: time,
    //     image: user.photoURL,
    //     lastActive: time,
    //     isOnline: false,
    //     pushToken: ""
    //   );

    //   return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
    //  }

    //  // for getting all users from firstore

    //  static Stream<QuerySnapshot<Map<String , dynamic>>> getallUser(){
    //   return firestore.collection('users').where('id', isNotEqualTo: user.uid).snapshots();
    //  }

}
