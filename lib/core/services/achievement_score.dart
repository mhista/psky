// ============================================================================
// ACHIEVEMENT SERVICE
// ============================================================================

import 'package:ahiaa_web/core/services/exam_notification_service.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AchievementService {
  final FirebaseFirestore _firestore;
  final ExamNotificationService _notificationService;

  static const String _achievementsCollection = 'achievements';
  static const String _userAchievementsCollection = 'user_achievements';

  AchievementService(this._firestore, this._notificationService);

  /// Check and unlock achievements for a user
  Future<List<Achievement>> checkAchievements({
    required String userId,
    required List<ExamSession> sessions,
  }) async {
    try {
      final newlyUnlocked = <Achievement>[];

      // Check all achievement types
      newlyUnlocked.addAll(await _checkCompletionAchievements(userId, sessions));
      newlyUnlocked.addAll(await _checkAccuracyAchievements(userId, sessions));
      newlyUnlocked.addAll(await _checkStreakAchievements(userId, sessions));
      newlyUnlocked.addAll(await _checkSpeedAchievements(userId, sessions));
      newlyUnlocked.addAll(await _checkImprovementAchievements(userId, sessions));

      // Send notifications for new achievements
      for (final achievement in newlyUnlocked) {
        await _notificationService.sendAchievementNotification(
          userId: userId,
          achievement: achievement,
        );
      }

      return newlyUnlocked;
    } catch (e) {
      print('Error checking achievements: $e');
      return [];
    }
  }

  /// Get user's achievements
  Future<List<Achievement>> getUserAchievements(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_userAchievementsCollection)
          .doc(userId)
          .collection('unlocked')
          .orderBy('unlockedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Achievement.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting achievements: $e');
      return [];
    }
  }

  // ============================================================================
  // ACHIEVEMENT CHECKS
  // ============================================================================

  Future<List<Achievement>> _checkCompletionAchievements(
    String userId,
    List<ExamSession> sessions,
  ) async {
    final completed = sessions.where((s) => 
      s.status == ExamSessionStatus.completed
    ).toList();

    final achievements = <Achievement>[];

    // First exam
    if (completed.length == 1) {
      achievements.add(await _unlockAchievement(
        userId: userId,
        id: 'first_exam',
        title: 'Getting Started',
        description: 'Complete your first exam',
        category: AchievementCategory.completion,
        points: 10,
      ));
    }

    // Milestone achievements
    final milestones = [5, 10, 25, 50, 100];
    for (final milestone in milestones) {
      if (completed.length == milestone) {
        achievements.add(await _unlockAchievement(
          userId: userId,
          id: 'complete_$milestone',
          title: '$milestone Exams',
          description: 'Complete $milestone exams',
          category: AchievementCategory.completion,
          points: milestone * 2,
        ));
      }
    }

    return achievements;
  }

  Future<List<Achievement>> _checkAccuracyAchievements(
    String userId,
    List<ExamSession> sessions,
  ) async {
    final achievements = <Achievement>[];

    for (final session in sessions) {
      final score = _calculateScore(session);
      
      if (score == 100.0) {
        achievements.add(await _unlockAchievement(
          userId: userId,
          id: 'perfect_score_${session.examSessionId}',
          title: 'Perfect Score!',
          description: 'Score 100% on an exam',
          category: AchievementCategory.accuracy,
          points: 50,
        ));
      }
    }

    return achievements;
  }

  Future<List<Achievement>> _checkStreakAchievements(
    String userId,
    List<ExamSession> sessions,
  ) async {
    final streak = _calculateStreak(sessions);
    final achievements = <Achievement>[];

    final streakMilestones = [3, 7, 14, 30, 100];
    for (final milestone in streakMilestones) {
      if (streak == milestone) {
        achievements.add(await _unlockAchievement(
          userId: userId,
          id: 'streak_$milestone',
          title: '$milestone Day Streak',
          description: 'Study for $milestone consecutive days',
          category: AchievementCategory.streak,
          points: milestone * 5,
        ));
      }
    }

    return achievements;
  }

  Future<List<Achievement>> _checkSpeedAchievements(
    String userId,
    List<ExamSession> sessions,
  ) async {
    final achievements = <Achievement>[];

    for (final session in sessions) {
      if (session.progress == null) continue;

      final timeLimit = session.timeLimitMinutes;
      final timeUsed = session.progress!.timeElapsedMinutes;
      final percentageUsed = (timeUsed / timeLimit) * 100;

      // Complete exam using less than 50% of time
      if (percentageUsed < 50 && _calculateScore(session) >= 70) {
        achievements.add(await _unlockAchievement(
          userId: userId,
          id: 'speed_demon_${session.examSessionId}',
          title: 'Speed Demon',
          description: 'Complete exam in under half the time with 70%+ score',
          category: AchievementCategory.speed,
          points: 30,
        ));
      }
    }

    return achievements;
  }

  Future<List<Achievement>> _checkImprovementAchievements(
    String userId,
    List<ExamSession> sessions,
  ) async {
    if (sessions.length < 2) return [];

    final achievements = <Achievement>[];
    final sorted = sessions..sort((a, b) => a.startedAt!.compareTo(b.startedAt!));

    // Compare first and last sessions
    final firstScore = _calculateScore(sorted.first);
    final lastScore = _calculateScore(sorted.last);
    final improvement = lastScore - firstScore;

    if (improvement >= 20) {
      achievements.add(await _unlockAchievement(
        userId: userId,
        id: 'improvement_20',
        title: 'Rapid Growth',
        description: 'Improve your score by 20%+',
        category: AchievementCategory.improvement,
        points: 40,
      ));
    }

    return achievements;
  }

  // ============================================================================
  // HELPERS
  // ============================================================================

  Future<Achievement> _unlockAchievement({
    required String userId,
    required String id,
    required String title,
    required String description,
    required AchievementCategory category,
    required int points,
  }) async {
    final achievement = Achievement(
      id: id,
      title: title,
      description: description,
      category: category,
      points: points,
      unlockedAt: DateTime.now(),
    );

    await _firestore
        .collection(_userAchievementsCollection)
        .doc(userId)
        .collection('unlocked')
        .doc(id)
        .set(achievement.toJson());

    return achievement;
  }

  double _calculateScore(ExamSession session) {
    final correct = session.questions.where((q) {
      if (q.questionType == QuestionType.objective) {
        return q.selectedAnswer == q.correctAnswer;
      }
      return false;
    }).length;

    return session.questions.isEmpty 
        ? 0.0 
        : (correct / session.questions.length) * 100;
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
          break;
        }
      }

      lastDate = date;
    }

    return streak;
  }
}
