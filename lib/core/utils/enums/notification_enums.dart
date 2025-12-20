// ============================================================================
// NOTIFICATION TYPE EXTENSIONS
// lib/core/utils/extensions/notification_type_extensions.dart
// ============================================================================

import 'package:flutter/material.dart';
enum NotificationPriority {
  low,
  normal,
  high,
  urgent,
}

enum NotificationType {
  sessionStart,
  sessionReminder,
  sessionExpiring,
  sessionPause,
  sessionResume,
  sessionComplete,
  achievementUnlocked,
  leaderboardUpdate,
  streakReminder,
  dailyGoal,
  weeklyReport,
  aiInsight,
  examTip,
  appUpdate,
  settingsChange,
  featureAnnouncement,
  motivational,
  communityUpdate,
  emergencyAlert,
}

// You'll need to add this mapping logic:

extension StringToNotificationTypeExtension on String {
  /// Converts a string action/type from a notification payload into a [NotificationType] enum value.
  ///
  /// This is intended to be used with the 'type' field in the payload.
  NotificationType get toNotificationType {
    switch (this) {
      // Session & Exam Types (from send...Notification methods)
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
      
      // Achievement & Goal Types
      case 'achievement': // Used in sendAchievementNotification
        return NotificationType.achievementUnlocked;
      case 'leaderboard': // Used in sendLeaderboardUpdate
        return NotificationType.leaderboardUpdate;
      case 'streak_reminder':
        return NotificationType.streakReminder;
      case 'daily_goal':
      case 'daily_goal_achieved': // Mapped to the same type for simplicity
        return NotificationType.dailyGoal;

      // Insights & Reports
      case 'weekly_report': // Used in scheduleWeeklyReport
        return NotificationType.weeklyReport;
      case 'ai_insight': // Used in fetchAndNotifyAIInsights
      case 'performance_insight':
      case 'improvement_suggestion':
        return NotificationType.aiInsight;
      case 'daily_study': // This acts as a reminder/tip
        return NotificationType.examTip; // Best fit, as it's a study tip/reminder
      
      // System & General Types
      case 'app_update':
        return NotificationType.appUpdate;
      case 'settings_change':
        return NotificationType.settingsChange; // Assuming a general method would send this
      case 'feature_announcement':
        return NotificationType.featureAnnouncement; // Assuming a general method would send this
      case 'motivational':
        return NotificationType.motivational; // Assuming a general method would send this
      case 'community_update':
        return NotificationType.communityUpdate; // Assuming a general method would send this
      case 'emergency_alert':
        return NotificationType.emergencyAlert; // Assuming a general method would send this
        
      default:
        // Handle unknown or missing types gracefully.
        // sessionReminder is a good default for general exam-related notices.
        return NotificationType.sessionReminder; 
    }
  }
}

extension NotificationTypeExtension on NotificationType {
  
  /// Get user-friendly display name
  String get displayName {
    switch (this) {
      case NotificationType.sessionStart:
        return 'Session Started';
      case NotificationType.sessionReminder:
        return 'Session Reminder';
      case NotificationType.sessionExpiring:
        return 'Session Expiring';
      case NotificationType.sessionPause:
        return 'Session Paused';
      case NotificationType.sessionResume:
        return 'Session Resumed';
      case NotificationType.sessionComplete:
        return 'Session Complete';
      case NotificationType.achievementUnlocked:
        return 'Achievement';
      case NotificationType.leaderboardUpdate:
        return 'Leaderboard';
      case NotificationType.streakReminder:
        return 'Streak';
      case NotificationType.dailyGoal:
        return 'Daily Goal';
      case NotificationType.weeklyReport:
        return 'Weekly Report';
      case NotificationType.aiInsight:
        return 'AI Insight';
      case NotificationType.examTip:
        return 'Study Tip';
      case NotificationType.appUpdate:
        return 'App Update';
      case NotificationType.settingsChange:
        return 'Settings';
      case NotificationType.featureAnnouncement:
        return 'New Feature';
      case NotificationType.motivational:
        return 'Motivation';
      case NotificationType.communityUpdate:
        return 'Community';
      case NotificationType.emergencyAlert:
        return 'Alert';
    }
  }

