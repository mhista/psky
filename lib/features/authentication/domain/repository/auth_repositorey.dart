
import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';

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
}
