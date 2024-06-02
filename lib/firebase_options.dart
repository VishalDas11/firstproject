// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBcpSVU24ORrsj_RrkoSsmvUrX6rZwB59c',
    appId: '1:180323673837:web:05cd7432208abc44ec4ee4',
    messagingSenderId: '180323673837',
    projectId: 'chatproject-f85e8',
    authDomain: 'chatproject-f85e8.firebaseapp.com',
    storageBucket: 'chatproject-f85e8.appspot.com',
    measurementId: 'G-WGRBE507F5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkYtUGZzjhCZjk4RrPIJzSLzDKafZLHP4',
    appId: '1:180323673837:android:e9efe8b6f5ed72b5ec4ee4',
    messagingSenderId: '180323673837',
    projectId: 'chatproject-f85e8',
    storageBucket: 'chatproject-f85e8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD70umhf9dNIttDRVAs5cLgJKzmqrH9wRo',
    appId: '1:180323673837:ios:d4a4f4594e3306b5ec4ee4',
    messagingSenderId: '180323673837',
    projectId: 'chatproject-f85e8',
    storageBucket: 'chatproject-f85e8.appspot.com',
    iosBundleId: 'com.example.firstproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD70umhf9dNIttDRVAs5cLgJKzmqrH9wRo',
    appId: '1:180323673837:ios:d4a4f4594e3306b5ec4ee4',
    messagingSenderId: '180323673837',
    projectId: 'chatproject-f85e8',
    storageBucket: 'chatproject-f85e8.appspot.com',
    iosBundleId: 'com.example.firstproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBcpSVU24ORrsj_RrkoSsmvUrX6rZwB59c',
    appId: '1:180323673837:web:fa11d5fcf254cda1ec4ee4',
    messagingSenderId: '180323673837',
    projectId: 'chatproject-f85e8',
    authDomain: 'chatproject-f85e8.firebaseapp.com',
    storageBucket: 'chatproject-f85e8.appspot.com',
    measurementId: 'G-47XEJ5P8G5',
  );
}