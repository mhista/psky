
import 'package:ahiaa_web/features/notifications/data/data_source/notification_datasource.dart';
import 'package:ahiaa_web/features/notifications/domain/repositoy/notification_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource _dataSource;

  NotificationRepositoryImpl(this._dataSource);

  @override
  Future<List<ExamNotification>> getNotifications({
    required String userId,
    int limit = 50,
    bool unreadOnly = false,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      return await _dataSource.getUserNotifications(
        userId: userId,
        limit: limit,
        unreadOnly: unreadOnly,
        startAfter: startAfter,
      );
    } catch (e) {
      print('Repository error getting notifications: $e');
      rethrow;
    }
  }

  @override
  Future<int> getUnreadCount(String userId) async {
    try {
      return await _dataSource.getUnreadCount(userId);
    } catch (e) {
      print('Repository error getting unread count: $e');
      return 0;
    }
  }

  @override
  Future<void> markAsRead(String userId, String notificationId) async {
    try {
      await _dataSource.markAsRead(userId, notificationId);
    } catch (e) {
      print('Repository error marking as read: $e');
      rethrow;
    }
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    try {
      await _dataSource.markAllAsRead(userId);
    } catch (e) {
      print('Repository error marking all as read: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteNotification(String userId, String notificationId) async {
    try {
      await _dataSource.deleteNotification(userId, notificationId);
    } catch (e) {
      print('Repository error deleting notification: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteAllNotifications(String userId) async {
    try {
      await _dataSource.deleteAllNotifications(userId);
    } catch (e) {
      print('Repository error deleting all notifications: $e');
      rethrow;
    }
  }

  @override
  Future<void> saveNotification(ExamNotification notification) async {
    try {
      await _dataSource.saveNotification(notification);
    } catch (e) {
      print('Repository error saving notification: $e');
      rethrow;
    }
  }

  @override
  Future<ExamNotification?> getNotificationById(
    String userId,
    String notificationId,
  ) async {
    try {
      return await _dataSource.getNotificationById(userId, notificationId);
    } catch (e) {
      print('Repository error getting notification by ID: $e');
      return null;
    }
  }

  @override
  Stream<List<ExamNotification>> watchNotifications(String userId) {
    return _dataSource.watchUserNotifications(userId);
  }
}
