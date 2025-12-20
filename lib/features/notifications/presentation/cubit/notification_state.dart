part of 'notification_cubit.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;
  
  const factory NotificationState.loading() = _Loading;
  
  const factory NotificationState.loaded({
    required List<ExamNotification> notifications,
    required int unreadCount,
    @Default(false) bool hasMore,
    DocumentSnapshot? lastDocument,
  }) = _Loaded;
  
  const factory NotificationState.error({
    required String message,
  }) = _Error;
}
