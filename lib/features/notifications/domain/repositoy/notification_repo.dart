
// ============================================================================
// NOTIFICATION REPOSITORY
// lib/features/notifications/domain/repositories/notification_repository.dart
// ============================================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationRepository {
  Future<List<ExamNotification>> getNotifications({
    required String userId,
    int limit = 50,
    bool unreadOnly = false,
    DocumentSnapshot? startAfter,
  });

  Future<int> getUnreadCount(String userId);
  Future<void> markAsRead(String userId, String notificationId);
  Future<void> markAllAsRead(String userId);
  Future<void> deleteNotification(String userId, String notificationId);
  Future<void> deleteAllNotifications(String userId);
  Future<void> saveNotification(ExamNotification notification);
  Future<ExamNotification?> getNotificationById(String userId, String notificationId);
  Stream<List<ExamNotification>> watchNotifications(String userId);
}
