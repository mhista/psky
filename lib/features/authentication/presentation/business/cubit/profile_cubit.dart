// PROFILE CUBIT - Separate from Authentication
// lib/features/personalization/presentation/cubit/profile_cubit.dart
// ============================================================================

import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/authentication/domain/usecases/update_email_usecase.dart';
import 'package:ahiaa_web/features/authentication/domain/usecases/update_password_usecase.dart';
import 'package:ahiaa_web/features/authentication/domain/usecases/update_profile_pic_usecase.dart';
import 'package:ahiaa_web/features/authentication/domain/usecases/update_profile_usecase.dart';
import 'package:ahiaa_web/features/authentication/domain/usecases/upload_profile_pics_usecase.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;
  final UploadProfilePictureUseCase uploadProfilePictureUseCase;
  final UpdateProfilePictureUseCase updateProfilePictureUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final UpdateEmailUseCase updateEmailUseCase;
  final ImagePicker imagePicker;

  ProfileCubit({
    required this.updateProfileUseCase,
    required this.uploadProfilePictureUseCase,
    required this.updateProfilePictureUseCase,
    required this.updatePasswordUseCase,
    required this.updateEmailUseCase,
    required this.imagePicker,
  }) : super(const ProfileState.initial());

  // ============================================================================
  // IMAGE PICKER METHODS
  // ============================================================================

  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        debugPrint('Image selected from gallery: ${image.path}');
      }

      return image;
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
      emit(ProfileState.error('Failed to pick image from gallery: $e'));
      return null;
    }
  }

  Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        debugPrint('Image captured from camera: ${image.path}');
      }

      return image;
    } catch (e) {
      debugPrint('Error capturing image from camera: $e');
      emit(ProfileState.error('Failed to capture image from camera: $e'));
      return null;
    }
  }

  // ============================================================================
  // PROFILE UPDATE METHODS
  // ============================================================================

  /// Update user profile information
  Future<void> updateProfile(
      {required String userId,
      String? firstName,
      String? lastName,
      String? phoneNumber,
      String? school,
      String? gender,
      DateTime? dob,
      String? bio,
      String? email,
      List<String>? examBody,
      bool? hasOnboarded,
      List<String>? subjects}) async {
    emit(const ProfileState.loading());

    final result = await updateProfileUseCase(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        gender: gender,
        school: school,
        dob: dob,
        examBody: examBody,
        hasOnboarded: hasOnboarded,
        bio: bio,
        email: email,
        subjects: subjects);

    result.fold(
      (error) => emit(ProfileState.error(error)),
      (updatedUser) async {
        // Update UserCubit with new user data
        pskyLog(updatedUser);
        await getIt<UserCubit>()
            .updateUser(updatedUser)
            .then((e) => emit(ProfileState.profileUpdated(updatedUser)));

        // Reset to initial after success (optional)
        Future.delayed(const Duration(seconds: 2), () {
          if (!isClosed) emit(const ProfileState.initial());
        });
      },
    );
  }

  /// Complete flow: Pick, upload, and update profile picture
  Future<void> updateProfilePictureFlow({
    required String userId,
    required ImageSource source,
    Function(double)? onProgress,
  }) async {
    try {
      // Step 1: Pick image
      final XFile? imageFile;
      if (source == ImageSource.gallery) {
        imageFile = await pickImageFromGallery();
      } else {
        imageFile = await pickImageFromCamera();
      }

      if (imageFile == null) {
        emit(const ProfileState.error('No image selected'));
        return;
      }

      emit(const ProfileState.uploadingImage());

      // Step 2: Upload image
      final uploadResult = await uploadProfilePictureUseCase(
        userId: userId,
        imageFile: imageFile,
        onProgress: onProgress,
      );

      await uploadResult.fold(
        (error) async {
          pskyLog(error);
          emit(ProfileState.error(error));
        },
        (imageUrl) async {
          // Step 3: Update profile picture URL
          pskyLog(imageUrl);

          final updateResult = await updateProfilePictureUseCase(
            userId: userId,
            imageUrl: imageUrl,
          );

          updateResult.fold(
            (error) => emit(ProfileState.error(error)),
            (updatedUser) {
              // Update UserCubit with new user data
              getIt<UserCubit>().updateUser(updatedUser);
              emit(ProfileState.profilePictureUpdated(updatedUser, imageUrl));

              // Reset to initial after success
              Future.delayed(const Duration(seconds: 2), () {
                if (!isClosed) emit(const ProfileState.initial());
              });
            },
          );
        },
      );
    } catch (e) {
      emit(ProfileState.error(e.toString()));
    }
  }

  /// Update password (requires current password)
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(const ProfileState.loading());

    final result = await updatePasswordUseCase(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    result.fold(
      (error) => emit(ProfileState.error(error)),
      (_) {
        emit(const ProfileState.passwordUpdated());

        // Reset to initial after success
        Future.delayed(const Duration(seconds: 2), () {
          if (!isClosed) emit(const ProfileState.initial());
        });
      },
    );
  }

  /// Update email (requires password and sends verification)
  Future<void> updateEmail({
    required String newEmail,
    required String password,
  }) async {
    emit(const ProfileState.loading());

    final result = await updateEmailUseCase(
      newEmail: newEmail,
      password: password,
    );

    result.fold(
      (error) => emit(ProfileState.error(error)),
      (_) {
        emit(ProfileState.emailUpdated(newEmail));

        // Reset to initial after success
        Future.delayed(const Duration(seconds: 2), () {
          if (!isClosed) emit(const ProfileState.initial());
        });
      },
    );
  }

  /// Reset state to initial (useful after showing success messages)
  void resetState() {
    emit(const ProfileState.initial());
  }
}
