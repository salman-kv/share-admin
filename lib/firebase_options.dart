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
    apiKey: 'AIzaSyA7_29GlxIoxJeohqeP3789SLhcg_ivICU',
    appId: '1:1095050887592:web:340a2aa5a1b8802dcf9d9d',
    messagingSenderId: '1095050887592',
    projectId: 'share-8f98c',
    authDomain: 'share-8f98c.firebaseapp.com',
    storageBucket: 'share-8f98c.appspot.com',
    measurementId: 'G-9G3R7Z9HV8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCl0-RbwWT8RZN6Ay-SdMVz1PoGKrQDbYA',
    appId: '1:1095050887592:android:ddc3879ebb698cedcf9d9d',
    messagingSenderId: '1095050887592',
    projectId: 'share-8f98c',
    storageBucket: 'share-8f98c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdHl41gRzNSWXJGdJV9YLD5jL52-3y_38',
    appId: '1:1095050887592:ios:86e7519435f8b701cf9d9d',
    messagingSenderId: '1095050887592',
    projectId: 'share-8f98c',
    storageBucket: 'share-8f98c.appspot.com',
    androidClientId: '1095050887592-0mi10bpv8sdtu48r06kmb29omndal7vh.apps.googleusercontent.com',
    iosClientId: '1095050887592-lndb73ve0de9ecoiop3ogc05r55p4d71.apps.googleusercontent.com',
    iosBundleId: 'com.example.shareSubAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdHl41gRzNSWXJGdJV9YLD5jL52-3y_38',
    appId: '1:1095050887592:ios:3052f1f499623570cf9d9d',
    messagingSenderId: '1095050887592',
    projectId: 'share-8f98c',
    storageBucket: 'share-8f98c.appspot.com',
    androidClientId: '1095050887592-0mi10bpv8sdtu48r06kmb29omndal7vh.apps.googleusercontent.com',
    iosClientId: '1095050887592-qp5ip10u6a65h3o4o95ktpbq37fku9sh.apps.googleusercontent.com',
    iosBundleId: 'com.example.shareSubAdmin.RunnerTests',
  );
}