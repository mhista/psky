// ============================================================================
// NOTIFICATION DATA SOURCE
// lib/features/notifications/data/datasources/notification_datasource.dart
// ============================================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationDataSource {
  /// Get user notifications with pagination
  Future<List<ExamNotification>> getUserNotifications({
    required String userId,
    int limit = 50,
    bool unreadOnly = false,
    DocumentSnapshot? startAfter,
  });

  /// Get unread notification count
  Future<int> getUnreadCount(String userId);

  /// Mark notification as read
  Future<void> markAsRead(String userId, String notificationId);

  /// Mark all notifications as read
  Future<void> markAllAsRead(String userId);

  /// Delete notification
  Future<void> deleteNotification(String userId, String notificationId);

  /// Delete all notifications
  Future<void> deleteAllNotifications(String userId);

  /// Save notification
  Future<void> saveNotification(ExamNotification notification);

  /// Get notification by ID
  Future<ExamNotification?> getNotificationById(String userId, String notificationId);

  /// Listen to notification changes (real-time)
  Stream<List<ExamNotification>> watchUserNotifications(String userId);
}

@LazySingleton(as: NotificationDataSource)
class FirebaseNotificationDataSource implements NotificationDataSource {
  final FirebaseFirestore _firestore;
  static const String _userNotificationsCollection = 'user_notifications';

  FirebaseNotificationDataSource(this._firestore);

  @override
  Future<List<ExamNotification>> getUserNotifications({
    required String userId,
    int limit = 50,
    bool unreadOnly = false,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      Query query = _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsCollection)
          .orderBy('createdAt', descending: true);

      if (unreadOnly) {
        query = query.where('isRead', isEqualTo: false);
      }

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      query = query.limit(limit);

      final snapshot = await query.get();

      return snapshot.docs
          .map((doc) => ExamNotification.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting user notifications: $e');
      throw Exception('Failed to fetch notifications: $e');
    }
  }

  @override
  Future<int> getUnreadCount(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsCollection)
          .where('isRead', isEqualTo: false)
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      print('Error getting unread count: $e');
      return 0;
    }
  }

  @override
  Future<void> markAsRead(String userId, String notificationId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsCollection)
          .doc(notificationId)
          .update({
        'isRead': true,
        'readAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error marking notification as read: $e');
      throw Exception('Failed to mark as read: $e');
    }
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    try {
      final batch = _firestore.batch();

      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsCollection)
          .where('isRead', isEqualTo: false)
          .get();

      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {
          'isRead': true,
          'readAt': FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
    } catch (e) {
      print('Error marking all as read: $e');
      throw Exception('Failed to mark all as read: $e');
    }
  }

  @override
  Future<void> deleteNotification(String userId, String notificationId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsCollection)
          .doc(notificationId)
          .delete();
    } catch (e) {
      print('Error deleting notification: $e');
      throw Exception('Failed to delete notification: $e');
    }
  }

  @override
  Future<void> deleteAllNotifications(String userId) async {
    try {
      final batch = _firestore.batch();

      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsCollection)
          .get();

      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      print('Error deleting all notifications: $e');
      throw Exception('Failed to delete all notifications: $e');
    }
  }

  @override
  Future<void> saveNotification(ExamNotification notification) async {
    try {
      await _firestore
          .collection('users')
          .doc(notification.userId)
          .collection(_userNotificationsCollection)
          .doc(notification.id)
          .set(notification.toJson());
    } catch (e) {
      print('Error saving notification: $e');
      throw Exception('Failed to save notification: $e');
    }
  }

  @override
  Future<ExamNotification?> getNotificationById(
    String userId,
    String notificationId,
  ) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsCollection)
          .doc(notificationId)
          .get();

      if (!doc.exists) return null;

      return ExamNotification.fromJson(doc.data()!);
    } catch (e) {
      print('Error getting notification by ID: $e');
      return null;
    }
  }

  @override
  Stream<List<ExamNotification>> watchUserNotifications(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection(_userNotificationsCollection)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ExamNotification.fromJson(doc.data()))
          .toList();
    });
  }
}