  /// Get icon for notification type
  IconData get icon {
    switch (this) {
      case NotificationType.sessionStart:
        return Icons.play_circle;
      case NotificationType.sessionReminder:
        return Icons.notification_important;
      case NotificationType.sessionExpiring:
        return Icons.timer;
      case NotificationType.sessionPause:
        return Icons.pause_circle;
      case NotificationType.sessionResume:
        return Icons.play_arrow;
      case NotificationType.sessionComplete:
        return Icons.check_circle;
      case NotificationType.achievementUnlocked:
        return Icons.emoji_events;
      case NotificationType.leaderboardUpdate:
        return Icons.leaderboard;
      case NotificationType.streakReminder:
        return Icons.local_fire_department;
      case NotificationType.dailyGoal:
        return Icons.flag;
      case NotificationType.weeklyReport:
        return Icons.assessment;
      case NotificationType.aiInsight:
        return Icons.psychology;
      case NotificationType.examTip:
        return Icons.lightbulb;
      case NotificationType.appUpdate:
        return Icons.system_update;
      case NotificationType.settingsChange:
        return Icons.settings;
      case NotificationType.featureAnnouncement:
        return Icons.new_releases;
      case NotificationType.motivational:
        return Icons.favorite;
      case NotificationType.communityUpdate:
        return Icons.people;
      case NotificationType.emergencyAlert:
        return Icons.warning;
    }
  }

  /// Get color for notification type
  Color get color {
    switch (this) {
      case NotificationType.sessionStart:
      case NotificationType.sessionReminder:
      case NotificationType.sessionExpiring:
        return Colors.blue;
      case NotificationType.sessionPause:
        return Colors.orange;
      case NotificationType.sessionResume:
        return Colors.green;
      case NotificationType.sessionComplete:
        return Colors.teal;
      case NotificationType.achievementUnlocked:
        return Colors.amber;
      case NotificationType.leaderboardUpdate:
        return Colors.purple;
      case NotificationType.streakReminder:
        return Colors.deepOrange;
      case NotificationType.dailyGoal:
        return Colors.lightGreen;
      case NotificationType.weeklyReport:
        return Colors.indigo;
      case NotificationType.aiInsight:
        return Colors.cyan;
      case NotificationType.examTip:
        return Colors.yellow[700]!;
      case NotificationType.appUpdate:
        return Colors.blueGrey;
      case NotificationType.settingsChange:
        return Colors.grey;
      case NotificationType.featureAnnouncement:
        return Colors.pink;
      case NotificationType.motivational:
        return Colors.red;
      case NotificationType.communityUpdate:
        return Colors.blue[800]!;
      case NotificationType.emergencyAlert:
        return Colors.red[900]!;
    }
  }

  /// Get category for grouping
  NotificationCategory get category {
    switch (this) {
      case NotificationType.sessionStart:
      case NotificationType.sessionReminder:
      case NotificationType.sessionExpiring:
      case NotificationType.sessionPause:
      case NotificationType.sessionResume:
      case NotificationType.sessionComplete:
        return NotificationCategory.exams;
      
      case NotificationType.achievementUnlocked:
      case NotificationType.leaderboardUpdate:
      case NotificationType.streakReminder:
      case NotificationType.dailyGoal:
        return NotificationCategory.achievements;
      
      case NotificationType.weeklyReport:
      case NotificationType.aiInsight:
      case NotificationType.examTip:
        return NotificationCategory.insights;
      
      case NotificationType.appUpdate:
      case NotificationType.settingsChange:
      case NotificationType.featureAnnouncement:
        return NotificationCategory.system;
      
      case NotificationType.motivational:
      case NotificationType.communityUpdate:
        return NotificationCategory.social;
      
      case NotificationType.emergencyAlert:
        return NotificationCategory.alerts;
    }
  }

  /// Check if notification is actionable
  bool get isActionable {
    switch (this) {
      case NotificationType.sessionStart:
      case NotificationType.sessionReminder:
      case NotificationType.sessionExpiring:
      case NotificationType.sessionPause:
      case NotificationType.dailyGoal:
      case NotificationType.streakReminder:
      case NotificationType.appUpdate:
        return true;
      default:
        return false;
    }
  }

