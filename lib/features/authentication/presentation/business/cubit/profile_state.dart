
// ============================================================================
// PROFILE STATE
// ============================================================================

part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.uploadingImage() = _UploadingImage;
  const factory ProfileState.profileUpdated(UserEntity user) = _ProfileUpdated;
  const factory ProfileState.profilePictureUpdated(UserEntity user, String imageUrl) = _ProfilePictureUpdated;
  const factory ProfileState.passwordUpdated() = _PasswordUpdated;
  const factory ProfileState.emailUpdated(String newEmail) = _EmailUpdated;
  const factory ProfileState.error(String message) = _Error;
}