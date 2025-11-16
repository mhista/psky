// ============================================
// 4. REPOSITORY IMPLEMENTATION (auth_repository_impl.dart)
// ============================================


import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      final result = await remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ResultFuture<UserEntity> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ResultFuture<UserEntity?> getCurrentUserData() async {
    try {
      final result = await remoteDataSource.getCurrentUserData();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ResultFuture<UserEntity?> signInWithGoogle() async {
    try {
      final result = await remoteDataSource.signInWithGoogle();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ResultVoid sendEmailVerification() async {
    try {
      await remoteDataSource.sendEmailVerification();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ResultVoid sendPasswordResetEmail(String email) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ResultVoid reAuthenticateWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await remoteDataSource.reAuthenticateWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ResultVoid deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ResultVoid logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}