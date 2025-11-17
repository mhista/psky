// ============================================================================
// EXAM REPOSITORY (Business Logic Layer)
// ============================================================================

import 'package:ahiaa_web/core/services/cache_manager.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/datasources/firebase_exam_satasource.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Repository for exam data operations
@lazySingleton
class ExamRepository {
  final FirebaseExamDataSource _dataSource;
  final ExamCacheManager _cacheManager;
  final SharedPreferences _prefs;

  ExamRepository(
    this._dataSource,
    this._cacheManager,
    this._prefs,
  );

  // ============================================================================
  // SESSION OPERATIONS
  // ============================================================================

  /// Save exam session with optimized caching
  Future<SyncResult> saveSession({
    required String userId,
    required ExamSession session,
  }) async {
    try {
      await _dataSource.saveExamSession(
        userId: userId,
        session: session,
      );

      return SyncResult(
        success: true,
        sessionsSynced: 1,
        sessionsSkipped: 0,
        syncTime: DateTime.now(),
      );
    } catch (e) {
      return SyncResult(
        success: false,
        sessionsSynced: 0,
        sessionsSkipped: 0,
        syncTime: DateTime.now(),
        error: e.toString(),
        failedSessionIds: [session.examSessionId],
      );
    }
  }

  /// Batch save sessions
  Future<SyncResult> batchSaveSessions({
    required String userId,
    required List<ExamSession> sessions,
  }) async {
    try {
      await _dataSource.batchSaveExamSessions(
        userId: userId,
        sessions: sessions,
      );

      return SyncResult(
        success: true,
        sessionsSynced: sessions.length,
        sessionsSkipped: 0,
        syncTime: DateTime.now(),
      );
    } catch (e) {
      return SyncResult(
        success: false,
        sessionsSynced: 0,
        sessionsSkipped: 0,
        syncTime: DateTime.now(),
        error: e.toString(),
        failedSessionIds: sessions.map((s) => s.examSessionId).toList(),
      );
    }
  }

  /// Get sessions with filtering
  Future<List<ExamSession>> getSessions({
    required String userId,
    ExamSessionFilter? filter,
    QuerySort? sort,
  }) async {
    return await _dataSource.getUserExamSessions(
      userId: userId,
      limit: filter?.limit,
      status: filter?.status,
      startDate: filter?.startDate,
      endDate: filter?.endDate,
    );
  }

  /// Get incomplete sessions
  Future<List<ExamSession>> getIncompleteSessions(String userId) async {
    return await _dataSource.getIncompleteSessions(userId: userId);
  }

  /// Delete session
  Future<void> deleteSession({
    required String userId,
    required String sessionId,
  }) async {
    await _dataSource.deleteExamSession(
      userId: userId,
      sessionId: sessionId,
    );
  }

  // ============================================================================
  // LEADERBOARD OPERATIONS
  // ============================================================================

  /// Update leaderboard entry
  Future<void> updateLeaderboard({
    required String userId,
    required LeaderboardEntry entry,
  }) async {
    await _dataSource.updateLeaderboardEntry(
      userId: userId,
      entry: entry,
    );
  }

  /// Get leaderboard
  Future<List<LeaderboardEntry>> getLeaderboard({
    int limit = 100,
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
  }) async {
    return await _dataSource.getGlobalLeaderboard(
      limit: limit,
      type: type,
      subjectId: subjectId,
    );
  }

  /// Get user rank
  Future<LeaderboardRank> getUserRank({
    required String userId,
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
  }) async {
    return await _dataSource.getUserRank(
      userId: userId,
      type: type,
      subjectId: subjectId,
    );
  }

