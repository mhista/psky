// ============================================================================
// LEADERBOARD ENTITIES
// ============================================================================
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_entities.freezed.dart';
part 'exam_entities.g.dart';

/// Leaderboard entry for a user
@freezed
abstract class LeaderboardEntry with _$LeaderboardEntry {
  const LeaderboardEntry._();

  const factory LeaderboardEntry({
    required String userId,
    required String displayName,
    String? avatarUrl,
    required double overallScore,
    required Map<String, double> subjectScores,
    required int totalExamsCompleted,
    required int totalQuestionsAnswered,
    required int totalCorrectAnswers,
    required DateTime lastUpdated,
    @Default(0) int streak,
    Map<String, dynamic>? metadata,
  }) = _LeaderboardEntry;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);
}

/// User's rank information
@freezed
abstract class LeaderboardRank with _$LeaderboardRank {
  const LeaderboardRank._();

  const factory LeaderboardRank({
    required int rank,
    required int totalUsers,
    required double percentile,
  }) = _LeaderboardRank;

  factory LeaderboardRank.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardRankFromJson(json);
}

/// User exam statistics
@freezed
abstract class UserExamStatistics with _$UserExamStatistics {
  const UserExamStatistics._();

  const factory UserExamStatistics({
    required String userId,
    required int totalSessions,
    required int completedSessions,
    required double averageScore,
    required int totalTimeSpentMinutes,
    DateTime? lastActive,
  }) = _UserExamStatistics;

  factory UserExamStatistics.fromJson(Map<String, dynamic> json) =>
      _$UserExamStatisticsFromJson(json);
}

// ============================================================================
// OFFLINE OPERATION ENTITY
// ============================================================================

@freezed
abstract class OfflineOperation with _$OfflineOperation {
  const OfflineOperation._();
  const factory OfflineOperation({
    required String id,
    required OperationType type,
    required String userId,
    required Map<String, dynamic> data,
    required DateTime createdAt,
    @Default(0) int retryCount,
  }) = _OfflineOperation;

  factory OfflineOperation.fromJson(Map<String, dynamic> json) =>
      _$OfflineOperationFromJson(json);
}


// ============================================================================
// SYNC RESULT ENTITIES
// ============================================================================

/// Result of a sync operation
@freezed
abstract class SyncResult with _$SyncResult {
  const SyncResult._();

  const factory SyncResult({
    required bool success,
    required int sessionsSynced,
    required int sessionsSkipped,
    required DateTime syncTime,
    String? error,
    @Default([]) List<String> failedSessionIds,
  }) = _SyncResult;

  factory SyncResult.fromJson(Map<String, dynamic> json) =>
      _$SyncResultFromJson(json);
}

/// Sync status information
@freezed
abstract class SyncStatus with _$SyncStatus {
  const SyncStatus._();

  const factory SyncStatus({
    required bool isSyncing,
    required bool hasUnsyncedChanges,
    DateTime? lastSyncTime,
    int? unsyncedCount,
  }) = _SyncStatus;

  factory SyncStatus.fromJson(Map<String, dynamic> json) =>
      _$SyncStatusFromJson(json);
}

// ============================================================================
// BATCH OPERATION ENTITIES
// ============================================================================

/// Result of a batch operation
@freezed
abstract class BatchOperationResult with _$BatchOperationResult {
  const BatchOperationResult._();

  const factory BatchOperationResult({
    required int total,
    required int successful,
    required int failed,
    @Default([]) List<String> failedIds,
    @Default([]) List<String> errorMessages,
  }) = _BatchOperationResult;

  factory BatchOperationResult.fromJson(Map<String, dynamic> json) =>
      _$BatchOperationResultFromJson(json);
}

// ============================================================================
// QUERY FILTER ENTITIES
// ============================================================================

/// Filters for querying exam sessions
@freezed
abstract class ExamSessionFilter with _$ExamSessionFilter {
  const ExamSessionFilter._();

  const factory ExamSessionFilter({
    ExamSessionStatus? status,
    String? subjectId,
    ExamBody? examBody,
    DateTime? startDate,
    DateTime? endDate,
    int? minScore,
    int? maxScore,
    int? limit,
    int? offset,
  }) = _ExamSessionFilter;

  factory ExamSessionFilter.fromJson(Map<String, dynamic> json) =>
      _$ExamSessionFilterFromJson(json);
}

/// Sort options for queries
enum SortField {
  startedAt,
  completedAt,
  score,
  timeSpent,
}

enum SortOrder {
  ascending,
  descending,
}

@freezed
abstract class QuerySort with _$QuerySort {
  const QuerySort._();

