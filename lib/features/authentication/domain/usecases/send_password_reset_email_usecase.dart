// send_password_reset_email_usecase.dart
import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendPasswordResetEmailUseCase {
  final AuthRepository repository;

  SendPasswordResetEmailUseCase({required this.repository});

  ResultVoid call(String email) {
    return repository.sendPasswordResetEmail(email);
  }
}