  /// Stream leaderboard updates
  Stream<List<LeaderboardEntry>> streamLeaderboard({
    int limit = 50,
    LeaderboardType type = LeaderboardType.overall,
  }) {
    return _dataSource.streamLeaderboard(
      limit: limit,
      type: type,
    );
  }



/// Get leaderboard as Future with caching (non-streaming version)
Future<List<LeaderboardEntry>> getLeaderboardList({
  int limit = 100,
  LeaderboardType type = LeaderboardType.overall,
  String? subjectId,
  bool forceRefresh = false,
}) async {
  return await _dataSource.getLeaderboardList(
    limit: limit,
    type: type,
    subjectId: subjectId,
    forceRefresh: forceRefresh,
  );
}

/// Get leaderboard count with caching
Future<int> getLeaderboardCount({bool forceRefresh = false}) async {
  return await _dataSource.getLeaderboardCount(forceRefresh: forceRefresh);
}

/// Check if leaderboard has multiple users with caching
Future<bool> hasMultipleLeaderboardUsers({bool forceRefresh = false}) async {
  final count = await getLeaderboardCount(forceRefresh: forceRefresh);
  return count > 1;
}

/// Clear leaderboard cache (call when user completes exam)
void clearLeaderboardCache() {
  _dataSource.clearLeaderboardCache();
}

/// Clear specific cache entry
void clearLeaderboardCacheEntry(LeaderboardType type, String? subjectId) {
  _dataSource.clearLeaderboardCacheEntry(type, subjectId);
}



  // ============================================================================
  // ANALYTICS OPERATIONS
  // ============================================================================

