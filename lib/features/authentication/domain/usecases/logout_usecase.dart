
// logout_usecase.dart
import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  ResultVoid call() {
    return repository.logout();
  }
}
