// sign_up_usecase.dart

import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  ResultFuture<UserEntity> call({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async{
    return await repository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );
  }
}
