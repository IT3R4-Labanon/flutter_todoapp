
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
    apiKey: 'AIzaSyDFLI8l30_CPP9Gp-A4UmyIc7bnA0rE0HQ',
    appId: '1:661147584225:web:58828e47462f74441759a0',
    messagingSenderId: '661147584225',
    projectId: 'tododb-5bc38',
    authDomain: 'tododb-5bc38.firebaseapp.com',
    storageBucket: 'tododb-5bc38.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8chy_S3yCm5pS2MG5OuXINiyILeHOdJw',
    appId: '1:661147584225:android:1219e487a30c725a1759a0',
    messagingSenderId: '661147584225',
    projectId: 'tododb-5bc38',
    storageBucket: 'tododb-5bc38.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCS9V-SjVYqy0VPCSyaVopsAWwxSlkBuLc',
    appId: '1:661147584225:ios:32d01138ddd457681759a0',
    messagingSenderId: '661147584225',
    projectId: 'tododb-5bc38',
    storageBucket: 'tododb-5bc38.appspot.com',
    iosBundleId: 'com.example.flutterTodoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCS9V-SjVYqy0VPCSyaVopsAWwxSlkBuLc',
    appId: '1:661147584225:ios:e19812e8905126dd1759a0',
    messagingSenderId: '661147584225',
    projectId: 'tododb-5bc38',
    storageBucket: 'tododb-5bc38.appspot.com',
    iosBundleId: 'com.example.flutterTodoApp.RunnerTests',
  );
}
