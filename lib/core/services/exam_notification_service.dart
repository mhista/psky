// ============================================================================
// COMPLETE WEB-COMPATIBLE EXAM NOTIFICATION SERVICE
// ============================================================================

import 'dart:async';
import 'dart:convert';
import 'package:ahiaa_web/core/utils/enums/notification_enums.dart';
import 'package:ahiaa_web/core/utils/local_storage/storage_utility.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:universal_html/js.dart' as js;

// ============================================================================
// WEB NOTIFICATION WRAPPER
// ============================================================================
class WebNotificationManager {
  static bool _permissionGranted = false;

  static Future<bool> requestPermission() async {
    if (!kIsWeb) return false;

    try {
      final permission = await _requestBrowserPermission();
      _permissionGranted = permission;
      return permission;
    } catch (e) {
      print('Error requesting web notification permission: $e');
      return false;
    }
  }

  static Future<bool> _requestBrowserPermission() async {
   js.context.callMethod('Notification.requestPermission');
    return true;
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? icon,
    String? badge,
    Map<String, dynamic>? data,
  }) async {
    if (!kIsWeb || !_permissionGranted) return;

    try {
      print('Web Notification: $title - $body');
    js.context.callMethod('showNotification', [title, body, data]);
    } catch (e) {
      print('Error showing web notification: $e');
    }
  }
}

@lazySingleton
class ExamNotificationService {
  final FirebaseFirestore _firestore;
  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final LocalStorageService _prefs;

  static const String _prefsKey = 'notification_prefs';
  static const String _lastNotificationKey = 'last_notification_time';
  static const String _notificationsCollection = 'notifications';
  static const String _userNotificationsSubcollection = 'user_notifications';

  NotificationPreferences? _cachedPreferences;
  StreamSubscription<RemoteMessage>? _messageSubscription;

  // Track notification queue for web
  final List<ExamNotification> _pendingNotifications = [];
  Timer? _notificationFlushTimer;

  ExamNotificationService(
    this._firestore,
    this._messaging,
    this._localNotifications,
    this._prefs,
  );

  // ============================================================================
  // INITIALIZATION (ENHANCED FOR WEB)
  // ============================================================================

  Future<void> initialize() async {
    try {
      if (kIsWeb) {
        
        await _initializeWeb();
      } else {
        await _initializeMobile();
      }

      await _loadPreferences();
      _startNotificationFlushTimer();

      print(
          'Notification service initialized successfully (${kIsWeb ? "Web" : "Mobile"})');
    } catch (e) {
      print('Failed to initialize notification service: $e');
      rethrow;
    }
  }

  Future<void> _initializeWeb() async {
    try {
      await WebNotificationManager.requestPermission();

      try {
        final token = await _messaging.getToken(
          vapidKey:
              'BJEBkjm3e_z_2pjjIzwOiDvHHu1lcCyGjKUg6tsse2sHdXfhB98bC6jKP_Pxw1X9B8gsPSLIGrJcq-mPLtibaHM	', // Replace with your VAPID key
        );
        print('FCM Web Token: $token');

        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      } catch (e) {
        print('FCM setup failed on web (expected if not configured): $e');
      }
    } catch (e) {
      print('Web notification setup error: $e');
    }
  }

  Future<void> _initializeMobile() async {
    await _requestPermissions();
    await _initializeLocalNotifications();
    _setupFCMListeners();
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
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
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
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

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

    await _showNotification(
      title: message.notification?.title ?? 'Exam Notification',
      body: message.notification?.body ?? '',
      payload: {
        ...message.data,
        'userId': message.data['userId'] ?? '',
      },
    );
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    print('Notification opened from background: ${message.messageId}');
    _handleNotificationNavigation(message.data);
  }

  void _handleNotificationTap(NotificationResponse response) {
    print('Local notification tapped: ${response.id}');
    if (response.payload != null) {
      try {
        final data = jsonDecode(response.payload!);
        _handleNotificationNavigation(data);
      } catch (e) {
        print('Error parsing notification payload: $e');
      }
    }
  }

