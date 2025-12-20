
// update_password_usecase.dart
import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdatePasswordUseCase {
  final AuthRepository repository;

  UpdatePasswordUseCase(this.repository);

  ResultVoid call({
    required String currentPassword,
    required String newPassword,
  }) {
    return repository.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
