// ============================================================================
// ADDITIONAL NOTIFICATION HELPER METHODS
// ============================================================================
// Add these utility methods to your project for easy notification access

import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/exam_notification_service.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';

/// Global notification helper class
/// Provides easy access to notification functions throughout your app
class NotificationHelper {
  static ExamNotificationService get _service => getIt<ExamNotificationService>();

  // ============================================================================
  // EXAM SESSION NOTIFICATIONS
  // ============================================================================

  /// Notify when user starts studying a new subject
  static Future<void> notifyStudySessionStart({
    required String userId,
    required String subjectName,
  }) async {
    await _service.sendSessionStartNotification(
      userId: userId,
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
      subjectName: subjectName,
    );
  }

  /// Notify when user completes an exam with results
  static Future<void> notifyExamComplete({
    required String userId,
    required String sessionId,
    required String subjectName,
    required double scorePercentage,
    required String grade,
  }) async {
    await _service.sendSessionCompletionNotification(
      userId: userId,
      sessionId: sessionId,
      subjectName: subjectName,
      scorePercentage: scorePercentage,
      grade: grade,
    );
  }

  /// Notify user about time remaining in exam
  static Future<void> notifyTimeRemaining({
    required String userId,
    required String sessionId,
    required String subjectName,
    required int minutesRemaining,
  }) async {
    await _service.sendSessionReminder(
      userId: userId,
      sessionId: sessionId,
      subjectName: subjectName,
      minutesRemaining: minutesRemaining,
    );
  }

  // ============================================================================
  // ACHIEVEMENT & PROGRESS NOTIFICATIONS
  // ============================================================================

  /// Notify when user unlocks an achievement
  static Future<void> notifyAchievement({
    required String userId,
    required String achievementTitle,
    required String achievementDescription,
    int points = 0,
  }) async {
    await _service.sendAchievementNotification(
      userId: userId,
      achievement: Achievement(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: achievementTitle,
        description: achievementDescription,
        category: AchievementCategory.completion,
        points: points,
        unlockedAt: DateTime.now(),
      ),
    );
  }

  /// Notify about leaderboard position change
  static Future<void> notifyLeaderboardChange({
    required String userId,
    required int newRank,
    required int previousRank,
  }) async {
    await _service.sendLeaderboardUpdate(
      userId: userId,
      newRank: newRank,
      previousRank: previousRank,
    );
  }

  /// Notify about streak milestones
  static Future<void> notifyStreakMilestone({
    required String userId,
    required int streakDays,
  }) async {
    await _service.sendStreakReminder(
      userId: userId,
      currentStreak: streakDays,
    );
  }

  /// Notify when daily goal is achieved
  static Future<void> notifyDailyGoalAchieved({
    required String userId,
    required int sessionsCompleted,
  }) async {
    await _service.sendDailyGoal(
      userId: userId,
      targetSessions: sessionsCompleted,
      completedSessions: sessionsCompleted,
    );
  }

  // ============================================================================
  // LEARNING & INSIGHTS NOTIFICATIONS
  // ============================================================================

  /// Notify user about performance insights
  static Future<void> notifyPerformanceInsight({
    required String userId,
    required String subject,
    required String insight,
  }) async {
    await _service.sendPerformanceInsight(
      userId: userId,
      insight: insight,
      subject: subject,
    );
  }

  /// Suggest improvements for weak areas
  static Future<void> notifyImprovementSuggestion({
    required String userId,
    required String weakArea,
    required String suggestion,
  }) async {
    await _service.sendImprovementSuggestion(
      userId: userId,
      suggestion: suggestion,
      weakArea: weakArea,
    );
  }

  /// Send motivational message
  static Future<void> notifyMotivation({
    required String userId,
    required String message,
  }) async {
    await _service.sendMotivationalMessage(
      userId: userId,
      message: message,
    );
  }

  /// Send study tip
  static Future<void> notifyStudyTip({
    required String userId,
    required String tip,
  }) async {
    await _service.sendStudyTip(
      userId: userId,
      tip: tip,
    );
  }

  // ============================================================================
  // REMINDER & SCHEDULING NOTIFICATIONS
  // ============================================================================

  /// Schedule daily study reminder
  static Future<void> scheduleDailyReminder({
    required String userId,
    required int hour,
    required int minute,
  }) async {
    final now = DateTime.now();
    var scheduledTime = DateTime(now.year, now.month, now.day, hour, minute);
    
    // If time has passed today, schedule for tomorrow
    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    await _service.scheduleDailyStudyReminder(
      userId: userId,
      scheduledTime: scheduledTime,
    );
  }

