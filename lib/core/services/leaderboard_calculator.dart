// ============================================================================
// LEADERBOARD CALCULATOR SERVICE
// ============================================================================

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/datasources/firebase_exam_satasource.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:ahiaa_web/features/practice_exam/domain/repository/exam_repository.dart';
import 'package:injectable/injectable.dart';

/// Service for calculating and updating leaderboard entries
@lazySingleton
class LeaderboardCalculator {
  final FirebaseExamDataSource _dataSource;
  final ExamRepository _repository;

  LeaderboardCalculator(this._dataSource, this._repository);

  /// Calculate and update leaderboard entry for a user
  Future<LeaderboardEntry> calculateLeaderboardEntry({
    required String userId,
    required String displayName,
    String? avatarUrl,
  }) async {
    try {
      // Get all completed sessions
      final sessions = await _repository.getSessions(
        userId: userId,
        filter: const ExamSessionFilter(status: ExamSessionStatus.completed),
      );

      if (sessions.isEmpty) {
        return LeaderboardEntry(
          userId: userId,
          displayName: displayName,
          avatarUrl: avatarUrl,
          overallScore: 0,
          subjectScores: {},
          totalExamsCompleted: 0,
          totalQuestionsAnswered: 0,
          totalCorrectAnswers: 0,
          lastUpdated: DateTime.now(),
          metadata: {'session':sessions.map((s)=>s.toJson()).toList()}
        );
      }

      // Calculate overall statistics
      final totalQuestions = sessions.fold<int>(
        0,
        (sum, s) => sum + s.questions.length,
      );

      final totalCorrect = sessions.fold<int>(
        0,
        (sum, s) => sum + _countCorrectAnswers(s),
      );

      final overallScore = totalQuestions > 0 
          ? (totalCorrect / totalQuestions) * 100
          : 0.0;

      // Calculate subject scores
      final subjectScores = <String, double>{};
      final subjectGroups = _groupBySubject(sessions);

      for (final entry in subjectGroups.entries) {
        final subjectSessions = entry.value;
        final questions = subjectSessions.fold<int>(
          0,
          (sum, s) => sum + s.questions.length,
        );
        final correct = subjectSessions.fold<int>(
          0,
          (sum, s) => sum + _countCorrectAnswers(s),
        );

        subjectScores[entry.key] = questions > 0 
            ? (correct / questions) * 100
            : 0.0;
      }

      // Calculate streak
      final streak = _calculateStreak(sessions);

      final entry = LeaderboardEntry(
        userId: userId,
        displayName: displayName,
        avatarUrl: avatarUrl,
        overallScore: overallScore,
        subjectScores: subjectScores,
        totalExamsCompleted: sessions.length,
        totalQuestionsAnswered: totalQuestions,
        totalCorrectAnswers: totalCorrect,
        lastUpdated: DateTime.now(),
        streak: streak,
      );

      // Update in Firestore
      await _dataSource.updateLeaderboardEntry(
        userId: userId,
        entry: entry,
      );

      return entry;
    } catch (e) {
      throw Exception('Failed to calculate leaderboard entry: $e');
    }
  }

  /// Batch update leaderboard for multiple users (admin function)
  Future<BatchOperationResult> batchUpdateLeaderboard({
    required List<String> userIds,
  }) async {
    final results = <String, bool>{};
    final errors = <String>[];

    for (final userId in userIds) {
      try {
        await calculateLeaderboardEntry(
          userId: userId,
          displayName: 'User $userId', // Should fetch from user profile
        );
        results[userId] = true;
      } catch (e) {
        results[userId] = false;
        errors.add('User $userId: $e');
      }
    }

    final successful = results.values.where((v) => v).length;
    final failed = results.values.where((v) => !v).length;

    return BatchOperationResult(
      total: userIds.length,
      successful: successful,
      failed: failed,
      failedIds: results.entries
          .where((e) => !e.value)
          .map((e) => e.key)
          .toList(),
      errorMessages: errors,
    );
  }

  // ============================================================================
  // HELPERS
  // ============================================================================

  int _countCorrectAnswers(ExamSession session) {
    return session.questions.where((q) {
      if (q.questionType == QuestionType.objective) {
        return q.selectedAnswer == q.correctAnswer;
      }
      return false; // Essay questions require manual grading
    }).length;
  }

  Map<String, List<ExamSession>> _groupBySubject(List<ExamSession> sessions) {
    final groups = <String, List<ExamSession>>{};
    
    for (final session in sessions) {
      groups.putIfAbsent(session.subjectId, () => []).add(session);
    }

    return groups;
  }

  int _calculateStreak(List<ExamSession> sessions) {
    if (sessions.isEmpty) return 0;

    sessions.sort((a, b) => b.startedAt!.compareTo(a.startedAt!));

    int streak = 0;
    DateTime? lastDate;

    for (final session in sessions) {
      if (session.startedAt == null) continue;

      final date = DateTime(
        session.startedAt!.year,
        session.startedAt!.month,
        session.startedAt!.day,
      );

      if (lastDate == null) {
        streak = 1;
      } else {
        final difference = lastDate.difference(date).inDays;
        if (difference == 1) {
          streak++;
        } else if (difference > 1) {
          break; // Streak broken
        }
      }

      lastDate = date;
    }

    return streak;
  }
}