  void _handleNotificationNavigation(Map<String, dynamic> data) {
    final action = data['action'];
    final sessionId = data['sessionId'];

    print('Navigation: $action, Session: $sessionId');
    // TODO: Implement actual navigation via router/navigator
  }

  // ============================================================================
  // NOTIFICATION DISPLAY (UNIFIED FOR WEB & MOBILE)
  // ============================================================================

  Future<void> _showNotification({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
    NotificationPriority priority = NotificationPriority.normal,
    bool saveToDb = true,
  }) async {
    try {
      if (kIsWeb) {
        await WebNotificationManager.showNotification(
          title: title,
          body: body,
          data: payload,
        );
      } else {
        await _showLocalNotification(
          title: title,
          body: body,
          payload: payload,
          priority: priority,
        );
      }

      if (saveToDb && payload != null && payload['userId'] != null) {
        await _saveNotificationToDb(
          userId: payload['userId'],
          title: title,
          body: body,
          type: _parseNotificationType(payload['type']),
          data: payload,
        );
      }
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

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
      payload: jsonEncode(payload),
    );
  }

  // ============================================================================
  // DATABASE PERSISTENCE
  // ============================================================================

  Future<void> _saveNotificationToDb({
    required String userId,
    required String title,
    required String body,
    required NotificationType type,
    Map<String, dynamic>? data,
  }) async {
    try {
      final notification = ExamNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        type: type,
        title: title,
        body: body,
        data: data ?? {},
        createdAt: DateTime.now(),
        isRead: false,
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsSubcollection)
          .doc(notification.id)
          .set(notification.toJson());

      print('✅ Notification saved to DB: ${notification.id}');
    } catch (e) {
      print('❌ Failed to save notification to DB: $e');
      _pendingNotifications.add(ExamNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        type: type,
        title: title,
        body: body,
        data: data ?? {},
        createdAt: DateTime.now(),
      ));
    }
  }

  void _startNotificationFlushTimer() {
    _notificationFlushTimer?.cancel();
    _notificationFlushTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      _flushPendingNotifications();
    });
  }

  Future<void> _flushPendingNotifications() async {
    if (_pendingNotifications.isEmpty) return;

    final toRetry = List<ExamNotification>.from(_pendingNotifications);
    _pendingNotifications.clear();

    for (final notification in toRetry) {
      try {
        await _firestore
            .collection('users')
            .doc(notification.userId)
            .collection(_userNotificationsSubcollection)
            .doc(notification.id)
            .set(notification.toJson());

        print('✅ Retried notification save: ${notification.id}');
      } catch (e) {
        print('❌ Retry failed for notification: ${notification.id}');
        _pendingNotifications.add(notification);
      }
    }
  }

  // ============================================================================
  // SCHEDULED NOTIFICATIONS (MOBILE ONLY, WEB USES FIRESTORE TRIGGERS)
  // ============================================================================

  Future<void> scheduleNotification({
    required String id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    Map<String, dynamic>? payload,
    NotificationPriority priority = NotificationPriority.normal,
  }) async {
    if (kIsWeb) {
      // For web, save to Firestore and use Cloud Functions to trigger
      await _saveScheduledNotificationToDb(
        id: id,
        userId: payload?['userId'] ?? '',
        title: title,
        body: body,
        scheduledTime: scheduledTime,
        payload: payload,
        priority: priority,
      );
      return;
    }

    try {
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
        payload: jsonEncode(payload),
      );

      print('Scheduled notification for $scheduledTime');
    } catch (e) {
      print('Failed to schedule notification: $e');
    }
  }

  Future<void> _saveScheduledNotificationToDb({
    required String id,
    required String userId,
    required String title,
    required String body,
    required DateTime scheduledTime,
    Map<String, dynamic>? payload,
    NotificationPriority priority = NotificationPriority.normal,
  }) async {
    try {
      await _firestore.collection('scheduled_notifications').doc(id).set({
        'userId': userId,
        'title': title,
        'body': body,
        'scheduledTime': Timestamp.fromDate(scheduledTime),
        'payload': payload ?? {},
        'priority': priority.toString(),
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      print('✅ Scheduled notification saved to DB for Cloud Function trigger');
    } catch (e) {
      print('❌ Failed to save scheduled notification: $e');
    }
  }

  Future<void> cancelNotification(String id) async {
    if (kIsWeb) {
      // Cancel by updating Firestore
      try {
        await _firestore
            .collection('scheduled_notifications')
            .doc(id)
            .update({'status': 'cancelled'});
      } catch (e) {
        print('Failed to cancel scheduled notification: $e');
      }
    } else {
      await _localNotifications.cancel(id.hashCode);
    }
  }

  Future<void> cancelAllNotifications() async {
    if (kIsWeb) {
      // Cancel all user's scheduled notifications in Firestore
      print('Cancel all notifications not fully implemented for web');
    } else {
      await _localNotifications.cancelAll();
    }
  }

  // ============================================================================
  // EXAM-SPECIFIC NOTIFICATIONS
  // ============================================================================

  Future<void> sendSessionStartNotification({
    required String userId,
    required String sessionId,
    required String subjectName,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.sessionReminders) return;

    await _showNotification(
      title: '🚀 Exam Started',
      body: 'Your $subjectName exam session has begun. Good luck!',
      payload: {
        'type': 'session_start',
        'sessionId': sessionId,
        'userId': userId,
        'action': 'open_session',
      },
      priority: NotificationPriority.high,
    );
  }

  Future<void> sendSessionReminder({
    required String userId,
    required String sessionId,
    required String subjectName,
    required int minutesRemaining,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.sessionReminders) return;

    await _showNotification(
      title: '⏰ Exam Session Expiring',
      body: 'Your $subjectName exam has $minutesRemaining minutes remaining!',
      payload: {
        'type': 'session_reminder',
        'sessionId': sessionId,
        'userId': userId,
        'action': 'open_session',
      },
      priority: NotificationPriority.high,
    );
  }

  Future<void> sendSessionPauseNotification({
    required String userId,
    required String sessionId,
    required String subjectName,
  }) async {
    await _showNotification(
      title: '⏸️ Exam Paused',
      body: 'Your $subjectName exam has been paused. Resume when ready!',
      payload: {
        'type': 'session_pause',
        'sessionId': sessionId,
        'userId': userId,
        'action': 'open_session',
      },
    );
  }

  Future<void> sendSessionResumeNotification({
    required String userId,
    required String sessionId,
    required String subjectName,
  }) async {
    await _showNotification(
      title: '▶️ Exam Resumed',
      body: 'Your $subjectName exam session has resumed. Keep going!',
      payload: {
        'type': 'session_resume',
        'sessionId': sessionId,
        'userId': userId,
        'action': 'open_session',
      },
    );
  }

  Future<void> sendSessionCompletionNotification({
    required String userId,
    required String sessionId,
    required String subjectName,
    required double scorePercentage,
    required String grade,
  }) async {
    await _showNotification(
      title: '✅ Exam Completed!',
      body:
          'You scored ${scorePercentage.toStringAsFixed(1)}% ($grade) in $subjectName',
      payload: {
        'type': 'session_complete',
        'sessionId': sessionId,
        'userId': userId,
        'action': 'view_results',
      },
      priority: NotificationPriority.high,
    );
  }

  Future<void> sendAchievementNotification({
    required String userId,
    required Achievement achievement,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.achievementNotifications) return;

    await _showNotification(
      title: '🏆 Achievement Unlocked!',
      body: '${achievement.title} - ${achievement.description}',
      payload: {
        'type': 'achievement',
        'achievementId': achievement.id,
        'userId': userId,
        'action': 'view_achievements',
      },
      priority: NotificationPriority.high,
    );
  }

  Future<void> sendLeaderboardUpdate({
    required String userId,
    required int newRank,
    required int previousRank,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.leaderboardUpdates) return;

    final rankChange = previousRank - newRank;
    final message = rankChange > 0
        ? 'You moved up $rankChange places to #$newRank! 🎉'
        : 'Your current rank is #$newRank';

    await _showNotification(
      title: '📊 Leaderboard Update',
      body: message,
      payload: {
        'type': 'leaderboard',
        'rank': newRank.toString(),
        'userId': userId,
        'action': 'view_leaderboard',
      },
    );
  }

  Future<void> sendStreakReminder({
    required String userId,
    required int currentStreak,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.streakReminders) return;

    await _showNotification(
      title: '🔥 Keep Your Streak!',
      body: 'You have a $currentStreak day streak. Complete a session today!',
      payload: {
        'type': 'streak_reminder',
        'streak': currentStreak.toString(),
        'userId': userId,
        'action': 'open_practice',
      },
    );
  }

  Future<void> sendDailyGoal({
    required String userId,
    required int targetSessions,
    required int completedSessions,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.dailyGoals) return;

    final remaining = targetSessions - completedSessions;
    if (remaining <= 0) {
      await _showNotification(
        title: '🎯 Daily Goal Achieved!',
        body:
            'Congratulations! You completed all $targetSessions sessions today!',
        payload: {
          'type': 'daily_goal_achieved',
          'userId': userId,
        },
        priority: NotificationPriority.high,
      );
    } else {
      await _showNotification(
        title: '🎯 Daily Goal',
        body:
            '$remaining session${remaining > 1 ? 's' : ''} left to reach your goal!',
        payload: {
          'type': 'daily_goal',
          'userId': userId,
          'action': 'open_practice',
        },
      );
    }
  }

  Future<void> sendPerformanceInsight({
    required String userId,
    required String insight,
    required String subject,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.aiInsights) return;

    await _showNotification(
      title: '📊 Performance Insight',
      body: '$subject: $insight',
      payload: {
        'type': 'performance_insight',
        'userId': userId,
        'subject': subject,
        'action': 'view_analytics',
      },
    );
  }

  Future<void> sendImprovementSuggestion({
    required String userId,
    required String suggestion,
    required String weakArea,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.aiInsights) return;

    await _showNotification(
      title: '💡 Improvement Suggestion',
      body: '$weakArea: $suggestion',
      payload: {
        'type': 'improvement_suggestion',
        'userId': userId,
        'action': 'view_analytics',
      },
    );
  }

  // ============================================================================
  // GENERAL NOTIFICATIONS (ADDED FROM OLD SERVICE)
  // ============================================================================

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
        'userId': userId,
        'action': 'open_practice',
      },
    );
  }

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
        'userId': userId,
        'action': 'open_analytics',
      },
    );
  }

  Future<void> scheduleSessionExpiryWarning({
    required String sessionId,
    required String userId,
    required String subjectName,
    required DateTime expiryTime,
  }) async {
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
        'userId': userId,
        'action': 'open_session',
      },
      priority: NotificationPriority.high,
    );
  }

  Future<List<String>> fetchAndNotifyAIInsights({
    required String userId,
  }) async {
    try {
      final prefs = await getPreferences(userId);
      if (!prefs.aiInsights) return [];

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

          await _showNotification(
            title: _getAIInsightTitle(insightType),
            body: insight,
            payload: {
              'type': 'ai_insight',
              'insightId': doc.id,
              'insightType': insightType ?? 'general',
              'userId': userId,
            },
            priority: NotificationPriority.normal,
          );

          await doc.reference.update({'notified': true});
        }
      }

      return insights;
    } catch (e) {
      print('Failed to fetch AI insights: $e');
      return [];
    }
  }

  Future<bool> checkAndNotifyAppUpdate({
    required String userId,
  }) async {
    try {
      final snapshot =
          await _firestore.collection('app_config').doc('version').get();

      if (!snapshot.exists) return false;

      final data = snapshot.data()!;
      final latestVersion = data['latest'] as String;
      final currentVersion = data['current'] as String;
      final updateAvailable =
          _compareVersions(latestVersion, currentVersion) > 0;

      if (updateAvailable) {
        final updateInfo = data['update_info'] as Map<String, dynamic>?;

        await _showNotification(
          title: '🚀 Update Available',
          body: updateInfo?['message'] ??
              'A new version of the app is available!',
          payload: {
            'type': 'app_update',
            'version': latestVersion,
            'userId': userId,
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

  Future<void> sendSettingsChangeNotification({
    required String userId,
    required String settingName,
    required String message,
  }) async {
    await _showNotification(
      title: '⚙️ Settings Updated',
      body: message,
      payload: {
        'type': 'settings_change',
        'setting': settingName,
        'userId': userId,
        'action': 'open_settings',
      },
    );
  }

  Future<void> sendFeatureAnnouncement({
    required String userId,
    required String featureName,
    required String description,
  }) async {
    await _showNotification(
      title: '✨ New Feature: $featureName',
      body: description,
      payload: {
        'type': 'feature_announcement',
        'feature': featureName,
        'userId': userId,
      },
      priority: NotificationPriority.normal,
    );
  }

  Future<void> sendMotivationalMessage({
    required String userId,
    required String message,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.motivationalMessages) return;

    if (!await _shouldSendNotification(NotificationType.motivational)) return;

    await _showNotification(
      title: '💪 Keep Going!',
      body: message,
      payload: {
        'type': 'motivational',
        'userId': userId,
      },
    );

    await _updateLastNotificationTime(NotificationType.motivational);
  }

  Future<void> sendStudyTip({
    required String userId,
    required String tip,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.examTips) return;

    if (!await _shouldSendNotification(NotificationType.examTip)) return;

    await _showNotification(
      title: '💡 Study Tip',
      body: tip,
      payload: {
        'type': 'study_tip',
        'userId': userId,
      },
    );

    await _updateLastNotificationTime(NotificationType.examTip);
  }

  Future<void> sendCommunityUpdate({
    required String userId,
    required String title,
    required String message,
  }) async {
    final prefs = await getPreferences(userId);
    if (!prefs.communityUpdates) return;

    if (!await _shouldSendNotification(NotificationType.communityUpdate))
      return;

    await _showNotification(
      title: '👥 $title',
      body: message,
      payload: {
        'type': 'community_update',
        'userId': userId,
      },
    );

    await _updateLastNotificationTime(NotificationType.communityUpdate);
  }

  Future<void> sendEmergencyAlert({
    required String userId,
    required String title,
    required String message,
  }) async {
    await _showNotification(
      title: '⚠️ $title',
      body: message,
      payload: {
        'type': 'emergency_alert',
        'userId': userId,
      },
      priority: NotificationPriority.urgent,
    );
  }

  // ============================================================================
  // NOTIFICATION BATCHING (RATE LIMITING)
  // ============================================================================

  Future<bool> _shouldSendNotification(NotificationType type) async {
    final lastSent = _prefs.getUserData('last_notification_${type.name}');
    if (lastSent == null) return true;

    final lastSentTime = DateTime.fromMillisecondsSinceEpoch(lastSent);
    final now = DateTime.now();
    final difference = now.difference(lastSentTime);

    switch (type) {
      case NotificationType.achievementUnlocked:
        return difference.inMinutes >= 5;
      case NotificationType.aiInsight:
        return difference.inHours >= 1;
      case NotificationType.motivational:
        return difference.inHours >= 4;
      case NotificationType.examTip:
        return difference.inHours >= 6;
      case NotificationType.communityUpdate:
        return difference.inHours >= 12;
      default:
        return true;
    }
  }

  Future<void> _updateLastNotificationTime(NotificationType type) async {
    await _prefs.saveUserData(
      'last_notification_${type.name}',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  // ============================================================================
  // FIRESTORE OPERATIONS
  // ============================================================================

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
          .collection(_userNotificationsSubcollection)
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
          .map((doc) =>
              ExamNotification.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Failed to get notifications: $e');
      return [];
    }
  }

  Future<int> getUnreadCount(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsSubcollection)
          .where('isRead', isEqualTo: false)
          .get();

      return snapshot.docs.length;
    } catch (e) {
      print('Failed to get unread count: $e');
      return 0;
    }
  }

  Future<void> markAsRead(String userId, String notificationId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsSubcollection)
          .doc(notificationId)
          .update({
        'isRead': true,
        'readAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Failed to mark notification as read: $e');
    }
  }

  Future<void> markAllAsRead(String userId) async {
    try {
      final batch = _firestore.batch();

      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsSubcollection)
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
      print('Failed to mark all as read: $e');
    }
  }

  Future<void> deleteNotification(String userId, String notificationId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsSubcollection)
          .doc(notificationId)
          .delete();
    } catch (e) {
      print('Failed to delete notification: $e');
    }
  }

  Future<void> deleteAllNotifications(String userId) async {
    try {
      final batch = _firestore.batch();

      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection(_userNotificationsSubcollection)
          .get();

      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      print('Failed to delete all notifications: $e');
    }
  }

  // ============================================================================
  // PREFERENCES MANAGEMENT
  // ============================================================================

  Future<NotificationPreferences> getPreferences(String userId) async {
    if (_cachedPreferences != null) return _cachedPreferences!;
    await _loadPreferences();
    return _cachedPreferences ?? const NotificationPreferences();
  }

  Future<void> updatePreferences(NotificationPreferences preferences) async {
    try {
      _cachedPreferences = preferences;
      await _prefs.saveUserJson(_prefsKey, preferences.toJson());
      print('Notification preferences updated');
    } catch (e) {
      print('Failed to update preferences: $e');
    }
  }

  Future<void> _loadPreferences() async {
    try {
      final prefsJson = _prefs.getUserJson(_prefsKey);
      if (prefsJson != null) {
        _cachedPreferences = NotificationPreferences.fromJson(prefsJson);
      }
    } catch (e) {
      print('Failed to load preferences: $e');
      _cachedPreferences = const NotificationPreferences();
    }
  }

  Future<bool> _isQuietHour(DateTime time) async {
    final prefs = _cachedPreferences ?? const NotificationPreferences();
    return prefs.quietHours.contains(time.hour);
  }

  // ============================================================================
  // FCM TOKEN MANAGEMENT
  // ============================================================================

  Future<String?> getFCMToken() async {
    try {
      if (kIsWeb) {
        return await _messaging.getToken(
          vapidKey: 'YOUR_VAPID_KEY', // Replace with your VAPID key
        );
      } else {
        return await _messaging.getToken();
      }
    } catch (e) {
      print('Failed to get FCM token: $e');
      return null;
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Failed to subscribe to topic: $e');
    }
  }

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
      case 'session_start':
        return NotificationType.sessionStart;
      case 'session_reminder':
        return NotificationType.sessionReminder;
      case 'session_expiring':
        return NotificationType.sessionExpiring;
      case 'session_pause':
        return NotificationType.sessionPause;
      case 'session_resume':
        return NotificationType.sessionResume;
      case 'session_complete':
        return NotificationType.sessionComplete;
      case 'achievement':
        return NotificationType.achievementUnlocked;
      case 'leaderboard':
        return NotificationType.leaderboardUpdate;
      case 'streak':
      case 'streak_reminder':
        return NotificationType.streakReminder;
      case 'daily_goal':
      case 'daily_goal_achieved':
      case 'daily_study':
        return NotificationType.dailyGoal;
      case 'weekly_report':
        return NotificationType.weeklyReport;
      case 'performance_insight':
      case 'improvement_suggestion':
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
    _notificationFlushTimer?.cancel();
  }
}
