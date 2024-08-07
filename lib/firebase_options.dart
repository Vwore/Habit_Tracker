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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDeeEPasRYtrTBiroVHXwJxa3b9rXATlUc',
    appId: '1:950656123046:web:5234c0765a866c62057467',
    messagingSenderId: '950656123046',
    projectId: 'persistventure-ce7a5',
    authDomain: 'persistventure-ce7a5.firebaseapp.com',
    storageBucket: 'persistventure-ce7a5.appspot.com',
    measurementId: 'G-LZHM6S2T8Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUqlWxoraR5-hKf9ezeQiFcinW6Q4qbno',
    appId: '1:950656123046:android:2b6ca670b62cdc5c057467',
    messagingSenderId: '950656123046',
    projectId: 'persistventure-ce7a5',
    storageBucket: 'persistventure-ce7a5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCppq9Pt0P2V86SmYB1OEQKMMr_w31U0Vs',
    appId: '1:950656123046:ios:a245e3e23b086157057467',
    messagingSenderId: '950656123046',
    projectId: 'persistventure-ce7a5',
    storageBucket: 'persistventure-ce7a5.appspot.com',
    iosBundleId: 'com.example.persistVentures',
  );

}