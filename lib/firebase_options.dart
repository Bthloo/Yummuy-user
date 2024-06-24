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
    apiKey: 'AIzaSyD450chAqKnbdaxgIlR9BpvHhN8mqOqLfE',
    appId: '1:47759379431:web:12889ad670a35bec0d0b42',
    messagingSenderId: '47759379431',
    projectId: 'ummuy-d39ec',
    authDomain: 'ummuy-d39ec.firebaseapp.com',
    storageBucket: 'ummuy-d39ec.appspot.com',
    measurementId: 'G-JCSV8B1N2Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZblo6GpXqscrSZkb3eB0OMFixiHxBXRg',
    appId: '1:47759379431:android:25d6592bc9ca84460d0b42',
    messagingSenderId: '47759379431',
    projectId: 'ummuy-d39ec',
    storageBucket: 'ummuy-d39ec.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCosevDJ9wjQeK3HHHU24kjcM3ti2iknv0',
    appId: '1:47759379431:ios:7e54e369d1bf78410d0b42',
    messagingSenderId: '47759379431',
    projectId: 'ummuy-d39ec',
    storageBucket: 'ummuy-d39ec.appspot.com',
    iosBundleId: 'com.example.ummuy2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCosevDJ9wjQeK3HHHU24kjcM3ti2iknv0',
    appId: '1:47759379431:ios:c41c7251fad757ac0d0b42',
    messagingSenderId: '47759379431',
    projectId: 'ummuy-d39ec',
    storageBucket: 'ummuy-d39ec.appspot.com',
    iosBundleId: 'com.example.ummuy2.RunnerTests',
  );
}
