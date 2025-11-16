
import 'package:ahiaa_web/core/services/streak_service.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';

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