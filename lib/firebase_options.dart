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
    apiKey: 'AIzaSyCIFGVe8rYbtty5qnkYFIg-0OUJhnU0LpI',
    appId: '1:264501829712:web:7f576b0bc4a76d76fb7155',
    messagingSenderId: '264501829712',
    projectId: 'iic-development',
    authDomain: 'iic-development.firebaseapp.com',
    storageBucket: 'iic-development.appspot.com',
    measurementId: 'G-P5V7YM3Q3B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArBMWW4ZXFp0MUOR2b681nNe7JqsyCaxQ',
    appId: '1:264501829712:android:c6b45292987a32cefb7155',
    messagingSenderId: '264501829712',
    projectId: 'iic-development',
    storageBucket: 'iic-development.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-9QWNgWZZ5pOlxEVbsyeyKSBPQGMWXWk',
    appId: '1:264501829712:ios:21b411bc5b51db27fb7155',
    messagingSenderId: '264501829712',
    projectId: 'iic-development',
    storageBucket: 'iic-development.appspot.com',
    iosBundleId: 'com.iicdev.TimerTasks',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-9QWNgWZZ5pOlxEVbsyeyKSBPQGMWXWk',
    appId: '1:264501829712:ios:0ec715494c54f7b1fb7155',
    messagingSenderId: '264501829712',
    projectId: 'iic-development',
    storageBucket: 'iic-development.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCIFGVe8rYbtty5qnkYFIg-0OUJhnU0LpI',
    appId: '1:264501829712:web:7f576b0bc4a76d76fb7155',
    messagingSenderId: '264501829712',
    projectId: 'iic-development',
    authDomain: 'iic-development.firebaseapp.com',
    storageBucket: 'iic-development.appspot.com',
    measurementId: 'G-P5V7YM3Q3B',
  );
}
