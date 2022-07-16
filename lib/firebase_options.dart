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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyALVKDJaiL7XuschWKjEOt6cmvMxyXSc6Q',
    appId: '1:985014007725:web:2b2c7693c6200224735324',
    messagingSenderId: '985014007725',
    projectId: 'whatsapp-5b098',
    authDomain: 'whatsapp-5b098.firebaseapp.com',
    storageBucket: 'whatsapp-5b098.appspot.com',
    measurementId: 'G-N43RWT6JNB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSGVpXC2Xs04stZbZzCrUiXG-U7OJ6vew',
    appId: '1:985014007725:android:2f3a5a9b0199f126735324',
    messagingSenderId: '985014007725',
    projectId: 'whatsapp-5b098',
    storageBucket: 'whatsapp-5b098.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqDfFd9_wz59FL_-GUTQahwBsAqpuOX8E',
    appId: '1:985014007725:ios:b3c5d52fcf1131aa735324',
    messagingSenderId: '985014007725',
    projectId: 'whatsapp-5b098',
    storageBucket: 'whatsapp-5b098.appspot.com',
    iosClientId: '985014007725-p7as1l585nsrjjrh0i966531a71353uf.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsappProjeto',
  );
}
