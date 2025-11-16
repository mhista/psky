// get_current_user_usecase.dart
import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  ResultFuture<UserEntity?> call() {
    return repository.getCurrentUserData();
  }
}