  /// Schedule weekly report notification
  static Future<void> scheduleWeeklyReport({
    required String userId,
    required DateTime scheduledTime,
  }) async {
    await _service.scheduleWeeklyReport(
      userId: userId,
      scheduledTime: scheduledTime,
    );
  }

  /// Cancel specific notification
  static Future<void> cancelNotification(String notificationId) async {
    await _service.cancelNotification(notificationId);
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _service.cancelAllNotifications();
  }

  // ============================================================================
  // NOTIFICATION MANAGEMENT
  // ============================================================================

  /// Get all user notifications
  static Future<List<ExamNotification>> getUserNotifications({
    required String userId,
    int limit = 50,
    bool unreadOnly = false,
  }) async {
    return await _service.getUserNotifications(
      userId: userId,
      limit: limit,
      unreadOnly: unreadOnly,
    );
  }

  /// Get count of unread notifications
  static Future<int> getUnreadCount(String userId) async {
    return await _service.getUnreadCount(userId);
  }

  /// Mark notification as read
  static Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) async {
    await _service.markAsRead(userId, notificationId);
  }

  /// Mark all notifications as read
  static Future<void> markAllAsRead(String userId) async {
    await _service.markAllAsRead(userId);
  }

  /// Delete notification
  static Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) async {
    await _service.deleteNotification(userId, notificationId);
  }

  /// Delete all notifications
  static Future<void> deleteAllNotifications(String userId) async {
    await _service.deleteAllNotifications(userId);
  }

  // ============================================================================
  // PREFERENCES MANAGEMENT
  // ============================================================================

  /// Get user's notification preferences
  static Future<NotificationPreferences> getPreferences(String userId) async {
    return await _service.getPreferences(userId);
  }

  /// Update notification preferences
  static Future<void> updatePreferences(NotificationPreferences preferences) async {
    await _service.updatePreferences(preferences);
  }

  /// Enable/disable specific notification type
  static Future<void> toggleNotificationType({
    required String userId,
    required NotificationTypeToggle type,
    required bool enabled,
  }) async {
    final prefs = await getPreferences(userId);
    
    final updatedPrefs = NotificationPreferences(
      sessionReminders: type == NotificationTypeToggle.sessionReminders 
          ? enabled : prefs.sessionReminders,
      achievementNotifications: type == NotificationTypeToggle.achievements 
          ? enabled : prefs.achievementNotifications,
      leaderboardUpdates: type == NotificationTypeToggle.leaderboard 
          ? enabled : prefs.leaderboardUpdates,
      streakReminders: type == NotificationTypeToggle.streaks 
          ? enabled : prefs.streakReminders,
      dailyGoals: type == NotificationTypeToggle.dailyGoals 
          ? enabled : prefs.dailyGoals,
      weeklyReports: type == NotificationTypeToggle.weeklyReports 
          ? enabled : prefs.weeklyReports,
      aiInsights: type == NotificationTypeToggle.aiInsights 
          ? enabled : prefs.aiInsights,
      examTips: type == NotificationTypeToggle.examTips 
          ? enabled : prefs.examTips,
      motivationalMessages: type == NotificationTypeToggle.motivational 
          ? enabled : prefs.motivationalMessages,
      communityUpdates: type == NotificationTypeToggle.community 
          ? enabled : prefs.communityUpdates,
      quietHours: prefs.quietHours,
    );

    await updatePreferences(updatedPrefs);
  }

  // ============================================================================
  // FCM TOKEN MANAGEMENT
  // ============================================================================

  /// Get FCM token for push notifications
  static Future<String?> getFCMToken() async {
    return await _service.getFCMToken();
  }

  /// Subscribe to notification topic
  static Future<void> subscribeToTopic(String topic) async {
    await _service.subscribeToTopic(topic);
  }

  /// Unsubscribe from notification topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _service.unsubscribeFromTopic(topic);
  }

  // ============================================================================
  // BATCH NOTIFICATIONS (Advanced)
  // ============================================================================

  /// Send multiple notifications at once (optimized)
  static Future<void> sendBatch({
    required String userId,
    required List<NotificationBatchItem> notifications,
  }) async {
    for (final item in notifications) {
      try {
        switch (item.type) {
          case NotificationTypeToggle.achievements:
            await notifyAchievement(
              userId: userId,
              achievementTitle: item.title,
              achievementDescription: item.body,
            );
            break;
          case NotificationTypeToggle.sessionReminders:
            await notifyStudySessionStart(
              userId: userId,
              subjectName: item.title,
            );
            break;
          case NotificationTypeToggle.motivational:
            await notifyMotivation(
              userId: userId,
              message: item.body,
            );
            break;
          default:
            break;
        }
      } catch (e) {
        print('Error sending batch notification: $e');
      }
    }
  }

  // ============================================================================
  // SMART NOTIFICATIONS (Context-Aware)
  // ============================================================================

  /// Send contextual notification based on user behavior
  static Future<void> sendContextualNotification({
    required String userId,
    required UserContext context,
  }) async {
    switch (context.type) {
      case UserContextType.poorPerformance:
        await notifyMotivation(
          userId: userId,
          message: 'Don\'t worry! Every expert was once a beginner. Keep practicing!',
        );
        break;

      case UserContextType.improvedPerformance:
        await notifyPerformanceInsight(
          userId: userId,
          subject: context.subject ?? 'Overall',
          insight: 'Great improvement! You\'re ${context.improvementPercentage}% better than last time!',
        );
        break;

      case UserContextType.longInactive:
        await notifyStreakMilestone(
          userId: userId,
          streakDays: 0,
        );
        break;

      case UserContextType.aboutToLoseStreak:
        await notifyStreakMilestone(
          userId: userId,
          streakDays: context.streakDays ?? 0,
        );
        break;

      case UserContextType.milestoneAchieved:
        await notifyAchievement(
          userId: userId,
          achievementTitle: context.milestoneTitle ?? 'Milestone Reached!',
          achievementDescription: context.milestoneDescription ?? 'You\'ve reached a new milestone!',
          points: context.points ?? 0,
        );
        break;
    }
  }
}

