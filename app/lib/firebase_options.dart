// File generated by FlutterFire CLI.
// ignore_for_file: type=lint

// Package imports:
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCt0uj2KLEcZR3Rnf78dxSCWDtULoWb3DA',
    appId: '1:366661800804:web:6aac639486eb47d1e0a071',
    messagingSenderId: '366661800804',
    projectId: 'episode-tracker-ceeb1',
    authDomain: 'episode-tracker-ceeb1.firebaseapp.com',
    storageBucket: 'episode-tracker-ceeb1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBG90zBaTCm4PGB2taMfJljH-On6_J7w9U',
    appId: '1:366661800804:ios:56052ed962bb15f7e0a071',
    messagingSenderId: '366661800804',
    projectId: 'episode-tracker-ceeb1',
    storageBucket: 'episode-tracker-ceeb1.firebasestorage.app',
    iosClientId: '366661800804-s6a4gpjg3ts636trbooi0i0ss8mehsqp.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBG90zBaTCm4PGB2taMfJljH-On6_J7w9U',
    appId: '1:366661800804:ios:56052ed962bb15f7e0a071',
    messagingSenderId: '366661800804',
    projectId: 'episode-tracker-ceeb1',
    storageBucket: 'episode-tracker-ceeb1.firebasestorage.app',
    iosClientId: '366661800804-s6a4gpjg3ts636trbooi0i0ss8mehsqp.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );

}