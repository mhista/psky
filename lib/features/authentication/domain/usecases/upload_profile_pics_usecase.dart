
// upload_profile_picture_usecase.dart
import 'package:ahiaa_web/core/utils/type_def.dart';
import 'package:ahiaa_web/features/authentication/domain/repository/auth_repositorey.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UploadProfilePictureUseCase {
  final AuthRepository repository;

  UploadProfilePictureUseCase(this.repository);

  ResultFuture<String> call({
    required String userId,
    required XFile imageFile,
    Function(double)? onProgress,
  }) {
    return repository.uploadProfilePicture(
      userId: userId,
      imageFile: imageFile,
      onProgress: onProgress,
    );
  }
}