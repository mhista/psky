// ============================================================================
// STREAMLINED AUTH CUBIT - Authentication Only
// lib/features/authentication/presentation/cubit/auth_cubit.dart
// ============================================================================

import 'dart:async';
import 'package:ahiaa_web/core/cubits/cubit/initialization_cubit.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/local_storage/storage_utility.dart';
import 'package:ahiaa_web/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:ahiaa_web/features/authentication/domain/usecases/login_usecase.dart';
import 'package:ahiaa_web/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:ahiaa_web/features/authentication/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:ahiaa_web/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:ahiaa_web/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  // Authentication-only dependencies
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final LogoutUseCase logoutUseCase;
  final SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase;
  final FirebaseAuth firebaseAuth;
  final LocalStorageService localStorageService;

  StreamSubscription<User?>? _sub;

  AuthCubit({
    required this.signUpUseCase,
    required this.loginUseCase,
    required this.getCurrentUserUseCase,
    required this.signInWithGoogleUseCase,
    required this.logoutUseCase,
    required this.sendPasswordResetEmailUseCase,
    required this.firebaseAuth,
    required this.localStorageService,
  }) : super(const AuthState.initial()) {
    Future.microtask(() {
      _sub = firebaseAuth.authStateChanges().listen(_mapUserToState);
    });
  }

  // ============================================================================
  // FIREBASE AUTH STATE LISTENER
  // ============================================================================

  void _mapUserToState(User? user) async {
    if (user == null) {
      emit(const AuthState.unauthenticated());
    } else {
      await getCurrentUser();
      final currentState = state;

      if (currentState is! _Authenticated) return;

      final initCubit = getIt<InitializationCubit>();
      await initCubit.initialize(
        userId: currentState.user.id,
        quickStart: true,
      );
    }
  }

  // ============================================================================
  // AUTHENTICATION METHODS
  // ============================================================================

  /// Sign up with email and password
  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    emit(const AuthState.loading());

    final result = await signUpUseCase(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );

    result.fold(
      (error) => emit(AuthState.error(error)),
      (user) {
        getIt<UserCubit>().loggedIn(user);
        emit(AuthState.authenticated(user));
      },
    );
  }

  /// Login with email and password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());

    final result = await loginUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (error) {
        debugPrint('Login error: $error');
        emit(AuthState.error(error));
      },
      (user) {
        getIt<UserCubit>().loggedIn(user);
        emit(AuthState.authenticated(user));
      },
    );
  }

  /// Get current authenticated user
  Future<void> getCurrentUser() async {
    emit(const AuthState.loading());

    final result = await getCurrentUserUseCase();

    result.fold(
      (error) => emit(AuthState.error(error)),
      (user) {
        if (user != null) {
          getIt<UserCubit>().loggedIn(user);
          emit(AuthState.authenticated(user));
        } else {
          getIt<UserCubit>().loggedOut();
          emit(const AuthState.unauthenticated());
        }
      },
    );
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    emit(const AuthState.loading());

    final result = await signInWithGoogleUseCase();

    result.fold(
      (error) => emit(AuthState.error(error)),
      (user) {
        if (user != null) {
          getIt<UserCubit>().loggedIn(user);
          emit(AuthState.authenticated(user));
        } else {
          emit(const AuthState.error('Google sign in failed'));
        }
      },
    );
  }

  /// Logout
  Future<void> logout() async {
    emit(const AuthState.loading());

    await localStorageService.clearUser();

    final result = await logoutUseCase();

    result.fold(
      (error) => emit(AuthState.error(error)),
      (_) {
        getIt<UserCubit>().loggedOut();
        emit(const AuthState.unauthenticated());
      },
    );
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    emit(const AuthState.loading());

    final result = await sendPasswordResetEmailUseCase(email);

    result.fold(
      (error) => emit(AuthState.error(error)),
      (_) => emit(const AuthState.passwordResetSent()),
    );
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Get current authenticated user
  UserEntity? get currentUser {
    final currentState = state;
    if (currentState is _Authenticated) {
      return currentState.user;
    }
    return null;
  }

  /// Check if user is authenticated
  bool get isAuthenticated {
    return state is _Authenticated;
  }

  /// Get current user ID
  String? get currentUserId {
    return currentUser?.id;
  }

  /// Refresh current user data (without changing state)
  /// This is useful when profile is updated via ProfileCubit
  Future<void> refreshUserData() async {
    if (!isAuthenticated) return;

    final result = await getCurrentUserUseCase();

    result.fold(
      (error) => debugPrint('Failed to refresh user data: $error'),
      (user) {
        if (user != null) {
          getIt<UserCubit>().loggedIn(user);
          // Update state without triggering navigation
          emit(AuthState.authenticated(user));
        }
      },
    );
  }

  // delete account
  Future<void> deleteAccount() async {
    emit(const AuthState.loading());
    await getIt<AuthRepositoryImpl>().deleteAccount();
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
