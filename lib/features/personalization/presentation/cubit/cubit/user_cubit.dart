// ============================================================================
// ENHANCED USER CUBIT - Manages User Profile State
// lib/features/personalization/presentation/cubit/user_cubit.dart
// ============================================================================

import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

@lazySingleton
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState.initial());

  // ============================================================================
  // USER STATE MANAGEMENT
  // ============================================================================

  /// Called when user logs in
  void loggedIn(UserEntity user) {
    emit(UserState.hasUser(user));
  }

  /// Called when user logs out
  void loggedOut() {
    emit(const UserState.initial());
  }

  /// Update user profile (called by ProfileCubit after successful update)
  Future<void> updateUser(UserEntity updatedUser) async{
    emit(UserState.hasUser(updatedUser));
  }

  /// Update specific user fields without full user object
  void updateUserFields({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profilePicture,
    String? school,
    String? gender,
    DateTime? dob,
    List<String>? examBody,
    String? bio,
    String? email,
    bool? hasOnboarded,
  }) {
    final currentState = state;

    if (currentState is _LoggedIn) {
      final currentUser = currentState.user;

      final updatedUser = UserEntity(
        id: currentUser.id,
        hasOnboarded: hasOnboarded ?? currentUser.hasOnboarded,
        email: email ?? currentUser.email,
        firstName: firstName ?? currentUser.firstName,
        lastName: lastName ?? currentUser.lastName,
        phoneNumber: phoneNumber ?? currentUser.phoneNumber,
        profilePicture: profilePicture ?? currentUser.profilePicture,
        school: school ?? currentUser.school,
        gender: gender ?? currentUser.gender,
        dob: dob ?? currentUser.dob,
        examBody: examBody ?? currentUser.examBody,
        bio: bio ?? currentUser.bio,
        createdAt: currentUser.createdAt,
        subjects: currentUser.subjects,
        updatedAt: DateTime.now(),
      );

      emit(UserState.hasUser(updatedUser));
    }
  }

  /// Update profile picture URL
  void updateProfilePicture(String imageUrl) {
    final currentState = state;

    if (currentState is _LoggedIn) {
      updateUserFields(profilePicture: imageUrl);
    }
  }

  // ============================================================================
  // GETTERS
  // ============================================================================

  /// Get current user
  UserEntity? get currentUser {
    final currentState = state;
    if (currentState is _LoggedIn) {
      return currentState.user;
    }
    return null;
  }

  /// Get current user ID
  String? get currentUserId {
    return currentUser?.id;
  }

  /// Check if user is hasUser
  bool get isUserhasUser {
    return state is _LoggedIn;
  }

  /// Get user's full name
  String? get fullName {
    final user = currentUser;
    if (user != null) {
      return '${user.firstName} ${user.lastName}'.trim();
    }
    return null;
  }

  /// Get user's initials for avatar
  String get initials {
    final user = currentUser;
    if (user != null) {
      final first = user.firstName.isNotEmpty ? user.firstName[0] : '';
      final last = user.lastName.isNotEmpty ? user.lastName[0] : '';
      return '$first$last'.toUpperCase();
    }
    return 'U';
  }
}