  /// Calculate performance analytics
  Future<PerformanceAnalytics> getPerformanceAnalytics({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final sessions = await getSessions(
      userId: userId,
      filter: ExamSessionFilter(
        startDate: startDate,
        endDate: endDate,
        status: ExamSessionStatus.completed,
      ),
    );

    return _calculatePerformanceAnalytics(userId, sessions);
  }

  /// Get time statistics
  Future<TimeStatistics> getTimeStatistics({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final sessions = await getSessions(
      userId: userId,
      filter: ExamSessionFilter(
        startDate: startDate,
        endDate: endDate,
      ),
    );

    return _calculateTimeStatistics(sessions);
  }

  // ============================================================================
  // SYNC OPERATIONS
  // ============================================================================

  /// Check if sync is needed
  Future<bool> needsSync() async {
    return await _dataSource.needsSync();
  }

  /// Get sync status
  Future<SyncStatus> getSyncStatus() async {
    final lastSync = await _dataSource.getLastSyncTime();
    final needsSync = await _dataSource.needsSync();

    return SyncStatus(
      isSyncing: false,
      hasUnsyncedChanges: needsSync,
      lastSyncTime: lastSync,
    );
  }

  /// Clear sync cache
  Future<void> clearCache() async {
    await _dataSource.clearSyncCache();
  }

  // ============================================================================
  // PRIVATE HELPERS
  // ============================================================================

  PerformanceAnalytics _calculatePerformanceAnalytics(
    String userId,
    List<ExamSession> sessions,
  ) {
    if (sessions.isEmpty) {
      return PerformanceAnalytics(
        userId: userId,
        averageScore: 0,
        scoreImprovement: 0,
        subjectPerformance: {},
        topicWeaknesses: {},
        strongSubjects: [],
        weakSubjects: [],
        currentStreak: 0,
        longestStreak: 0, lastStudyDate: null,
      );
    }

    // Calculate average score
    final scores = sessions.map((s) => _calculateSessionScore(s)).toList();
    final averageScore = scores.reduce((a, b) => a + b) / scores.length;

    // Calculate improvement (first half vs second half)
    final midpoint = sessions.length ~/ 2;
    final firstHalfAvg = scores.take(midpoint).reduce((a, b) => a + b) / midpoint;
    final secondHalfAvg = scores.skip(midpoint).reduce((a, b) => a + b) / (sessions.length - midpoint);
    final improvement = secondHalfAvg - firstHalfAvg;

    // Group by subject
    final subjectPerformance = <String, double>{};
    final subjectGroups = <String, List<ExamSession>>{};
    
    for (final session in sessions) {
      subjectGroups.putIfAbsent(session.subjectId, () => []).add(session);
    }

    for (final entry in subjectGroups.entries) {
      final subjectScores = entry.value.map((s) => _calculateSessionScore(s)).toList();
      final avg = subjectScores.reduce((a, b) => a + b) / subjectScores.length;
      subjectPerformance[entry.key] = avg;
    }

    // Identify strong and weak subjects
    final sortedSubjects = subjectPerformance.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final strongSubjects = sortedSubjects
        .take(3)
        .where((e) => e.value >= 70)
        .map((e) => e.key)
        .toList();

    final weakSubjects = sortedSubjects
        .where((e) => e.value < 50)
        .map((e) => e.key)
        .toList();

    // Calculate streak
    final streak = _calculateStreak(sessions);

    return PerformanceAnalytics(
      userId: userId,
      averageScore: averageScore,
      scoreImprovement: improvement,
      subjectPerformance: subjectPerformance,
      topicWeaknesses: {},
      strongSubjects: strongSubjects,
      weakSubjects: weakSubjects,
      currentStreak: streak.current,
      longestStreak: streak.longest,
      lastStudyDate: sessions.first.startedAt,
    );
  }

  TimeStatistics _calculateTimeStatistics(List<ExamSession> sessions) {
    if (sessions.isEmpty) {
      return const TimeStatistics(
        totalMinutes: 0,
        averageMinutesPerSession: 0,
        subjectTimeDistribution: {},
        dailyStudyTime: [],
      );
    }

    final totalMinutes = sessions.fold<int>(
      0,
      (sum, s) => sum + (s.progress?.timeElapsedMinutes ?? 0),
    );

    final averageMinutes = totalMinutes / sessions.length;

    // Group by subject
    final subjectTime = <String, int>{};
    for (final session in sessions) {
      final time = session.progress?.timeElapsedMinutes ?? 0;
      subjectTime[session.subjectId] = (subjectTime[session.subjectId] ?? 0) + time;
    }

    // Group by day
    final dailyTime = <DateTime, StudyTimeEntry>{};
    for (final session in sessions) {
      if (session.startedAt == null) continue;
      
      final date = DateTime(
        session.startedAt!.year,
        session.startedAt!.month,
        session.startedAt!.day,
      );

      final minutes = session.progress?.timeElapsedMinutes ?? 0;
      
      if (dailyTime.containsKey(date)) {
        final existing = dailyTime[date]!;
        dailyTime[date] = StudyTimeEntry(
          date: date,
          minutes: existing.minutes + minutes,
          sessionsCount: existing.sessionsCount + 1,
        );
      } else {
        dailyTime[date] = StudyTimeEntry(
          date: date,
          minutes: minutes,
          sessionsCount: 1,
        );
      }
    }

    return TimeStatistics(
      totalMinutes: totalMinutes,
      averageMinutesPerSession: averageMinutes,
      subjectTimeDistribution: subjectTime,
      dailyStudyTime: dailyTime.values.toList()
        ..sort((a, b) => b.date.compareTo(a.date)),
    );
  }

  double _calculateSessionScore(ExamSession session) {
    final correctAnswers = session.questions.where((q) {
      if (q.questionType == QuestionType.objective) {
        return q.selectedAnswer == q.correctAnswer;
      }
      return false;
    }).length;

    if (session.questions.isEmpty) return 0.0;
    
    return (correctAnswers / session.questions.length) * 100;
  }

  ({int current, int longest}) _calculateStreak(List<ExamSession> sessions) {
    if (sessions.isEmpty) return (current: 0, longest: 0);

    sessions.sort((a, b) => a.startedAt!.compareTo(b.startedAt!));

    int currentStreak = 0;
    int longestStreak = 0;
    DateTime? lastDate;

    for (final session in sessions) {
      if (session.startedAt == null) continue;

      final date = DateTime(
        session.startedAt!.year,
        session.startedAt!.month,
        session.startedAt!.day,
      );

      if (lastDate == null || date.difference(lastDate).inDays == 1) {
        currentStreak++;
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }
      } else if (date.difference(lastDate).inDays > 1) {
        currentStreak = 1;
      }

      lastDate = date;
    }

    return (current: currentStreak, longest: longestStreak);
  }
}
