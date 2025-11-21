import 'dart:async';

import 'package:ahiaa_web/core/cubits/cubit/initialization_cubit.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/local_storage/storage_utility.dart';
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

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
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
    // Delay subscription until after current event loop completes
    // This ensures Flutter's binding is fully initialized
    Future.microtask(() {
      _sub = firebaseAuth.authStateChanges().listen(_mapUserToState);
    });
  }

  void _mapUserToState(User? user) async {
    if (user == null) {
      emit(const AuthState.unauthenticated());
    } else {
      await getCurrentUser();
      final currenState = state;

      if (currenState is! _Authenticated) return;
      final initCubit = getIt<InitializationCubit>();
      // await localStorageService.setUser(currenState.user.id);
      await initCubit.initialize(userId: currenState.user.id, quickStart: true);
    }
  }

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
      (user) => emit(AuthState.authenticated(user)),
    );
  }

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
        print(error);
        emit(AuthState.error(error));
      },
      (user) {
        getIt<UserCubit>().loggedIn(user);
        emit(AuthState.authenticated(user));
      },
    );
  }

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

  Future<void> signInWithGoogle() async {
    emit(const AuthState.loading());
    final result = await signInWithGoogleUseCase();
    result.fold(
      (error) => emit(AuthState.error(error)),
      (user) {
        if (user != null) {
          emit(AuthState.authenticated(user));
        } else {
          emit(const AuthState.error('Google sign in failed'));
        }
      },
    );
  }

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

  Future<void> sendPasswordResetEmail(String email) async {
    emit(const AuthState.loading());
    final result = await sendPasswordResetEmailUseCase(email);
    result.fold(
      (error) => emit(AuthState.error(error)),
      (_) => emit(const AuthState.initial()),
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
