// login_usecase.dart
import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  ResultFuture<UserEntity> call({
    required String email,
    required String password,
  }) async {
    return await repository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
