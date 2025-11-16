// ============================================================================
// EXAM NOTIFICATION SERVICE
// ============================================================================

import 'dart:async';
import 'dart:convert';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

@lazySingleton
class ExamNotificationService {
  final FirebaseFirestore _firestore;
  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final SharedPreferences _prefs;

  static const String _prefsKey = 'notification_prefs';
  static const String _lastNotificationKey = 'last_notification_time';
  static const String _notificationsCollection = 'notifications';

  NotificationPreferences? _cachedPreferences;
  StreamSubscription<RemoteMessage>? _messageSubscription;

  ExamNotificationService(
    this._firestore,
    this._messaging,
    this._localNotifications,
    this._prefs,
  );

  // ============================================================================
  // INITIALIZATION
  // ============================================================================

  /// Initialize the notification service
  Future<void> initialize() async {
    try {
      // Request permissions
      await _requestPermissions();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Setup FCM listeners
      _setupFCMListeners();

      // Load cached preferences
      await _loadPreferences();

      print('Notification service initialized successfully');
    } catch (e) {
      print('Failed to initialize notification service: $e');
      rethrow;
    }
  }

  Future<void> _requestPermissions() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted notification permissions');
    } else {
      print('User declined notification permissions');
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _handleNotificationTap,
    );
  }

  void _setupFCMListeners() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Background messages
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Terminated state messages
    _messaging.getInitialMessage().then((message) {
      if (message != null) {
        _handleBackgroundMessage(message);
      }
    });
  }

  // ============================================================================
  // FCM HANDLERS
  // ============================================================================

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print('Received foreground message: ${message.messageId}');

    // Show local notification
    await _showLocalNotification(
      title: message.notification?.title ?? 'Exam Notification',
      body: message.notification?.body ?? '',
      payload: message.data,
    );

    // Save to Firestore
    await _saveNotification(message);
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    print('Notification opened from background: ${message.messageId}');
    // Handle navigation based on message data
    _handleNotificationNavigation(message.data);
  }

  void _handleNotificationTap(NotificationResponse response) {
    print('Local notification tapped: ${response.id}');
    if (response.payload != null) {
      // Parse payload and navigate
      _handleNotificationNavigation({'action': response.payload});
    }
  }

  void _handleNotificationNavigation(Map<String, dynamic> data) {
    // Implement your navigation logic here
    // Example: navigating to exam session, leaderboard, etc.
    final action = data['action'];
    final sessionId = data['sessionId'];
    
    print('Navigation: $action, Session: $sessionId');
    // TODO: Implement actual navigation
  }

  // ============================================================================
  // LOCAL NOTIFICATIONS
  // ============================================================================

  Future<void> _showLocalNotification({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
    NotificationPriority priority = NotificationPriority.normal,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'exam_notifications',
      'Exam Notifications',
      channelDescription: 'Notifications for exam sessions and achievements',
      importance: _getAndroidImportance(priority),
      priority: _getAndroidPriority(priority),
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload?.toString(),
    );
  }

  // ============================================================================
  // SCHEDULED NOTIFICATIONS
  // ============================================================================

  /// Schedule a notification for a specific time
  Future<void> scheduleNotification({
    required String id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    Map<String, dynamic>? payload,
    NotificationPriority priority = NotificationPriority.normal,
  }) async {
    try {
      // Check if time is in quiet hours
      if (await _isQuietHour(scheduledTime)) {
        print('Skipping notification during quiet hours');
        return;
      }

      final androidDetails = AndroidNotificationDetails(
        'exam_scheduled',
        'Scheduled Notifications',
        channelDescription: 'Scheduled exam reminders and notifications',
        importance: _getAndroidImportance(priority),
        priority: _getAndroidPriority(priority),
      );

      const iosDetails = DarwinNotificationDetails();

      final details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _localNotifications.zonedSchedule(
        id.hashCode,
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        
        payload: payload?.toString(),
      );

      print('Scheduled notification for $scheduledTime');
    } catch (e) {
      print('Failed to schedule notification: $e');
    }
  }

  /// Cancel a scheduled notification
  Future<void> cancelNotification(String id) async {
    await _localNotifications.cancel(id.hashCode);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  // ============================================================================
  // EXAM-SPECIFIC NOTIFICATIONS
  // ============================================================================

  /// Send session reminder notification
  Future<void> sendSessionReminder({
    required String userId,
    required String sessionId,
    required String subjectName,
    required int minutesRemaining,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.sessionReminders) return;

    await _showLocalNotification(
      title: 'Exam Session Expiring',
      body: 'Your $subjectName exam has $minutesRemaining minutes remaining!',
      payload: {
        'type': 'session_reminder',
        'sessionId': sessionId,
      },
      priority: NotificationPriority.high,
    );
  }

  /// Send achievement unlocked notification
  Future<void> sendAchievementNotification({
    required String userId,
    required Achievement achievement,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.achievementNotifications) return;

    await _showLocalNotification(
      title: '🏆 Achievement Unlocked!',
      body: '${achievement.title} - ${achievement.description}',
      payload: {
        'type': 'achievement',
        'achievementId': achievement.id,
      },
      priority: NotificationPriority.high,
    );
  }

  /// Send leaderboard update notification
  Future<void> sendLeaderboardUpdate({
    required String userId,
    required int newRank,
    required int previousRank,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.leaderboardUpdates) return;

    final rankChange = previousRank - newRank;
    final message = rankChange > 0
        ? 'You moved up $rankChange places to #$newRank!'
        : 'Your current rank is #$newRank';

    await _showLocalNotification(
      title: '📊 Leaderboard Update',
      body: message,
      payload: {
        'type': 'leaderboard',
        'rank': newRank.toString(),
      },
    );
  }

  /// Send streak reminder notification
  Future<void> sendStreakReminder({
    required String userId,
    required int currentStreak,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.streakReminders) return;

    await _showLocalNotification(
      title: '🔥 Keep Your Streak!',
      body: 'You have a $currentStreak day streak. Complete a session today!',
      payload: {
        'type': 'streak_reminder',
        'streak': currentStreak.toString(),
      },
    );
  }

  /// Send daily goal notification
  Future<void> sendDailyGoal({
    required String userId,
    required int targetSessions,
    required int completedSessions,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.dailyGoals) return;

    final remaining = targetSessions - completedSessions;
    if (remaining <= 0) return;

    await _showLocalNotification(
      title: '🎯 Daily Goal',
      body: '$remaining session${remaining > 1 ? 's' : ''} left to reach your daily goal!',
      payload: {
        'type': 'daily_goal',
      },
    );
  }

  // ============================================================================
  // GENERAL NOTIFICATIONS (Beyond Exams)
  // ============================================================================

  /// Send daily study reminder
  Future<void> scheduleDailyStudyReminder({
    required String userId,
    required DateTime scheduledTime,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.dailyGoals) return;

    await scheduleNotification(
      id: 'daily_study_$userId',
      title: '📚 Time to Study!',
      body: 'Keep your streak going. Start a practice session today.',
      scheduledTime: scheduledTime,
      payload: {
        'type': 'daily_study',
        'action': 'open_practice',
      },
    );
  }

  /// Send weekly report
  Future<void> scheduleWeeklyReport({
    required String userId,
    required DateTime scheduledTime,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.weeklyReports) return;

    await scheduleNotification(
      id: 'weekly_report_$userId',
      title: '📊 Your Weekly Report is Ready',
      body: 'See how you performed this week',
      scheduledTime: scheduledTime,
      payload: {
        'type': 'weekly_report',
        'action': 'open_analytics',
      },
    );
  }

  /// Fetch and notify AI insights
  Future<List<String>> fetchAndNotifyAIInsights({
    required String userId,
  }) async {
    try {
      final prefs = await getPreferences(userId);
      if (!prefs.aiInsights) return [];

      // Fetch AI insights from Firestore
      final snapshot = await _firestore
          .collection('ai_insights')
          .doc(userId)
          .collection('pending')
          .orderBy('createdAt', descending: true)
          .limit(5)
          .get();

      final insights = <String>[];

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final insight = data['message'] as String?;
        final insightType = data['type'] as String?;
        
        if (insight != null) {
          insights.add(insight);
          
          // Send notification
          await _showLocalNotification(
            title: _getAIInsightTitle(insightType),
            body: insight,
            payload: {
              'type': 'ai_insight',
              'insightId': doc.id,
              'insightType': insightType ?? 'general',
            },
            priority: NotificationPriority.normal,
          );

          // Mark as notified
          await doc.reference.update({'notified': true});
        }
      }

      return insights;
    } catch (e) {
      print('Failed to fetch AI insights: $e');
      return [];
    }
  }

  /// Check and notify for app updates
  Future<bool> checkAndNotifyAppUpdate({
    required String userId,
  }) async {
    try {
      // Check for updates from Firestore
      final snapshot = await _firestore
          .collection('app_config')
          .doc('version')
          .get();

      if (!snapshot.exists) return false;

      final data = snapshot.data()!;
      final latestVersion = data['latest'] as String;
      final currentVersion = data['current'] as String; // Get from package info
      final updateAvailable = _compareVersions(latestVersion, currentVersion) > 0;

      if (updateAvailable) {
        final updateInfo = data['update_info'] as Map<String, dynamic>?;
        
        await _showLocalNotification(
          title: '🚀 Update Available',
          body: updateInfo?['message'] ?? 'A new version of the app is available!',
          payload: {
            'type': 'app_update',
            'version': latestVersion,
            'action': 'open_store',
          },
          priority: NotificationPriority.high,
        );
      }

      return updateAvailable;
    } catch (e) {
      print('Failed to check app updates: $e');
      return false;
    }
  }

  /// Send settings change notification
  Future<void> sendSettingsChangeNotification({
    required String userId,
    required String settingName,
    required String message,
  }) async {
    await _showLocalNotification(
      title: '⚙️ Settings Updated',
      body: message,
      payload: {
        'type': 'settings_change',
        'setting': settingName,
        'action': 'open_settings',
      },
    );
  }

  /// Send feature announcement
  Future<void> sendFeatureAnnouncement({
    required String userId,
    required String featureName,
    required String description,
  }) async {
    await _showLocalNotification(
      title: '✨ New Feature: $featureName',
      body: description,
      payload: {
        'type': 'feature_announcement',
        'feature': featureName,
      },
      priority: NotificationPriority.normal,
    );
  }

  /// Send motivational message
  Future<void> sendMotivationalMessage({
    required String userId,
    required String message,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.motivationalMessages) return;

    await _showLocalNotification(
      title: '💪 Keep Going!',
      body: message,
      payload: {
        'type': 'motivational',
      },
    );
  }

  /// Send study tip
  Future<void> sendStudyTip({
    required String userId,
    required String tip,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.examTips) return;

    await _showLocalNotification(
      title: '💡 Study Tip',
      body: tip,
      payload: {
        'type': 'study_tip',
      },
    );
  }

  /// Send community update
  Future<void> sendCommunityUpdate({
    required String userId,
    required String title,
    required String message,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.communityUpdates) return;

    await _showLocalNotification(
      title: '👥 $title',
      body: message,
      payload: {
        'type': 'community_update',
      },
    );
  }

  /// Send emergency alert (always shown, ignores preferences)
  Future<void> sendEmergencyAlert({
    required String userId,
    required String title,
    required String message,
  }) async {
    await _showLocalNotification(
      title: '⚠️ $title',
      body: message,
      payload: {
        'type': 'emergency_alert',
      },
      priority: NotificationPriority.urgent,
    );
  }

  // ============================================================================
  // NOTIFICATION BATCHING (Prevent spam)
  // ============================================================================

  /// Check if we should send notification (rate limiting)
  Future<bool> _shouldSendNotification(NotificationType type) async {
    final lastSent = _prefs.getInt('last_notification_${type.name}');
    if (lastSent == null) return true;

    final lastSentTime = DateTime.fromMillisecondsSinceEpoch(lastSent);
    final now = DateTime.now();
    final difference = now.difference(lastSentTime);

    // Rate limits based on notification type
    switch (type) {
      case NotificationType.achievementUnlocked:
        return difference.inMinutes >= 5;
      case NotificationType.aiInsight:
        return difference.inHours >= 1;
      case NotificationType.motivational:
        return difference.inHours >= 4;
      case NotificationType.studyTip:
        return difference.inHours >= 6;
      case NotificationType.communityUpdate:
        return difference.inHours >= 12;
      default:
        return true;
    }
  }

  /// Update last notification time
  Future<void> _updateLastNotificationTime(NotificationType type) async {
    await _prefs.setInt(
      'last_notification_${type.name}',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// Schedule session expiry warning
  Future<void> scheduleSessionExpiryWarning({
    required String sessionId,
    required String subjectName,
    required DateTime expiryTime,
  }) async {
    // Schedule notification 30 minutes before expiry
    final warningTime = expiryTime.subtract(const Duration(minutes: 30));
    
    if (warningTime.isBefore(DateTime.now())) return;

    await scheduleNotification(
      id: 'expiry_$sessionId',
      title: '⏰ Session Expiring Soon',
      body: 'Your $subjectName exam will expire in 30 minutes',
      scheduledTime: warningTime,
      payload: {
        'type': 'session_expiring',
        'sessionId': sessionId,
      },
      priority: NotificationPriority.high,
    );
  }

  // ============================================================================
  // FIRESTORE OPERATIONS
  // ============================================================================

  /// Save notification to Firestore
  Future<void> _saveNotification(RemoteMessage message) async {
    try {
      final notification = ExamNotification(
        id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        userId: message.data['userId'] ?? '',
        type: _parseNotificationType(message.data['type']),
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        data: message.data,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection(_notificationsCollection)
          .doc(notification.id)
          .set(notification.toJson());
    } catch (e) {
      print('Failed to save notification: $e');
    }
  }

  /// Get user's notifications
  Future<List<ExamNotification>> getUserNotifications({
    required String userId,
    int limit = 50,
    bool unreadOnly = false,
  }) async {
    try {
      Query query = _firestore
          .collection(_notificationsCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true);

      if (unreadOnly) {
        query = query.where('isRead', isEqualTo: false);
      }

      query = query.limit(limit);

      final snapshot = await query.get();
      
      return snapshot.docs
          .map((doc) => ExamNotification.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Failed to get notifications: $e');
      return [];
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _firestore
          .collection(_notificationsCollection)
          .doc(notificationId)
          .update({'isRead': true});
    } catch (e) {
      print('Failed to mark notification as read: $e');
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead(String userId) async {
    try {
      final batch = _firestore.batch();
      
      final snapshot = await _firestore
          .collection(_notificationsCollection)
          .where('userId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();

      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {'isRead': true});
      }

      await batch.commit();
    } catch (e) {
      print('Failed to mark all as read: $e');
    }
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _firestore
          .collection(_notificationsCollection)
          .doc(notificationId)
          .delete();
    } catch (e) {
      print('Failed to delete notification: $e');
    }
  }

  // ============================================================================
  // PREFERENCES MANAGEMENT
  // ============================================================================

  /// Get user's notification preferences
  Future<NotificationPreferences> getPreferences(String userId) async {
    if (_cachedPreferences != null) return _cachedPreferences!;

    await _loadPreferences();
    return _cachedPreferences ?? const NotificationPreferences();
  }

  /// Update notification preferences
  Future<void> updatePreferences(NotificationPreferences preferences) async {
    try {
      _cachedPreferences = preferences;
      await _prefs.setString(_prefsKey, jsonEncode(preferences.toJson()));
      print('Notification preferences updated');
    } catch (e) {
      print('Failed to update preferences: $e');
    }
  }

  Future<void> _loadPreferences() async {
    try {
      final prefsJson = _prefs.getString(_prefsKey);
      if (prefsJson != null) {
        _cachedPreferences = NotificationPreferences.fromJson(
          jsonDecode(prefsJson) as Map<String, dynamic>,
        );
      }
    } catch (e) {
      print('Failed to load preferences: $e');
      _cachedPreferences = const NotificationPreferences();
    }
  }

  /// Check if current time is in quiet hours
  Future<bool> _isQuietHour(DateTime time) async {
    final prefs = _cachedPreferences ?? const NotificationPreferences();
    return prefs.quietHours.contains(time.hour);
  }

  // ============================================================================
  // FCM TOKEN MANAGEMENT
  // ============================================================================

  /// Get FCM token
  Future<String?> getFCMToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      print('Failed to get FCM token: $e');
      return null;
    }
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Failed to subscribe to topic: $e');
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Failed to unsubscribe from topic: $e');
    }
  }

  // ============================================================================
  // HELPERS
  // ============================================================================

  // ============================================================================
  // HELPERS
  // ============================================================================

  String _getAIInsightTitle(String? type) {
    switch (type) {
      case 'performance':
        return '📊 Performance Insight';
      case 'improvement':
        return '📈 Improvement Tip';
      case 'weakness':
        return '🎯 Area to Focus';
      case 'strength':
        return '⭐ You\'re Excelling!';
      case 'recommendation':
        return '💡 Recommendation';
      default:
        return '🤖 AI Insight';
    }
  }

  int _compareVersions(String v1, String v2) {
    final v1Parts = v1.split('.').map(int.parse).toList();
    final v2Parts = v2.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      if (v1Parts[i] > v2Parts[i]) return 1;
      if (v1Parts[i] < v2Parts[i]) return -1;
    }
    return 0;
  }

  Importance _getAndroidImportance(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.low:
        return Importance.low;
      case NotificationPriority.normal:
        return Importance.defaultImportance;
      case NotificationPriority.high:
        return Importance.high;
      case NotificationPriority.urgent:
        return Importance.max;
    }
  }

  Priority _getAndroidPriority(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.low:
        return Priority.low;
      case NotificationPriority.normal:
        return Priority.defaultPriority;
      case NotificationPriority.high:
        return Priority.high;
      case NotificationPriority.urgent:
        return Priority.max;
    }
  }

  NotificationType _parseNotificationType(String? type) {
    switch (type) {
      case 'session_reminder':
        return NotificationType.sessionReminder;
      case 'session_expiring':
        return NotificationType.sessionExpiring;
      case 'achievement':
        return NotificationType.achievementUnlocked;
      case 'leaderboard':
        return NotificationType.leaderboardUpdate;
      case 'streak':
        return NotificationType.streakReminder;
      case 'daily_goal':
      case 'daily_study':
        return NotificationType.dailyGoal;
      case 'weekly_report':
        return NotificationType.weeklyReport;
      case 'ai_insight':
        return NotificationType.aiInsight;
      case 'study_tip':
        return NotificationType.examTip;
      case 'app_update':
        return NotificationType.appUpdate;
      case 'settings_change':
        return NotificationType.settingsChange;
      case 'feature_announcement':
        return NotificationType.featureAnnouncement;
      case 'motivational':
        return NotificationType.motivational;
      case 'community_update':
        return NotificationType.communityUpdate;
      case 'emergency_alert':
        return NotificationType.emergencyAlert;
      default:
        return NotificationType.examTip;
    }
  }

  // ============================================================================
  // CLEANUP
  // ============================================================================

  void dispose() {
    _messageSubscription?.cancel();
  }
}