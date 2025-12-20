import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';


@module
abstract class FirebaseInjectableModuleSimple {
  @lazySingleton
  FirebaseAuth get firebaseAuth {
    // This will work because Firebase is initialized in configureDependencies first
    return FirebaseAuth.instance;
  }

  @lazySingleton
  FirebaseFirestore get firestore {
    return FirebaseFirestore.instance;
  }

  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn();

  @lazySingleton
  FirebaseMessaging get messaging => FirebaseMessaging.instance;

   @lazySingleton
  FirebaseStorage get storage => FirebaseStorage.instance; // NEW

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();
  
  @lazySingleton
  FlutterLocalNotificationsPlugin get localNotifications => 
      FlutterLocalNotificationsPlugin();
  
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