  /// Get priority level
  int get priorityLevel {
    switch (this) {
      case NotificationType.emergencyAlert:
        return 5;
      case NotificationType.sessionExpiring:
      case NotificationType.appUpdate:
        return 4;
      case NotificationType.sessionStart:
      case NotificationType.sessionComplete:
      case NotificationType.achievementUnlocked:
        return 3;
      case NotificationType.sessionReminder:
      case NotificationType.leaderboardUpdate:
      case NotificationType.streakReminder:
      case NotificationType.dailyGoal:
        return 2;
      default:
        return 1;
    }
  }

  /// Get emoji for notification
  String get emoji {
    switch (this) {
      case NotificationType.sessionStart:
        return '🚀';
      case NotificationType.sessionReminder:
        return '⏰';
      case NotificationType.sessionExpiring:
        return '⏱️';
      case NotificationType.sessionPause:
        return '⏸️';
      case NotificationType.sessionResume:
        return '▶️';
      case NotificationType.sessionComplete:
        return '✅';
      case NotificationType.achievementUnlocked:
        return '🏆';
      case NotificationType.leaderboardUpdate:
        return '📊';
      case NotificationType.streakReminder:
        return '🔥';
      case NotificationType.dailyGoal:
        return '🎯';
      case NotificationType.weeklyReport:
        return '📈';
      case NotificationType.aiInsight:
        return '🤖';
      case NotificationType.examTip:
        return '💡';
      case NotificationType.appUpdate:
        return '🆕';
      case NotificationType.settingsChange:
        return '⚙️';
      case NotificationType.featureAnnouncement:
        return '✨';
      case NotificationType.motivational:
        return '💪';
      case NotificationType.communityUpdate:
        return '👥';
      case NotificationType.emergencyAlert:
        return '⚠️';
    }
  }
}

/// Notification categories for grouping
enum NotificationCategory {
  exams,
  achievements,
  insights,
  system,
  social,
  alerts,
  all,
}

extension NotificationCategoryExtension on NotificationCategory {
  String get displayName {
    switch (this) {
      case NotificationCategory.exams:
        return 'Exams';
      case NotificationCategory.achievements:
        return 'Progress & Analytics';
      case NotificationCategory.insights:
        return 'AI Insights';
      case NotificationCategory.system:
        return 'System Updates / Announcements';
      case NotificationCategory.social:
        return 'Social';
      case NotificationCategory.alerts:
        return 'Alerts';
      case NotificationCategory.all:
        return 'All';
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationCategory.exams:
        return Icons.assignment;
      case NotificationCategory.achievements:
        return Icons.emoji_events;
      case NotificationCategory.insights:
        return Icons.lightbulb;
      case NotificationCategory.system:
        return Icons.settings;
      case NotificationCategory.social:
        return Icons.people;
      case NotificationCategory.alerts:
        return Icons.warning;
      case NotificationCategory.all:
        return Icons.all_inclusive;
    }
  }

  /// Get notification types in this category
  List<NotificationType> get types {
    switch (this) {
      case NotificationCategory.exams:
        return [
          NotificationType.sessionStart,
          NotificationType.sessionReminder,
          NotificationType.sessionExpiring,
          NotificationType.sessionPause,
          NotificationType.sessionResume,
          NotificationType.sessionComplete,
        ];
      case NotificationCategory.achievements:
        return [
          NotificationType.achievementUnlocked,
          NotificationType.leaderboardUpdate,
          NotificationType.streakReminder,
          NotificationType.dailyGoal,
        ];
      case NotificationCategory.insights:
        return [
          NotificationType.weeklyReport,
          NotificationType.aiInsight,
          NotificationType.examTip,
        ];
      case NotificationCategory.system:
        return [
          NotificationType.appUpdate,
          NotificationType.settingsChange,
          NotificationType.featureAnnouncement,
        ];
      case NotificationCategory.social:
        return [
          NotificationType.motivational,
          NotificationType.communityUpdate,
        ];
      case NotificationCategory.alerts:
        return [
          NotificationType.emergencyAlert,
        ];
      case NotificationCategory.all:
        return NotificationType.values;
    }
  }
}
