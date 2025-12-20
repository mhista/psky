// update_profile_usecase.dart
import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateProfileUseCase {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

  ResultFuture<UserEntity> call({
    required String userId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? school,
    String? gender,
    DateTime? dob,
    String? bio,
    String? email,
    List<String>? examBody,
    bool? hasOnboarded,
    List<String>? subjects,
  }) {
    return repository.updateUserProfile(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      gender: gender,
      school: school,
      dob: dob,
      examBody: examBody,
      bio: bio,
      email: email,
      hasOnboarded: hasOnboarded,
      subjects: subjects,
    );
  }
}
