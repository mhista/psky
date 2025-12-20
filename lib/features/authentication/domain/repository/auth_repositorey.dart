import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class AuthRepository {
  ResultFuture<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });

  ResultFuture<UserEntity> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  ResultFuture<UserEntity?> getCurrentUserData();

  ResultFuture<UserEntity?> signInWithGoogle();

  ResultVoid sendEmailVerification();

  ResultVoid sendPasswordResetEmail(String email);

  ResultVoid reAuthenticateWithEmailAndPassword({
    required String email,
    required String password,
  });

  ResultVoid deleteAccount();

  ResultVoid logout();
  ResultFuture<UserEntity> updateUserProfile(
      {required String userId,
      String? firstName,
      String? lastName,
      String? gender,
      String? phoneNumber,
      String? school,
      DateTime? dob,
      List<String>? examBody,
      String? bio,
      String? email,
      List<String>? subjects,
      bool? hasOnboarded});

  ResultFuture<String> uploadProfilePicture({
    required String userId,
    required XFile imageFile,
    Function(double)? onProgress,
  });

  ResultFuture<UserEntity> updateProfilePicture({
    required String userId,
    required String imageUrl,
  });

  // NEW: Password & Email Management
  ResultVoid updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  ResultVoid updateEmail({
    required String newEmail,
    required String password,
  });
}
