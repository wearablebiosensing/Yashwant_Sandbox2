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
    apiKey: 'AIzaSyDj0XXNF8_Q3lr7WLa6FFOC53iSBJe7fCY',
    appId: '1:1008627958968:web:754f762a89926797b1a04d',
    messagingSenderId: '1008627958968',
    projectId: 'filedisplay2',
    authDomain: 'filedisplay2.firebaseapp.com',
    storageBucket: 'filedisplay2.appspot.com',
    measurementId: 'G-DPFC6KMW67',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYaKSPN3A8ru15JhkPQI3JV-xPspA9yag',
    appId: '1:1008627958968:android:6821cd7b80067d58b1a04d',
    messagingSenderId: '1008627958968',
    projectId: 'filedisplay2',
    storageBucket: 'filedisplay2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxGajIVIf8YZJnAAUPV5DbyoQBAoH7nTI',
    appId: '1:1008627958968:ios:d492994c3c89b2dbb1a04d',
    messagingSenderId: '1008627958968',
    projectId: 'filedisplay2',
    storageBucket: 'filedisplay2.appspot.com',
    androidClientId: '1008627958968-3521jvmqv7eprpgqfcs8d725bicecfiv.apps.googleusercontent.com',
    iosClientId: '1008627958968-cfknj51t2v58921ntqkg5lqe0eu2rpsl.apps.googleusercontent.com',
    iosBundleId: 'com.example.filedisplay2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBxGajIVIf8YZJnAAUPV5DbyoQBAoH7nTI',
    appId: '1:1008627958968:ios:d492994c3c89b2dbb1a04d',
    messagingSenderId: '1008627958968',
    projectId: 'filedisplay2',
    storageBucket: 'filedisplay2.appspot.com',
    androidClientId: '1008627958968-3521jvmqv7eprpgqfcs8d725bicecfiv.apps.googleusercontent.com',
    iosClientId: '1008627958968-cfknj51t2v58921ntqkg5lqe0eu2rpsl.apps.googleusercontent.com',
    iosBundleId: 'com.example.filedisplay2',
  );
}