// ============================================================================
// SUPPORTING CLASSES
// ============================================================================

enum NotificationTypeToggle {
  sessionReminders,
  achievements,
  leaderboard,
  streaks,
  dailyGoals,
  weeklyReports,
  aiInsights,
  examTips,
  motivational,
  community,
}

class NotificationBatchItem {
  final NotificationTypeToggle type;
  final String title;
  final String body;
  final Map<String, dynamic>? data;

  NotificationBatchItem({
    required this.type,
    required this.title,
    required this.body,
    this.data,
  });
}

enum UserContextType {
  poorPerformance,
  improvedPerformance,
  longInactive,
  aboutToLoseStreak,
  milestoneAchieved,
}

class UserContext {
  final UserContextType type;
  final String? subject;
  final double? improvementPercentage;
  final int? streakDays;
  final String? milestoneTitle;
  final String? milestoneDescription;
  final int? points;

  UserContext({
    required this.type,
    this.subject,
    this.improvementPercentage,
    this.streakDays,
    this.milestoneTitle,
    this.milestoneDescription,
    this.points,
  });
}

// ============================================================================
// USAGE EXAMPLES
// ============================================================================

/*

// Example 1: Notify when user starts exam
await NotificationHelper.notifyStudySessionStart(
  userId: currentUser.id,
  subjectName: 'Mathematics',
);

// Example 2: Notify when exam completes
await NotificationHelper.notifyExamComplete(
  userId: currentUser.id,
  sessionId: session.id,
  subjectName: 'Physics',
  scorePercentage: 85.5,
  grade: 'A',
);

// Example 3: Send achievement notification
await NotificationHelper.notifyAchievement(
  userId: currentUser.id,
  achievementTitle: 'First Perfect Score!',
  achievementDescription: 'You scored 100% in your exam',
  points: 50,
);

// Example 4: Schedule daily reminder
await NotificationHelper.scheduleDailyReminder(
  userId: currentUser.id,
  hour: 9,  // 9 AM
  minute: 0,
);

// Example 5: Get unread notifications
final unreadCount = await NotificationHelper.getUnreadCount(currentUser.id);
final notifications = await NotificationHelper.getUserNotifications(
  userId: currentUser.id,
  limit: 20,
  unreadOnly: true,
);

// Example 6: Toggle notification type
await NotificationHelper.toggleNotificationType(
  userId: currentUser.id,
  type: NotificationTypeToggle.achievements,
  enabled: false, // Disable achievement notifications
);

// Example 7: Send contextual notification
await NotificationHelper.sendContextualNotification(
  userId: currentUser.id,
  context: UserContext(
    type: UserContextType.improvedPerformance,
    subject: 'Chemistry',
    improvementPercentage: 15.5,
  ),
);

// Example 8: Send batch notifications
await NotificationHelper.sendBatch(
  userId: currentUser.id,
  notifications: [
    NotificationBatchItem(
      type: NotificationTypeToggle.achievements,
      title: 'Perfect Score',
      body: 'You scored 100%!',
    ),
    NotificationBatchItem(
      type: NotificationTypeToggle.motivational,
      title: 'Keep Going!',
      body: 'You\'re doing great!',
    ),
  ],
);

*/