// ============================================================================
// ENHANCED AUTH REMOTE DATA SOURCE WITH PROFILE MANAGEMENT
// ============================================================================

import 'dart:async';
import 'dart:io';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:ahiaa_web/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ahiaa_web/core/utils/exceptions/format_eceptions.dart';
import 'package:ahiaa_web/core/utils/exceptions/platform_exceptions.dart';
import 'package:ahiaa_web/features/authentication/data/models/user_model.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;

abstract interface class AuthRemoteDataSource {
  User? get currentUser;

  // Existing methods
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });

  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
  Future<UserModel?> signInWithGoogle();
  Future<UserModel?> createNewProfile(UserModel userModel);
  Future<void> sendEmailVerification();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> reAuthenticateWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> deleteAccount();
  Future<void> logout();

  // NEW: Profile Management Methods
  Future<UserModel> updateUserProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? school,
    String? gender,
    DateTime? dob,
    List<String>? examBody,
    String? bio,
    String? email,
    bool? hasOnboarded,
    List<String>? subjects,
  });

  Future<String> uploadProfilePicture({
    required String userId,
    required XFile imageFile,
    Function(double)? onProgress,
  });

  Future<UserModel> updateProfilePicture({
    required String userId,
    required String imageUrl,
  });

  // NEW: Password Management
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> updateEmail({
    required String newEmail,
    required String password,
  });
}

