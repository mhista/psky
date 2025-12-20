// update_profile_picture_usecase.dart
import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateProfilePictureUseCase {
  final AuthRepository repository;

  UpdateProfilePictureUseCase(this.repository);

  ResultFuture<UserEntity> call({
    required String userId,
    required String imageUrl,
  }) {
    return repository.updateProfilePicture(
      userId: userId,
      imageUrl: imageUrl,
    );
  }
}