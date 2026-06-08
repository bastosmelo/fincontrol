// firebase_options.dart
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
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAajbmaMslXI2-xjSq629xsnnHYgZpY1-c',
    appId: '1:436165991382:web:5c034bdb2328b013772277',
    messagingSenderId: '436165991382',
    projectId: 'fincontrol-unit',
    authDomain: 'fincontrol-unit.firebaseapp.com',
    storageBucket: 'fincontrol-unit.firebasestorage.app',
    measurementId: 'G-9WQ8M1SG2L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAajbmaMslXI2-xjSq629xsnnHYgZpY1-c',
    appId: '1:436165991382:android:5c034bdb2328b013772277',
    messagingSenderId: '436165991382',
    projectId: 'fincontrol-unit',
    storageBucket: 'fincontrol-unit.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAajbmaMslXI2-xjSq629xsnnHYgZpY1-c',
    appId: '1:436165991382:ios:5c034bdb2328b013772277',
    messagingSenderId: '436165991382',
    projectId: 'fincontrol-unit',
    storageBucket: 'fincontrol-unit.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAajbmaMslXI2-xjSq629xsnnHYgZpY1-c',
    appId: '1:436165991382:ios:5c034bdb2328b013772277',
    messagingSenderId: '436165991382',
    projectId: 'fincontrol-unit',
    storageBucket: 'fincontrol-unit.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAajbmaMslXI2-xjSq629xsnnHYgZpY1-c',
    appId: '1:436165991382:web:5c034bdb2328b013772277',
    messagingSenderId: '436165991382',
    projectId: 'fincontrol-unit',
    authDomain: 'fincontrol-unit.firebaseapp.com',
    storageBucket: 'fincontrol-unit.firebasestorage.app',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyAajbmaMslXI2-xjSq629xsnnHYgZpY1-c',
    appId: '1:436165991382:web:5c034bdb2328b013772277',
    messagingSenderId: '436165991382',
    projectId: 'fincontrol-unit',
    authDomain: 'fincontrol-unit.firebaseapp.com',
    storageBucket: 'fincontrol-unit.firebasestorage.app',
  );
}