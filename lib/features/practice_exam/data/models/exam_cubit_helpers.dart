
import 'package:ahiaa_web/core/services/streak_service.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';

class GlobalTimeMetrics {
  final int totalSessions;
  final int completedSessions;
  final int inProgressSessions;
  final Duration totalTimeSpent;
  final Duration totalTimeLimit;
  final Duration totalTimeRemaining;
  final Duration averageTimePerSession;
  final double totalTimeUsedPercentage;
  final String formattedTotalTimeSpent;
  final String formattedTotalTimeLimit;
  final String formattedAverageTime;

  GlobalTimeMetrics({
    required this.totalSessions,
    required this.completedSessions,
    required this.inProgressSessions,
    required this.totalTimeSpent,
    required this.totalTimeLimit,
    required this.totalTimeRemaining,
    required this.averageTimePerSession,
    required this.totalTimeUsedPercentage,
    required this.formattedTotalTimeSpent,
    required this.formattedTotalTimeLimit,
    required this.formattedAverageTime,
  });

  factory GlobalTimeMetrics.zero() => GlobalTimeMetrics(
        totalSessions: 0,
        completedSessions: 0,
        inProgressSessions: 0,
        totalTimeSpent: Duration.zero,
        totalTimeLimit: Duration.zero,
        totalTimeRemaining: Duration.zero,
        averageTimePerSession: Duration.zero,
        totalTimeUsedPercentage: 0.0,
        formattedTotalTimeSpent: "0m",
        formattedTotalTimeLimit: "0m",
        formattedAverageTime: "0m",
      );
}

// ============================================================================
// HELPER DATA CLASS (Add to a common file or at the end of exam_cubit.dart)
// ============================================================================

class ExamStatisticsSummary {
  final int totalSessions;
  final int completedSessions;
  final int inProgressSessions;
  final int pausedSessions;
  final int abandonedSessions;
  final int totalTimeSpentMinutes;
  final int totalQuestionsAttempted;
  final double averageSessionDuration;

  ExamStatisticsSummary({
    required this.totalSessions,
    required this.completedSessions,
    required this.inProgressSessions,
    required this.pausedSessions,
    required this.abandonedSessions,
    required this.totalTimeSpentMinutes,
    required this.totalQuestionsAttempted,
    required this.averageSessionDuration,
  });

  /// Get formatted total time
  String get formattedTotalTime {
    final hours = totalTimeSpentMinutes ~/ 60;
    final minutes = totalTimeSpentMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  /// Get formatted average duration
  String get formattedAverageDuration {
    final avgMinutes = averageSessionDuration.round();
    final hours = avgMinutes ~/ 60;
    final minutes = avgMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}


class StreakCardData {
  final int currentStreak;
  final bool hasStreak;
  final String message;
  final bool isActive;

  StreakCardData({
    required this.currentStreak,
    required this.hasStreak,
    required this.message,
    required this.isActive,
  });
}

class MonthlyGridData {
  final int activeDays;
  final int totalDays;
  final String month;
  final List<DayActivity> days;
  final String message;

  MonthlyGridData({
    required this.activeDays,
    required this.totalDays,
    required this.month,
    required this.days,
    required this.message,
  });
}



/// Information about active session
class ActiveSessionInfo {
  final ExamSession session;
  final bool isInProgress;
  final bool isPaused;
  final Duration timeSpent;
  final Duration timeRemaining;
  final int questionsAnswered;
  final int totalQuestions;
  final double progressPercentage;

  ActiveSessionInfo({
    required this.session,
    required this.isInProgress,
    required this.isPaused,
    required this.timeSpent,
    required this.timeRemaining,
    required this.questionsAnswered,
    required this.totalQuestions,
    required this.progressPercentage,
  });

  String get statusText => isInProgress ? 'In Progress' : 'Paused';
  
  String get timeRemainingFormatted {
    final hours = timeRemaining.inHours;
    final minutes = timeRemaining.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m remaining';
    } else {
      return '${minutes}m remaining';
    }
  }

  String get progressText => 
      '$questionsAnswered / $totalQuestions answered (${progressPercentage.toStringAsFixed(1)}%)';
}

/// Sync status information
class SyncInfo {
  final bool hasActiveSession;
  final bool hasUnsyncedChanges;
  final bool isCurrentlySyncing;
  final DateTime? lastSyncTime;
  final int activeSessionCount;
  final bool canSync;

  SyncInfo({
    required this.hasActiveSession,
    required this.hasUnsyncedChanges,
    required this.isCurrentlySyncing,
    required this.lastSyncTime,
    required this.activeSessionCount,
    required this.canSync,
  });

  Duration? get timeSinceLastSync {
    if (lastSyncTime == null) return null;
    return DateTime.now().difference(lastSyncTime!);
  }

  String get statusMessage {
    if (isCurrentlySyncing) return 'Syncing...';
    if (!hasActiveSession) return 'No active session';
    if (!hasUnsyncedChanges) return 'All changes synced';
    return 'Changes pending sync';
  }
}

// ============================================================================
// STORAGE HELPER CLASSES (Add to end of exam_cubit.dart)
// ============================================================================

/// Storage information
class StorageInfo {
  final bool hasData;
  final int sessionCount;
  final int storageSize;
  final DateTime? lastModified;

