import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstproject/model/user_model.dart';


class Api{
  // for authentication
  static final  auth = FirebaseAuth.instance;
  // for accessing cloud firestore
  static  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // for aceesing images storage
  static FirebaseStorage storage = FirebaseStorage.instance;

   // to store self infoemation
  static ChatUserModel? me;

    static User get user => auth.currentUser!;


  static Future<ChatUserModel?> getUserData(String userId) async {
  try {
    final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (docSnapshot.exists) {
      return ChatUserModel.fromJson(docSnapshot as Map<String, dynamic>);
    } else {
      print('User document with ID: $userId does not exist');
      return null; // Handle case where user document doesn't exist
    }
  } catch (error) {
    print(error); // Log the error for debugging
    return null; // Handle potential errors during data retrieval
  }
}


   // for getting self information

     static Future<void> getSelfInformation ()async{
      await firestore.collection('users').doc(user.uid).get().then((user) async {
          if(user!= null){
              me = ChatUserModel.fromJson(user.data()!);
          }
          else{
            await createUser().then((value) => getSelfInformation());
          }
      });
     }

       // for creating a new user
     static Future<void> createUser()async{
      final time = DateTime.now().millisecondsSinceEpoch.toString();

      final chatUser = ChatUserModel(
        id: user.uid,
        name: user.displayName,
        email: user.email,
        createsAt: time,
        image: user.photoURL,
        lastActive: time,
        isOnline: false,
        pushToken: ""
      );

      return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
     }

     // for getting all users from firstore

     static Stream<QuerySnapshot<Map<String , dynamic>>> getallUser(){
      return firestore.collection('users').where('id', isNotEqualTo: user.uid).snapshots();
     }

    static Future<void> updateSelfInfo()async{
        await firestore.collection('users').doc(user.uid).update({
            'name' : me!.name,
            'about' : me!.about
          });
    }

    static Future<void> updateProfilePicture(File file)async{
        final ext  = file.path.split(".").length;
        // storage file ref with path
        final ref =  storage.ref().child('profile_picture/${user.uid}.$ext');
        // uploading image
        await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) async {
          log("Data transferred : ${p0.bytesTransferred/1000}.Kb");
        });
         me!.image =await ref.getDownloadURL();
          // update the image
          await firestore.collection('users').doc(user.uid).update({
           'image' : me!.image
          });
    
    }

}