  const factory QuerySort({
    required SortField field,
    @Default(SortOrder.descending) SortOrder order,
  }) = _QuerySort;

  factory QuerySort.fromJson(Map<String, dynamic> json) =>
      _$QuerySortFromJson(json);
}

// ============================================================================
// ANALYTICS ENTITIES
// ============================================================================

/// Performance analytics for a user
@freezed
abstract class PerformanceAnalytics with _$PerformanceAnalytics {
  const PerformanceAnalytics._();

  const factory PerformanceAnalytics({
    required String userId,
    required double averageScore,
    required double scoreImprovement,
    required Map<String, double> subjectPerformance,
    required Map<String, int> topicWeaknesses,
    required List<String> strongSubjects,
    required List<String> weakSubjects,
    required int currentStreak,
    required int longestStreak,
    DateTime? lastStudyDate,
    @Default({}) Map<String, dynamic> insights,
  }) = _PerformanceAnalytics;

  factory PerformanceAnalytics.fromJson(Map<String, dynamic> json) =>
      _$PerformanceAnalyticsFromJson(json);
}

/// Time-based statistics
@freezed
abstract class TimeStatistics with _$TimeStatistics {
  const TimeStatistics._();

  const factory TimeStatistics({
    required int totalMinutes,
    required double averageMinutesPerSession,
    required Map<String, int> subjectTimeDistribution,
    required List<StudyTimeEntry> dailyStudyTime,
    String? mostProductiveHour,
  }) = _TimeStatistics;

  factory TimeStatistics.fromJson(Map<String, dynamic> json) =>
      _$TimeStatisticsFromJson(json);
}

@freezed
abstract class StudyTimeEntry with _$StudyTimeEntry {
  const StudyTimeEntry._();

  const factory StudyTimeEntry({
    required DateTime date,
    required int minutes,
    required int sessionsCount,
  }) = _StudyTimeEntry;

  factory StudyTimeEntry.fromJson(Map<String, dynamic> json) =>
      _$StudyTimeEntryFromJson(json);
}

// ============================================================================
// NOTIFICATION ENTITIES
// ============================================================================

/// Notification payload
@freezed
abstract class ExamNotification with _$ExamNotification {
  const ExamNotification._();

  const factory ExamNotification({
    required String id,
    required String userId,
    required NotificationType type,
    required String title,
    required String body,
    Map<String, dynamic>? data,
    required DateTime createdAt,
    @Default(false) bool isRead,
    DateTime? scheduledFor,
    @Default(NotificationPriority.normal) NotificationPriority priority,
  }) = _ExamNotification;

  factory ExamNotification.fromJson(Map<String, dynamic> json) =>
      _$ExamNotificationFromJson(json);
}

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

/// Notification preferences
@freezed
abstract class NotificationPreferences with _$NotificationPreferences {
  const NotificationPreferences._();

  const factory NotificationPreferences({
    @Default(true) bool sessionReminders,
    @Default(true) bool achievementNotifications,
    @Default(true) bool leaderboardUpdates,
    @Default(true) bool streakReminders,
    @Default(false) bool dailyGoals,
    @Default(true) bool weeklyReports,
    @Default(true) bool examTips,
    @Default(true) bool aiInsights,
    @Default(true) bool appUpdates,
    @Default(true) bool settingsNotifications,
    @Default(true) bool featureAnnouncements,
    @Default(false) bool motivationalMessages,
    @Default(true) bool studyTips,
    @Default(true) bool communityUpdates,
    @Default(NotificationFrequency.normal) NotificationFrequency frequency,
    @Default([]) List<int> quietHours, // Hours when not to send (0-23)
  }) = _NotificationPreferences;

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesFromJson(json);
}

enum NotificationFrequency {
  minimal,
  normal,
  frequent,
}

// ============================================================================
// ACHIEVEMENT ENTITIES
// ============================================================================

/// User achievement
@freezed
abstract class Achievement with _$Achievement {
  const Achievement._();

  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required AchievementCategory category,
    required int points,
    String? iconUrl,
    required DateTime unlockedAt,
    Map<String, dynamic>? metadata,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
}

enum AchievementCategory {
  completion,
  accuracy,
  streak,
  speed,
  improvement,
  mastery,
  consistency,
}

/// Achievement progress
@freezed
abstract class AchievementProgress with _$AchievementProgress {
  const AchievementProgress._();

  const factory AchievementProgress({
    required String achievementId,
    required int current,
    required int target,
    @Default(false) bool isUnlocked,
  }) = _AchievementProgress;

  factory AchievementProgress.fromJson(Map<String, dynamic> json) =>
      _$AchievementProgressFromJson(json);
}