  StorageInfo({
    required this.hasData,
    required this.sessionCount,
    required this.storageSize,
    this.lastModified,
  });

  String get formattedSize {
    if (storageSize < 1024) {
      return '$storageSize B';
    } else if (storageSize < 1024 * 1024) {
      return '${(storageSize / 1024).toStringAsFixed(2)} KB';
    } else {
      return '${(storageSize / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
  }

  @override
  String toString() {
    return 'StorageInfo(hasData: $hasData, sessions: $sessionCount, '
        'size: $formattedSize, lastModified: $lastModified)';
  }
}

/// Validation result
class ValidationResult {
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;

  ValidationResult({
    required this.isValid,
    required this.errors,
    required this.warnings,
  });

  bool get hasErrors => errors.isNotEmpty;
  bool get hasWarnings => warnings.isNotEmpty;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('ValidationResult(isValid: $isValid)');
    
    if (errors.isNotEmpty) {
      buffer.writeln('Errors:');
      for (final error in errors) {
        buffer.writeln('  - $error');
      }
    }
    
    if (warnings.isNotEmpty) {
      buffer.writeln('Warnings:');
      for (final warning in warnings) {
        buffer.writeln('  - $warning');
      }
    }
    
    return buffer.toString();
  }
}


/// Filter options for leaderboard queries
class LeaderboardFilter {
  final double? minScore;
  final double? maxScore;
  final int? minExamsCompleted;
  final List<String>? userIds; // For filtering friends/specific users
  final String? searchQuery; // For searching by display name
  final DateTime? startDate; // Filter by last updated date
  final DateTime? endDate;
  final int? minRank; // Filter by rank range
  final int? maxRank;
  final LeaderboardSortBy? sortBy;
  final bool sortDescending;
  final int? customLimit;

  const LeaderboardFilter({
    this.minScore,
    this.maxScore,
    this.minExamsCompleted,
    this.userIds,
    this.searchQuery,
    this.startDate,
    this.endDate,
    this.minRank,
    this.maxRank,
    this.sortBy,
    this.sortDescending = true,
    this.customLimit,
  });

  /// Create filter for top performers only
  factory LeaderboardFilter.topPerformers({int limit = 10}) {
    return LeaderboardFilter(
      minScore: 70.0,
      customLimit: limit,
      sortBy: LeaderboardSortBy.score,
    );
  }

  /// Create filter for active users (updated in last N days)
  factory LeaderboardFilter.activeUsers({int days = 7}) {
    return LeaderboardFilter(
      startDate: DateTime.now().subtract(Duration(days: days)),
      sortBy: LeaderboardSortBy.lastUpdated,
    );
  }

  /// Create filter for specific score range
  factory LeaderboardFilter.scoreRange({
    required double min,
    required double max,
  }) {
    return LeaderboardFilter(
      minScore: min,
      maxScore: max,
    );
  }

  /// Create filter for friends
  factory LeaderboardFilter.friends(List<String> friendIds) {
    return LeaderboardFilter(
      userIds: friendIds,
    );
  }

  /// Create filter for search
  factory LeaderboardFilter.search(String query) {
    return LeaderboardFilter(
      searchQuery: query,
    );
  }

  /// Copy with method for easy modification
  LeaderboardFilter copyWith({
    double? minScore,
    double? maxScore,
    int? minExamsCompleted,
    List<String>? userIds,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    int? minRank,
    int? maxRank,
    LeaderboardSortBy? sortBy,
    bool? sortDescending,
    int? customLimit,
  }) {
    return LeaderboardFilter(
      minScore: minScore ?? this.minScore,
      maxScore: maxScore ?? this.maxScore,
      minExamsCompleted: minExamsCompleted ?? this.minExamsCompleted,
      userIds: userIds ?? this.userIds,
      searchQuery: searchQuery ?? this.searchQuery,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      minRank: minRank ?? this.minRank,
      maxRank: maxRank ?? this.maxRank,
      sortBy: sortBy ?? this.sortBy,
      sortDescending: sortDescending ?? this.sortDescending,
      customLimit: customLimit ?? this.customLimit,
    );
  }
}



/// Complete leaderboard data with user info
class LeaderboardData {
  final List<LeaderboardEntry> entries;
  final LeaderboardRank userRank;
  final LeaderboardEntry? userEntry;
  final int totalUsers;
  final LeaderboardType type;
  final LeaderboardFilter? appliedFilter;

  LeaderboardData({
    required this.entries,
    required this.userRank,
    this.userEntry,
    required this.totalUsers,
    required this.type,
    this.appliedFilter,
  });

  /// Check if current user is in top 10
  bool get isUserInTopTen => userRank.rank <= 10;

  /// Check if current user is in top 100
  bool get isUserInTopHundred => userRank.rank <= 100;

  /// Get user's position text (e.g., "#1", "#15")
  String get userPositionText => '#${userRank.rank}';

  /// Get user's percentile text (e.g., "Top 5%")
  String get userPercentileText => 'Top ${userRank.percentile.toStringAsFixed(0)}%';

  /// Check if filter is applied
  bool get isFiltered => appliedFilter != null;

  /// Get filtered count vs total
  String get countSummary => '${entries.length} of $totalUsers users';
}
