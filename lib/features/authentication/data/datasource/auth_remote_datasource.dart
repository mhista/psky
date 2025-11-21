import 'dart:async';

import 'package:ahiaa_web/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:ahiaa_web/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ahiaa_web/core/utils/exceptions/format_eceptions.dart';
import 'package:ahiaa_web/core/utils/exceptions/platform_exceptions.dart';
import 'package:ahiaa_web/features/authentication/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract interface class AuthRemoteDataSource {
  User? get currentUser;

  // Signup with email and password
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });

  // Login with email and password
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  // get the current user
  Future<UserModel?> getCurrentUserData();

  // google signin
  Future<UserModel?> signInWithGoogle();

  // create new profile
  Future<UserModel?> createNewProfile(UserModel userModel);

  // Send email verification
  Future<void> sendEmailVerification();

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email);

  // Reauthenticate user
  Future<void> reAuthenticateWithEmailAndPassword({
    required String email,
    required String password,
  });

  // Delete user account
  Future<void> deleteAccount();

  // Logout
  Future<void> logout();
}

// FIREBASE IMPLEMENTATION
@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceFirebaseImp implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceFirebaseImp({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      debugPrint('$email $password $firstName $lastName $phoneNumber');

      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw 'Unable to create account, try again later';
      }

      // Create user model with additional data
      final userModel = UserModel(
        id: userCredential.user!.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: '',
        profilePicture: '',
        school: '',
        dob: DateTime.now(), // Should be collected from user
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        examBody: [],
      );

      // Save user data to Firestore
      await createNewProfile(userModel);

      return userModel;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  @override
  Future<UserModel> loginWithEmailAndPassword(
      {required String email,
      required String password,
      bool rememberMe = true}) async {
    try {
      await firebaseAuth
          .setPersistence(rememberMe ? Persistence.LOCAL : Persistence.SESSION);

      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw 'Unable to login, try again later';
      }

      // Fetch user data from Firestore
      final userData = await getCurrentUserData();

      if (userData == null) {
        throw 'User data not found';
      }

      return userData;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUser != null) {
        final userData =
            await firestore.collection('users').doc(currentUser!.uid).get();

        if (!userData.exists) {
          return null;
        }

        debugPrint(userData.data().toString());
        return UserModel.fromMap(userData.data()!);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw 'Google sign in was cancelled';
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // Once signed in, get the UserCredential
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw 'Unable to login, try again later';
      }

      final user = userCredential.user!;

      // Check if user profile exists in Firestore
      final userDoc = await firestore.collection('users').doc(user.uid).get();

      UserModel userModel;

      if (!userDoc.exists) {
        // Create new profile for new Google sign-in users
        final nameParts = user.displayName?.split(' ') ?? ['', ''];
        userModel = UserModel(
          id: user.uid,
          email: user.email ?? '',
          firstName: nameParts.isNotEmpty ? nameParts[0] : '',
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          phoneNumber: user.phoneNumber ?? '',
          profilePicture: user.photoURL ?? '',
          school: '',
          dob: DateTime.now(), // Should be collected from user later
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          examBody: [],
        );

        await createNewProfile(userModel);
      } else {
        userModel = UserModel.fromMap(userDoc.data()!);
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  @override
  Future<UserModel?> createNewProfile(UserModel userModel) async {
    try {
      await firestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toMap(), SetOptions(merge: true));

      return userModel;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  @override
  Future<void> reAuthenticateWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Create credentials
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      // Reauthenticate
      await currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      if (currentUser != null) {
        // Delete user data from Firestore
        await firestore.collection('users').doc(currentUser!.uid).delete();

        // Delete the user account
        await currentUser!.delete();
      }
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  @override
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }
}