// ============================================================================
// FIREBASE IMPLEMENTATION
// ============================================================================

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceFirebaseImp implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  AuthRemoteDataSourceFirebaseImp({
    required this.firebaseAuth,
    required this.firestore,
    required this.storage,
  });

  @override
  User? get currentUser => firebaseAuth.currentUser;

  // ============================================================================
  // EXISTING AUTHENTICATION METHODS
  // ============================================================================

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

      final userModel = UserModel(
        id: userCredential.user!.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: '',
        profilePicture: '',
        school: '',
        dob: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        examBody: [],
      );

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
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
    bool rememberMe = true,
  }) async {
    try {
      await firebaseAuth.setPersistence(
        rememberMe ? Persistence.LOCAL : Persistence.SESSION,
      );

      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw 'Unable to login, try again later';
      }

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
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw 'Google sign in was cancelled';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw 'Unable to login, try again later';
      }

      final user = userCredential.user!;
      final userDoc = await firestore.collection('users').doc(user.uid).get();

      UserModel userModel;

      if (!userDoc.exists) {
        final nameParts = user.displayName?.split(' ') ?? ['', ''];
        userModel = UserModel(
          id: user.uid,
          email: user.email ?? '',
          firstName: nameParts.isNotEmpty ? nameParts[0] : '',
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          phoneNumber: user.phoneNumber ?? '',
          profilePicture: user.photoURL ?? '',
          school: '',
          dob: DateTime.now(),
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
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

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

        // Delete profile picture from Storage
        try {
          await storage
              .ref()
              .child('profile_pictures/${currentUser!.uid}')
              .delete();
        } catch (e) {
          debugPrint('No profile picture to delete or error: $e');
        }

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

  // ============================================================================
  // NEW: PROFILE MANAGEMENT METHODS
  // ============================================================================

  @override
  Future<UserModel> updateUserProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? school,
    String? gender,
    DateTime? dob,
    List<String>? examBody,
    String? bio,
    String? email,
    bool? hasOnboarded,
    List<String>? subjects
  }) async {
    try {
      // Get current user data
      final currentData = getIt<UserCubit>().currentUser;

      if (currentData == null) {
        throw 'User data not found';
      }

      // Create updated model with only changed fields
      final updatedModel = UserModel(
        id: userId,
        email: email ?? currentData.email,
        firstName: firstName ?? currentData.firstName,
        lastName: lastName ?? currentData.lastName,
        gender: gender ?? currentData.gender,
        phoneNumber: phoneNumber ?? currentData.phoneNumber,
        profilePicture: currentData.profilePicture,
        school: school ?? currentData.school,
        dob: dob ?? currentData.dob,
        createdAt: currentData.createdAt,
        updatedAt: DateTime.now(),
        examBody: examBody ?? currentData.examBody,
        bio: bio ?? currentData.bio,
        hasOnboarded: hasOnboarded ?? currentData.hasOnboarded,
        subjects: subjects ?? currentData.subjects,
      );

      // Update in Firestore
      await firestore
          .collection('users')
          .doc(userId)
          .update(updatedModel.toMap());

      debugPrint('Profile updated successfully');
      return updatedModel;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to update profile: $e';
    }
  }

  @override
  Future<String> uploadProfilePicture({
    required String userId,
    required XFile imageFile,
    Function(double)? onProgress,
  }) async {
    try {
      debugPrint('Starting upload for user: $userId');

      // Create reference
      final ref = storage.ref().child(
          'profile_pictures/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask;

      if (kIsWeb) {
        // Web upload
        final bytes = await imageFile.readAsBytes();
        uploadTask = ref.putData(
          bytes,
          SettableMetadata(contentType: 'image/jpeg'),
        );
      } else {
        // Mobile upload
        final file = File(imageFile.path);
        uploadTask = ref.putFile(
          file,
          SettableMetadata(contentType: 'image/jpeg'),
        );
      }

      // Monitor progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress?.call(progress);
        debugPrint('Upload progress: ${(progress * 100).toStringAsFixed(2)}%');
      });

      // Wait for completion
      final snapshot = await uploadTask;

      if (snapshot.state != TaskState.success) {
        throw 'Upload failed';
      }

      // Get download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint('Upload complete. URL: $downloadUrl');
      return downloadUrl;
    } on FirebaseException catch (e) {
      debugPrint('Firebase error: ${e.message}');
      throw KFirebaseException(e.code).message;
    } catch (e) {
      debugPrint('Upload error: $e');
      throw 'Failed to upload image: $e';
    }
  }

  @override
  Future<UserModel> updateProfilePicture({
    required String userId,
    required String imageUrl,
  }) async {
    try {
      // Get current user data
      final currentData = await getCurrentUserData();

      if (currentData == null) {
        throw 'User data not found';
      }

      // Update profile picture URL
      await firestore.collection('users').doc(userId).update({
        'profilePicture': imageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Return updated model
      final updatedModel = currentData.copyWith(
        profilePicture: imageUrl,
        updatedAt: DateTime.now(),
      );

      debugPrint('Profile picture updated successfully');
      return updatedModel;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to update profile picture: $e';
    }
  }

  // ============================================================================
  // NEW: PASSWORD & EMAIL MANAGEMENT
  // ============================================================================

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      if (currentUser == null) {
        throw 'No user is currently signed in';
      }

      // Re-authenticate first
      final credential = EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: currentPassword,
      );

      await currentUser!.reauthenticateWithCredential(credential);

      // Update password
      await currentUser!.updatePassword(newPassword);

      debugPrint('Password updated successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw 'Current password is incorrect';
      } else if (e.code == 'weak-password') {
        throw 'New password is too weak';
      }
      throw KFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Failed to update password: $e';
    }
  }

  @override
  Future<void> updateEmail({
    required String newEmail,
    required String password,
  }) async {
    try {
      if (currentUser == null) {
        throw 'No user is currently signed in';
      }

      // Re-authenticate first
      final credential = EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: password,
      );

      await currentUser!.reauthenticateWithCredential(credential);

      // Update email
      await currentUser!.verifyBeforeUpdateEmail(newEmail);

      // Update in Firestore
      await firestore.collection('users').doc(currentUser!.uid).update({
        'email': newEmail,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Send verification email to new address
      await currentUser!.sendEmailVerification();

      debugPrint('Email updated successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw 'Password is incorrect';
      } else if (e.code == 'email-already-in-use') {
        throw 'This email is already in use';
      } else if (e.code == 'invalid-email') {
        throw 'Invalid email address';
      }
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to update email: $e';
    }
  }
}
