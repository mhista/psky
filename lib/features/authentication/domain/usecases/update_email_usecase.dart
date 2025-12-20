
// update_email_usecase.dart
import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateEmailUseCase {
  final AuthRepository repository;

  UpdateEmailUseCase(this.repository);

  ResultVoid call({
    required String newEmail,
    required String password,
  }) {
    return repository.updateEmail(
      newEmail: newEmail,
      password: password,
    );
  }
}
