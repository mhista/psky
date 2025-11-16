// sign_in_with_google_usecase.dart
import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInWithGoogleUseCase {
  final AuthRepository repository;

  SignInWithGoogleUseCase({required this.repository});

  ResultFuture<UserEntity?> call() {
    return repository.signInWithGoogle();
  }
}