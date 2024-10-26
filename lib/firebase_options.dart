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
    apiKey: 'AIzaSyB2kPTrb_pFIcEagZRPQZ8JYYmYNZMz4YQ',
    appId: '1:124375368668:web:9b6ff976fa650d2f28c519',
    messagingSenderId: '124375368668',
    projectId: 'studyit-85190',
    authDomain: 'studyit-85190.firebaseapp.com',
    storageBucket: 'studyit-85190.appspot.com',
    measurementId: 'G-Z0LHN6RTZH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCUl8NSn9k6wopOaPQWrw4TfCCVn9roy8',
    appId: '1:124375368668:android:0db9863734a778de28c519',
    messagingSenderId: '124375368668',
    projectId: 'studyit-85190',
    storageBucket: 'studyit-85190.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvT97vp-b7guUbDMeu3MiqI4HWfJ1uZqM',
    appId: '1:124375368668:ios:d5da9f9ec56e2b7b28c519',
    messagingSenderId: '124375368668',
    projectId: 'studyit-85190',
    storageBucket: 'studyit-85190.appspot.com',
    iosBundleId: 'com.example.studyit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvT97vp-b7guUbDMeu3MiqI4HWfJ1uZqM',
    appId: '1:124375368668:ios:d5da9f9ec56e2b7b28c519',
    messagingSenderId: '124375368668',
    projectId: 'studyit-85190',
    storageBucket: 'studyit-85190.appspot.com',
    iosBundleId: 'com.example.studyit',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB2kPTrb_pFIcEagZRPQZ8JYYmYNZMz4YQ',
    appId: '1:124375368668:web:95445b3c221b19eb28c519',
    messagingSenderId: '124375368668',
    projectId: 'studyit-85190',
    authDomain: 'studyit-85190.firebaseapp.com',
    storageBucket: 'studyit-85190.appspot.com',
    measurementId: 'G-R8B0J7T75H',
  );
}
