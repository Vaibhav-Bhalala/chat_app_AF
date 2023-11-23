// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyByvXt2bMHgzRxelsJbljCAUcN4hHfT2No',
    appId: '1:1087446160459:web:b47863bad4780ff990e9ce',
    messagingSenderId: '1087446160459',
    projectId: 'chat-app-4c3c1',
    authDomain: 'chat-app-4c3c1.firebaseapp.com',
    storageBucket: 'chat-app-4c3c1.appspot.com',
    measurementId: 'G-H7XB1DZT02',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdq3UUZLCvxBwy4eBCiYBT_ghTitM1ElI',
    appId: '1:1087446160459:android:066cb04920157add90e9ce',
    messagingSenderId: '1087446160459',
    projectId: 'chat-app-4c3c1',
    storageBucket: 'chat-app-4c3c1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_xHPKDBD-VGYqnpu3RcwLMjEgU0iNStI',
    appId: '1:1087446160459:ios:7f5f9b67652057c290e9ce',
    messagingSenderId: '1087446160459',
    projectId: 'chat-app-4c3c1',
    storageBucket: 'chat-app-4c3c1.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_xHPKDBD-VGYqnpu3RcwLMjEgU0iNStI',
    appId: '1:1087446160459:ios:982c39e165a3413f90e9ce',
    messagingSenderId: '1087446160459',
    projectId: 'chat-app-4c3c1',
    storageBucket: 'chat-app-4c3c1.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}
