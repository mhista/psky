/// Calculate detailed performance metrics

import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/exam_question.dart';

/// Calculator for exam results, grades, and analytics
class ExamCalculator {
  static const int marksPerQuestion = 2;

  // ============================================================================
  // RESULT CALCULATION
  // ============================================================================

  /// Calculate complete exam result
  static ExamResult calculateResult(ExamSession session) {
    final score = calculateScore(session.questions);
    final grade = calculateGrade(score.percentage);
    final weakAreas = identifyWeakAreas(session.questions);
    final performanceMetrics = calculatePerformanceMetrics(session);
    final topicBreakdown = getTopicBreakdown(session.questions);
    final difficultyAnalysis = getDifficultyAnalysis(session.questions);

    return ExamResult(
      examSession: session,
      score: score,
      grade: grade,
      weakAreas: weakAreas,
      performanceMetrics: performanceMetrics,
      topicBreakdown: topicBreakdown,
      difficultyAnalysis: difficultyAnalysis,
      completedAt: session.completedAt ?? DateTime.now(),
    );
  }

  /// Calculate score from questions
  static ExamScore calculateScore(List<ExamQuestion> questions) {
    int correct = 0;
    int incorrect = 0;
    int skipped = 0;
    int attempted = 0;

    for (final question in questions) {
      if (question.selectedAnswer != null && question.selectedAnswer!.isNotEmpty) {
        attempted++;
        if (question.selectedAnswer == question.correctAnswer) {
          correct++;
        } else {
          incorrect++;
        }
      } else {
        skipped++;
      }
    }

    final totalQuestions = questions.length;
    final totalMarks = totalQuestions * marksPerQuestion;
    final obtainedMarks = correct * marksPerQuestion;
    final percentage = totalQuestions > 0 ? (obtainedMarks / totalMarks) * 100 : 0.0;

    return ExamScore(
      totalQuestions: totalQuestions,
      correct: correct,
      incorrect: incorrect,
      skipped: skipped,
      attempted: attempted,
      totalMarks: totalMarks,
      obtainedMarks: obtainedMarks,
      percentage: percentage,
    );
  }

  /// Calculate grade based on percentage (Nigerian grading system)
  static ExamGrade calculateGrade(double percentage) {
    if (percentage >= 75) {
      return ExamGrade(
        grade: 'A1',
        description: 'Excellent',
        remarks: 'Outstanding performance! You have mastered the subject.',
        color: 0xFF4CAF50, // Green
      );
    } else if (percentage >= 70) {
      return ExamGrade(
        grade: 'B2',
        description: 'Very Good',
        remarks: 'Great job! You have a strong grasp of the material.',
        color: 0xFF66BB6A, // Light Green
      );
    } else if (percentage >= 65) {
      return ExamGrade(
        grade: 'B3',
        description: 'Good',
        remarks: 'Good work! Keep practicing to improve further.',
        color: 0xFF8BC34A, // Lime Green
      );
    } else if (percentage >= 60) {
      return ExamGrade(
        grade: 'C4',
        description: 'Credit',
        remarks: 'Satisfactory performance. Focus on weak areas.',
        color: 0xFF9CCC65, // Light Lime
      );
    } else if (percentage >= 55) {
      return ExamGrade(
        grade: 'C5',
        description: 'Credit',
        remarks: 'Decent performance. More practice recommended.',
        color: 0xFFCDDC39, // Lime
      );
    } else if (percentage >= 50) {
      return ExamGrade(
        grade: 'C6',
        description: 'Credit',
        remarks: 'You passed with credit. Work on weak areas.',
        color: 0xFFFFEB3B, // Yellow
      );
    } else if (percentage >= 45) {
      return ExamGrade(
        grade: 'D7',
        description: 'Pass',
        remarks: 'You passed, but more practice is needed.',
        color: 0xFFFFC107, // Amber
      );
    } else if (percentage >= 40) {
      return ExamGrade(
        grade: 'E8',
        description: 'Pass',
        remarks: 'Minimal pass. Significant improvement required.',
        color: 0xFFFF9800, // Orange
      );
    } else {
      return ExamGrade(
        grade: 'F9',
        description: 'Fail',
        remarks: 'More study and practice needed. Don\'t give up!',
        color: 0xFFF44336, // Red
      );
    }
  }

  // ============================================================================
  // WEAK AREAS IDENTIFICATION
  // ============================================================================

  /// Identify weak areas from questions
  static List<WeakArea> identifyWeakAreas(List<ExamQuestion> questions) {
    final Map<String, WeakAreaData> topicMap = {};

    for (final question in questions) {
      final topicId = question.topicId;
      
      // Initialize topic data if not exists
      if (!topicMap.containsKey(topicId)) {
        topicMap[topicId] = WeakAreaData(
          topicId: topicId,
          totalQuestions: 0,
          incorrectQuestions: [],
          skippedQuestions: [],
        );
      }

      final data = topicMap[topicId]!;
      data.totalQuestions++;

      // Check if question was answered incorrectly
      if (question.selectedAnswer != null && 
          question.selectedAnswer!.isNotEmpty &&
          question.selectedAnswer != question.correctAnswer) {
        data.incorrectQuestions.add(question.questionId);
      }

      // Check if question was skipped
      if (question.selectedAnswer == null || question.selectedAnswer!.isEmpty) {
        data.skippedQuestions.add(question.questionId);
      }
    }

    // Convert to weak areas list (only topics with issues)
    final weakAreas = <WeakArea>[];
    topicMap.forEach((topicId, data) {
      final issueCount = data.incorrectQuestions.length + data.skippedQuestions.length;
      if (issueCount > 0) {
        final accuracyRate = data.totalQuestions > 0
            ? ((data.totalQuestions - issueCount) / data.totalQuestions) * 100
            : 0.0;

        weakAreas.add(WeakArea(
          topicId: topicId,
          topicName: topicId, // You can map this to actual topic names
          totalQuestions: data.totalQuestions,
          incorrectCount: data.incorrectQuestions.length,
          skippedCount: data.skippedQuestions.length,
          accuracyRate: accuracyRate,
          incorrectQuestionIds: data.incorrectQuestions,
          skippedQuestionIds: data.skippedQuestions,
          severity: _calculateSeverity(accuracyRate),
        ));
      }
    });

    // Sort by severity (worst first)
    weakAreas.sort((a, b) => a.accuracyRate.compareTo(b.accuracyRate));

    return weakAreas;
  }

  static WeakAreaSeverity _calculateSeverity(double accuracyRate) {
    if (accuracyRate < 40) return WeakAreaSeverity.critical;
    if (accuracyRate < 60) return WeakAreaSeverity.high;
    if (accuracyRate < 75) return WeakAreaSeverity.medium;
    return WeakAreaSeverity.low;
  }

  // ============================================================================
  // PERFORMANCE METRICS
  // ============================================================================

  /// Calculate detailed performance metrics
  static PerformanceMetrics calculatePerformanceMetrics(ExamSession session) {
    final questions = session.questions;
    final timeSpent = session.progress?.timeElapsedMinutes ?? 0;
    final score = calculateScore(questions);

    // Calculate average time per question
    final avgTimePerQuestion = score.attempted > 0
        ? timeSpent / score.attempted
        : 0.0;

    // Calculate completion rate
    final completionRate = questions.isNotEmpty
        ? (score.attempted / questions.length) * 100
        : 0.0;

    // Calculate accuracy (correct out of attempted)
    final accuracy = score.attempted > 0
        ? (score.correct / score.attempted) * 100
        : 0.0;

    // Calculate speed score (questions per minute)
    final speedScore = timeSpent > 0
        ? score.attempted / timeSpent
        : 0.0;

    // Calculate efficiency (correct answers per minute)
    final efficiency = timeSpent > 0
        ? score.correct / timeSpent
        : 0.0;

    return PerformanceMetrics(
      timeSpentMinutes: timeSpent,
      averageTimePerQuestion: avgTimePerQuestion,
      completionRate: completionRate,
      accuracy: accuracy,
      speedScore: speedScore,
      efficiency: efficiency,
      timeLimitMinutes: session.timeLimitMinutes,
      wasCompleted: completionRate >= 100,
      finishedEarly: timeSpent < session.timeLimitMinutes,
    );
  }

  // ============================================================================
  // TIME CALCULATIONS
  // ============================================================================

  /// Calculate time metrics for an exam session
  static TimeMetrics calculateTimeMetrics({
    required int timeLimitMinutes,
    required int timeElapsedMinutes,
  }) {
    final totalTimeSeconds = timeLimitMinutes * 60;
    final timeSpentSeconds = timeElapsedMinutes * 60;
    final timeRemainingSeconds = totalTimeSeconds - timeSpentSeconds;

    // Time remaining (capped at 0)
    final safeTimeRemaining = timeRemainingSeconds > 0 ? timeRemainingSeconds : 0;

    // Percentage of time used
    final timeUsedPercentage = totalTimeSeconds > 0
        ? (timeSpentSeconds / totalTimeSeconds) * 100
        : 0.0;

    // Time efficiency (0-100 scale, higher is better time management)
    final timeEfficiency = 100 - timeUsedPercentage;

    return TimeMetrics(
      totalTimeMinutes: timeLimitMinutes,
      totalTimeSeconds: totalTimeSeconds,
      timeSpentMinutes: timeElapsedMinutes,
      timeSpentSeconds: timeSpentSeconds,
      timeRemainingMinutes: (safeTimeRemaining / 60).ceil(),
      timeRemainingSeconds: safeTimeRemaining,
      timeUsedPercentage: timeUsedPercentage,
      timeEfficiency: timeEfficiency,
      isTimeUp: timeRemainingSeconds <= 0,
      formattedTotalTime: _formatTime(totalTimeSeconds),
      formattedTimeSpent: _formatTime(timeSpentSeconds),
      formattedTimeRemaining: _formatTime(safeTimeRemaining),
    );
  }

  /// Calculate time per question metrics
  static QuestionTimeMetrics calculateQuestionTimeMetrics({
    required int totalQuestions,
    required int timeSpentMinutes,
    required int questionsAttempted,
  }) {
    final timeSpentSeconds = timeSpentMinutes * 60;

    // Average time per question (all questions)
    final avgTimePerQuestion = totalQuestions > 0
        ? timeSpentSeconds / totalQuestions
        : 0.0;

    // Average time per attempted question
    final avgTimePerAttempted = questionsAttempted > 0
        ? timeSpentSeconds / questionsAttempted
        : 0.0;

    // Estimated time for unanswered questions
    final unansweredQuestions = totalQuestions - questionsAttempted;
    final estimatedTimeForRemaining = unansweredQuestions * avgTimePerAttempted;

    return QuestionTimeMetrics(
      totalQuestions: totalQuestions,
      questionsAttempted: questionsAttempted,
      questionsRemaining: unansweredQuestions,
      averageTimePerQuestion: avgTimePerQuestion,
      averageTimePerAttempted: avgTimePerAttempted,
      estimatedTimeForRemaining: estimatedTimeForRemaining,
      formattedAvgTime: _formatTime(avgTimePerQuestion.toInt()),
      formattedAvgAttemptedTime: _formatTime(avgTimePerAttempted.toInt()),
    );
  }

  /// Calculate time warnings and alerts
  static TimeAlerts calculateTimeAlerts({
    required int timeRemainingMinutes,
    required int questionsRemaining,
  }) {
    final alerts = <String>[];
    TimeUrgency urgency = TimeUrgency.normal;

    // Critical: Less than 5 minutes
    if (timeRemainingMinutes <= 5 && timeRemainingMinutes > 0) {
      urgency = TimeUrgency.critical;
      alerts.add('URGENT: Only ${timeRemainingMinutes} minutes remaining!');
    }

    // Warning: Less than 10 minutes
    if (timeRemainingMinutes <= 10 && timeRemainingMinutes > 5) {
      urgency = TimeUrgency.warning;
      alerts.add('Warning: ${timeRemainingMinutes} minutes left.');
    }

    // Time's up
    if (timeRemainingMinutes <= 0) {
      urgency = TimeUrgency.timeUp;
      alerts.add('Time\'s up! Please submit your exam.');
    }

    // Questions vs time warning
    if (questionsRemaining > 0 && timeRemainingMinutes > 0) {
      final timePerQuestion = timeRemainingMinutes / questionsRemaining;
      if (timePerQuestion < 1) {
        alerts.add('${questionsRemaining} questions remaining with limited time!');
      }
    }

    return TimeAlerts(
      alerts: alerts,
      urgency: urgency,
      hasAlerts: alerts.isNotEmpty,
    );
  }

  /// Format seconds to "HH:MM:SS" or "MM:SS"
  static String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
             '${minutes.toString().padLeft(2, '0')}:'
             '${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
             '${secs.toString().padLeft(2, '0')}';
    }
  }

  /// Format time to readable string (e.g., "1h 30m", "45m", "30s")
  static String formatTimeReadable(int seconds) {
    if (seconds <= 0) return '0s';

    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    final parts = <String>[];
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    if (secs > 0 && hours == 0) parts.add('${secs}s');

    return parts.join(' ');
  }

  /// Calculate pace (questions per minute)
  static double calculatePace({
    required int questionsAttempted,
    required int timeSpentMinutes,
  }) {
    if (timeSpentMinutes <= 0) return 0.0;
    return questionsAttempted / timeSpentMinutes;
  }

  /// Calculate projected completion time
  static int calculateProjectedTime({
    required int totalQuestions,
    required int questionsAttempted,
    required int timeSpentMinutes,
  }) {
    if (questionsAttempted <= 0) return 0;

    final avgTimePerQuestion = timeSpentMinutes / questionsAttempted;
    final remainingQuestions = totalQuestions - questionsAttempted;
    final projectedRemainingTime = remainingQuestions * avgTimePerQuestion;

    return (timeSpentMinutes + projectedRemainingTime).ceil();
  }

  // ============================================================================
  // TOPIC BREAKDOWN
  // ============================================================================

  /// Get breakdown of performance by topic
  static List<TopicPerformance> getTopicBreakdown(List<ExamQuestion> questions) {
    final Map<String, TopicPerformanceData> topicMap = {};

    for (final question in questions) {
      final topicId = question.topicId;
      
      if (!topicMap.containsKey(topicId)) {
        topicMap[topicId] = TopicPerformanceData(
          topicId: topicId,
          totalQuestions: 0,
          correct: 0,
          incorrect: 0,
          skipped: 0,
        );
      }

      final data = topicMap[topicId]!;
      data.totalQuestions++;

      if (question.selectedAnswer != null && question.selectedAnswer!.isNotEmpty) {
        if (question.selectedAnswer == question.correctAnswer) {
          data.correct++;
        } else {
          data.incorrect++;
        }
      } else {
        data.skipped++;
      }
    }

    // Convert to topic performance list
    final topicPerformances = <TopicPerformance>[];
    topicMap.forEach((topicId, data) {
      final totalMarks = data.totalQuestions * marksPerQuestion;
      final obtainedMarks = data.correct * marksPerQuestion;
      final percentage = data.totalQuestions > 0
          ? (obtainedMarks / totalMarks) * 100
          : 0.0;

      topicPerformances.add(TopicPerformance(
        topicId: topicId,
        topicName: topicId, // Map to actual topic names
        totalQuestions: data.totalQuestions,
        correct: data.correct,
        incorrect: data.incorrect,
        skipped: data.skipped,
        totalMarks: totalMarks,
        obtainedMarks: obtainedMarks,
        percentage: percentage,
      ));
    });

    // Sort by percentage (best first)
    topicPerformances.sort((a, b) => b.percentage.compareTo(a.percentage));

    return topicPerformances;
  }

  // ============================================================================
  // DIFFICULTY ANALYSIS
  // ============================================================================

  /// Analyze performance by difficulty level
  static DifficultyAnalysis getDifficultyAnalysis(List<ExamQuestion> questions) {
    final Map<String, DifficultyData> difficultyMap = {
      'easy': DifficultyData(level: 'easy', total: 0, correct: 0, incorrect: 0, skipped: 0),
      'medium': DifficultyData(level: 'medium', total: 0, correct: 0, incorrect: 0, skipped: 0),
      'hard': DifficultyData(level: 'hard', total: 0, correct: 0, incorrect: 0, skipped: 0),
    };

    for (final question in questions) {
      final level = question.difficultyLevel.toString().split('.').last.toLowerCase();
      
      if (difficultyMap.containsKey(level)) {
        final data = difficultyMap[level]!;
        data.total++;

        if (question.selectedAnswer != null && question.selectedAnswer!.isNotEmpty) {
          if (question.selectedAnswer == question.correctAnswer) {
            data.correct++;
          } else {
            data.incorrect++;
          }
        } else {
          data.skipped++;
        }
      }
    }

    return DifficultyAnalysis(
      easy: _createDifficultyBreakdown(difficultyMap['easy']!),
      medium: _createDifficultyBreakdown(difficultyMap['medium']!),
      hard: _createDifficultyBreakdown(difficultyMap['hard']!),
    );
  }

  static DifficultyBreakdown _createDifficultyBreakdown(DifficultyData data) {
    final accuracy = data.total > 0
        ? (data.correct / data.total) * 100
        : 0.0;

    return DifficultyBreakdown(
      totalQuestions: data.total,
      correct: data.correct,
      incorrect: data.incorrect,
      skipped: data.skipped,
      accuracy: accuracy,
    );
  }

  // ============================================================================
  // RECOMMENDATIONS
  // ============================================================================

  /// Generate study recommendations based on exam result
  static List<String> generateRecommendations(ExamResult result) {
    final recommendations = <String>[];

    // Based on overall performance
    if (result.score.percentage < 50) {
      recommendations.add('Focus on understanding fundamental concepts before attempting practice questions.');
      recommendations.add('Consider reviewing your study materials and notes thoroughly.');
    } else if (result.score.percentage < 70) {
      recommendations.add('You\'re making progress! Focus on weak areas to improve your score.');
      recommendations.add('Practice more questions in topics where you struggled.');
    }

    // Based on weak areas
    if (result.weakAreas.isNotEmpty) {
      final criticalAreas = result.weakAreas.where((w) => w.severity == WeakAreaSeverity.critical).toList();
      if (criticalAreas.isNotEmpty) {
        recommendations.add('URGENT: Focus on ${criticalAreas.length} critical weak area(s) immediately.');
      }
    }

    // Based on completion rate
    if (result.performanceMetrics.completionRate < 80) {
      recommendations.add('Work on time management - you didn\'t attempt ${result.score.skipped} questions.');
    }

    // Based on accuracy vs completion
    if (result.performanceMetrics.accuracy > 80 && result.performanceMetrics.completionRate < 100) {
      recommendations.add('You have good accuracy! Work on speed to complete all questions.');
    }

    // Based on difficulty analysis
    if (result.difficultyAnalysis.easy.accuracy < 80) {
      recommendations.add('Strengthen your basics - you\'re missing easy questions.');
    }

    if (result.difficultyAnalysis.hard.accuracy > result.difficultyAnalysis.easy.accuracy) {
      recommendations.add('Interesting! You perform better on hard questions. Review fundamentals.');
    }

    return recommendations;
  }

  // ============================================================================
  // MULTIPLE SESSIONS ANALYSIS
  // ============================================================================

  /// Calculate aggregate results for multiple exam sessions
  static AggregateExamResult calculateAggregateResult(List<ExamSession> sessions) {
    if (sessions.isEmpty) {
      return AggregateExamResult.empty();
    }

    // Calculate individual results
    final individualResults = sessions.map((session) => calculateResult(session)).toList();

    // Aggregate scores
    int totalQuestions = 0;
    int totalCorrect = 0;
    int totalIncorrect = 0;
    int totalSkipped = 0;
    int totalMarks = 0;
    int totalObtainedMarks = 0;
    int totalTimeSpent = 0;

    for (final result in individualResults) {
      totalQuestions += result.score.totalQuestions;
      totalCorrect += result.score.correct;
      totalIncorrect += result.score.incorrect;
      totalSkipped += result.score.skipped;
      totalMarks += result.score.totalMarks;
      totalObtainedMarks += result.score.obtainedMarks;
      totalTimeSpent += result.performanceMetrics.timeSpentMinutes;
    }

    final overallPercentage = totalMarks > 0 
        ? (totalObtainedMarks / totalMarks) * 100 
        : 0.0;

    final aggregateScore = ExamScore(
      totalQuestions: totalQuestions,
      correct: totalCorrect,
      incorrect: totalIncorrect,
      skipped: totalSkipped,
      attempted: totalCorrect + totalIncorrect,
      totalMarks: totalMarks,
      obtainedMarks: totalObtainedMarks,
      percentage: overallPercentage,
    );

    final overallGrade = calculateGrade(overallPercentage);

    // Aggregate weak areas across all sessions
    final allWeakAreas = _aggregateWeakAreas(individualResults);

    // Calculate progress trend
    final progressTrend = _calculateProgressTrend(individualResults);

    // Subject-wise breakdown
    final subjectBreakdown = _getSubjectBreakdown(sessions, individualResults);

    // Best and worst performances
    individualResults.sort((a, b) => b.score.percentage.compareTo(a.score.percentage));
    final bestSession = individualResults.first;
    final worstSession = individualResults.last;

    // Calculate consistency
    final consistency = _calculateConsistency(individualResults);

    // Aggregate performance metrics
    final avgAccuracy = individualResults.isEmpty 
        ? 0.0 
        : individualResults.map((r) => r.performanceMetrics.accuracy).reduce((a, b) => a + b) / individualResults.length;
    
    final avgCompletionRate = individualResults.isEmpty 
        ? 0.0 
        : individualResults.map((r) => r.performanceMetrics.completionRate).reduce((a, b) => a + b) / individualResults.length;

    return AggregateExamResult(
      totalSessions: sessions.length,
      aggregateScore: aggregateScore,
      overallGrade: overallGrade,
      individualResults: individualResults,
      aggregateWeakAreas: allWeakAreas,
      progressTrend: progressTrend,
      subjectBreakdown: subjectBreakdown,
      bestPerformance: bestSession,
      worstPerformance: worstSession,
      averageAccuracy: avgAccuracy,
      averageCompletionRate: avgCompletionRate,
      totalTimeSpent: totalTimeSpent,
      consistency: consistency,
    );
  }

  /// Aggregate weak areas from multiple sessions
  static List<WeakArea> _aggregateWeakAreas(List<ExamResult> results) {
    final Map<String, AggregateWeakAreaData> topicMap = {};

    for (final result in results) {
      for (final weakArea in result.weakAreas) {
        if (!topicMap.containsKey(weakArea.topicId)) {
          topicMap[weakArea.topicId] = AggregateWeakAreaData(
            topicId: weakArea.topicId,
            topicName: weakArea.topicName,
            totalQuestions: 0,
            incorrectQuestions: [],
            skippedQuestions: [],
            occurrences: 0,
          );
        }

        final data = topicMap[weakArea.topicId]!;
        data.totalQuestions += weakArea.totalQuestions;
        data.incorrectQuestions.addAll(weakArea.incorrectQuestionIds);
        data.skippedQuestions.addAll(weakArea.skippedQuestionIds);
        data.occurrences++;
      }
    }

    final weakAreas = <WeakArea>[];
    topicMap.forEach((topicId, data) {
      final issueCount = data.incorrectQuestions.length + data.skippedQuestions.length;
      final accuracyRate = data.totalQuestions > 0
          ? ((data.totalQuestions - issueCount) / data.totalQuestions) * 100
          : 0.0;

      weakAreas.add(WeakArea(
        topicId: topicId,
        topicName: data.topicName,
        totalQuestions: data.totalQuestions,
        incorrectCount: data.incorrectQuestions.length,
        skippedCount: data.skippedQuestions.length,
        accuracyRate: accuracyRate,
        incorrectQuestionIds: data.incorrectQuestions,
        skippedQuestionIds: data.skippedQuestions,
        severity: _calculateSeverity(accuracyRate),
      ));
    });

    weakAreas.sort((a, b) => a.accuracyRate.compareTo(b.accuracyRate));
    return weakAreas;
  }

  /// Calculate progress trend across sessions
  static ProgressTrend _calculateProgressTrend(List<ExamResult> results) {
    if (results.length < 2) {
      return ProgressTrend(
        trend: TrendDirection.stable,
        percentageChange: 0.0,
        improvement: 0.0,
        isImproving: false,
      );
    }

    final firstScore = results.first.score.percentage;
    final lastScore = results.last.score.percentage;
    final percentageChange = lastScore - firstScore;
    final improvement = (percentageChange / firstScore) * 100;

    TrendDirection trend;
    if (percentageChange > 5) {
      trend = TrendDirection.improving;
    } else if (percentageChange < -5) {
      trend = TrendDirection.declining;
    } else {
      trend = TrendDirection.stable;
    }

    return ProgressTrend(
      trend: trend,
      percentageChange: percentageChange,
      improvement: improvement,
      isImproving: percentageChange > 0,
    );
  }

  /// Get breakdown by subject
  static List<SubjectPerformance> _getSubjectBreakdown(
    List<ExamSession> sessions,
    List<ExamResult> results,
  ) {
    final Map<String, SubjectPerformanceData> subjectMap = {};

    for (int i = 0; i < sessions.length; i++) {
      final session = sessions[i];
      final result = results[i];
      final subjectId = session.subjectId;

      if (!subjectMap.containsKey(subjectId)) {
        subjectMap[subjectId] = SubjectPerformanceData(
          subjectId: subjectId,
          sessionCount: 0,
          totalQuestions: 0,
          totalCorrect: 0,
          totalIncorrect: 0,
          totalSkipped: 0,
          totalMarks: 0,
          obtainedMarks: 0,
        );
      }

      final data = subjectMap[subjectId]!;
      data.sessionCount++;
      data.totalQuestions += result.score.totalQuestions;
      data.totalCorrect += result.score.correct;
      data.totalIncorrect += result.score.incorrect;
      data.totalSkipped += result.score.skipped;
      data.totalMarks += result.score.totalMarks;
      data.obtainedMarks += result.score.obtainedMarks;
    }

    final subjectPerformances = <SubjectPerformance>[];
    subjectMap.forEach((subjectId, data) {
      final percentage = data.totalMarks > 0
          ? (data.obtainedMarks / data.totalMarks) * 100
          : 0.0;
      final avgPerSession = data.sessionCount > 0
          ? percentage / data.sessionCount
          : 0.0;

      subjectPerformances.add(SubjectPerformance(
        subjectId: subjectId,
        subjectName: subjectId, // Map to actual subject name
        sessionCount: data.sessionCount,
        totalQuestions: data.totalQuestions,
        correct: data.totalCorrect,
        incorrect: data.totalIncorrect,
        skipped: data.totalSkipped,
        totalMarks: data.totalMarks,
        obtainedMarks: data.obtainedMarks,
        percentage: percentage,
        averagePerSession: avgPerSession,
        grade: calculateGrade(percentage),
      ));
    });

    subjectPerformances.sort((a, b) => b.percentage.compareTo(a.percentage));
    return subjectPerformances;
  }

  /// Calculate performance consistency
  static ConsistencyMetrics _calculateConsistency(List<ExamResult> results) {
    if (results.length < 2) {
      return ConsistencyMetrics(
        standardDeviation: 0.0,
        variance: 0.0,
        consistencyScore: 100.0,
        isConsistent: true,
      );
    }

    final percentages = results.map((r) => r.score.percentage).toList();
    final mean = percentages.reduce((a, b) => a + b) / percentages.length;

    final squaredDifferences = percentages.map((p) => (p - mean) * (p - mean)).toList();
    final variance = squaredDifferences.reduce((a, b) => a + b) / squaredDifferences.length;
    final standardDeviation = variance > 0 ? variance : 0.0;

    // Consistency score (0-100, higher is more consistent)
    final consistencyScore = 100 - (standardDeviation.clamp(0, 100));
    final isConsistent = standardDeviation < 10; // Less than 10% deviation

    return ConsistencyMetrics(
      standardDeviation: standardDeviation,
      variance: variance,
      consistencyScore: consistencyScore as double,
      isConsistent: isConsistent,
    );
  }
}

// ============================================================================
// DATA CLASSES
// ============================================================================

class ExamResult {
  final ExamSession examSession;
  final ExamScore score;
  final ExamGrade grade;
  final List<WeakArea> weakAreas;
  final PerformanceMetrics performanceMetrics;
  final List<TopicPerformance> topicBreakdown;
  final DifficultyAnalysis difficultyAnalysis;
  final DateTime completedAt;

  ExamResult({
    required this.examSession,
    required this.score,
    required this.grade,
    required this.weakAreas,
    required this.performanceMetrics,
    required this.topicBreakdown,
    required this.difficultyAnalysis,
    required this.completedAt,
  });

  /// Get recommendations for improvement
  List<String> get recommendations => ExamCalculator.generateRecommendations(this);
}

class ExamScore {
  final int totalQuestions;
  final int correct;
  final int incorrect;
  final int skipped;
  final int attempted;
  final int totalMarks;
  final int obtainedMarks;
  final double percentage;

  ExamScore({
    required this.totalQuestions,
    required this.correct,
    required this.incorrect,
    required this.skipped,
    required this.attempted,
    required this.totalMarks,
    required this.obtainedMarks,
    required this.percentage,
  });
}

class ExamGrade {
  final String grade;
  final String description;
  final String remarks;
  final int color;

  ExamGrade({
    required this.grade,
    required this.description,
    required this.remarks,
    required this.color,
  });
}

class WeakArea {
  final String topicId;
  final String topicName;
  final int totalQuestions;
  final int incorrectCount;
  final int skippedCount;
  final double accuracyRate;
  final List<String> incorrectQuestionIds;
  final List<String> skippedQuestionIds;
  final WeakAreaSeverity severity;

  WeakArea({
    required this.topicId,
    required this.topicName,
    required this.totalQuestions,
    required this.incorrectCount,
    required this.skippedCount,
    required this.accuracyRate,
    required this.incorrectQuestionIds,
    required this.skippedQuestionIds,
    required this.severity,
  });

  int get totalIssues => incorrectCount + skippedCount;
}

enum WeakAreaSeverity { low, medium, high, critical }

class PerformanceMetrics {
  final int timeSpentMinutes;
  final double averageTimePerQuestion;
  final double completionRate;
  final double accuracy;
  final double speedScore;
  final double efficiency;
  final int timeLimitMinutes;
  final bool wasCompleted;
  final bool finishedEarly;

  PerformanceMetrics({
    required this.timeSpentMinutes,
    required this.averageTimePerQuestion,
    required this.completionRate,
    required this.accuracy,
    required this.speedScore,
    required this.efficiency,
    required this.timeLimitMinutes,
    required this.wasCompleted,
    required this.finishedEarly,
  });
}

class TopicPerformance {
  final String topicId;
  final String topicName;
  final int totalQuestions;
  final int correct;
  final int incorrect;
  final int skipped;
  final int totalMarks;
  final int obtainedMarks;
  final double percentage;

  TopicPerformance({
    required this.topicId,
    required this.topicName,
    required this.totalQuestions,
    required this.correct,
    required this.incorrect,
    required this.skipped,
    required this.totalMarks,
    required this.obtainedMarks,
    required this.percentage,
  });
}

class DifficultyAnalysis {
  final DifficultyBreakdown easy;
  final DifficultyBreakdown medium;
  final DifficultyBreakdown hard;

  DifficultyAnalysis({
    required this.easy,
    required this.medium,
    required this.hard,
  });
}

class DifficultyBreakdown {
  final int totalQuestions;
  final int correct;
  final int incorrect;
  final int skipped;
  final double accuracy;

  DifficultyBreakdown({
    required this.totalQuestions,
    required this.correct,
    required this.incorrect,
    required this.skipped,
    required this.accuracy,
  });
}

// Helper classes for internal calculations
class WeakAreaData {
  final String topicId;
  int totalQuestions;
  final List<String> incorrectQuestions;
  final List<String> skippedQuestions;

  WeakAreaData({
    required this.topicId,
    required this.totalQuestions,
    required this.incorrectQuestions,
    required this.skippedQuestions,
  });
}

class TopicPerformanceData {
  final String topicId;
  int totalQuestions;
  int correct;
  int incorrect;
  int skipped;

  TopicPerformanceData({
    required this.topicId,
    required this.totalQuestions,
    required this.correct,
    required this.incorrect,
    required this.skipped,
  });
}

class DifficultyData {
  final String level;
  int total;
  int correct;
  int incorrect;
  int skipped;

  DifficultyData({
    required this.level,
    required this.total,
    required this.correct,
    required this.incorrect,
    required this.skipped,
  });
}

// ============================================================================
// AGGREGATE DATA CLASSES (Multiple Sessions)
// ============================================================================

class AggregateExamResult {
  final int totalSessions;
  final ExamScore aggregateScore;
  final ExamGrade overallGrade;
  final List<ExamResult> individualResults;
  final List<WeakArea> aggregateWeakAreas;
  final ProgressTrend progressTrend;
  final List<SubjectPerformance> subjectBreakdown;
  final ExamResult bestPerformance;
  final ExamResult worstPerformance;
  final double averageAccuracy;
  final double averageCompletionRate;
  final int totalTimeSpent;
  final ConsistencyMetrics consistency;

  AggregateExamResult({
    required this.totalSessions,
    required this.aggregateScore,
    required this.overallGrade,
    required this.individualResults,
    required this.aggregateWeakAreas,
    required this.progressTrend,
    required this.subjectBreakdown,
    required this.bestPerformance,
    required this.worstPerformance,
    required this.averageAccuracy,
    required this.averageCompletionRate,
    required this.totalTimeSpent,
    required this.consistency,
  });

  factory AggregateExamResult.empty() {
    final emptyScore = ExamScore(
      totalQuestions: 0,
      correct: 0,
      incorrect: 0,
      skipped: 0,
      attempted: 0,
      totalMarks: 0,
      obtainedMarks: 0,
      percentage: 0.0,
    );

    return AggregateExamResult(
      totalSessions: 0,
      aggregateScore: emptyScore,
      overallGrade: ExamCalculator.calculateGrade(0.0),
      individualResults: [],
      aggregateWeakAreas: [],
      progressTrend: ProgressTrend(
        trend: TrendDirection.stable,
        percentageChange: 0.0,
        improvement: 0.0,
        isImproving: false,
      ),
      subjectBreakdown: [],
      bestPerformance: ExamResult(
        examSession: ExamSession.empty(),
        score: emptyScore,
        grade: ExamCalculator.calculateGrade(0.0),
        weakAreas: [],
        performanceMetrics: PerformanceMetrics(
          timeSpentMinutes: 0,
          averageTimePerQuestion: 0.0,
          completionRate: 0.0,
          accuracy: 0.0,
          speedScore: 0.0,
          efficiency: 0.0,
          timeLimitMinutes: 0,
          wasCompleted: false,
          finishedEarly: false,
        ),
        topicBreakdown: [],
        difficultyAnalysis: DifficultyAnalysis(
          easy: DifficultyBreakdown(
            totalQuestions: 0,
            correct: 0,
            incorrect: 0,
            skipped: 0,
            accuracy: 0.0,
          ),
          medium: DifficultyBreakdown(
            totalQuestions: 0,
            correct: 0,
            incorrect: 0,
            skipped: 0,
            accuracy: 0.0,
          ),
          hard: DifficultyBreakdown(
            totalQuestions: 0,
            correct: 0,
            incorrect: 0,
            skipped: 0,
            accuracy: 0.0,
          ),
        ),
        completedAt: DateTime.now(),
      ),
      worstPerformance: ExamResult(
        examSession: ExamSession.empty(),
        score: emptyScore,
        grade: ExamCalculator.calculateGrade(0.0),
        weakAreas: [],
        performanceMetrics: PerformanceMetrics(
          timeSpentMinutes: 0,
          averageTimePerQuestion: 0.0,
          completionRate: 0.0,
          accuracy: 0.0,
          speedScore: 0.0,
          efficiency: 0.0,
          timeLimitMinutes: 0,
          wasCompleted: false,
          finishedEarly: false,
        ),
        topicBreakdown: [],
        difficultyAnalysis: DifficultyAnalysis(
          easy: DifficultyBreakdown(
            totalQuestions: 0,
            correct: 0,
            incorrect: 0,
            skipped: 0,
            accuracy: 0.0,
          ),
          medium: DifficultyBreakdown(
            totalQuestions: 0,
            correct: 0,
            incorrect: 0,
            skipped: 0,
            accuracy: 0.0,
          ),
          hard: DifficultyBreakdown(
            totalQuestions: 0,
            correct: 0,
            incorrect: 0,
            skipped: 0,
            accuracy: 0.0,
          ),
        ),
        completedAt: DateTime.now(),
      ),
      averageAccuracy: 0.0,
      averageCompletionRate: 0.0,
      totalTimeSpent: 0,
      consistency: ConsistencyMetrics(
        standardDeviation: 0.0,
        variance: 0.0,
        consistencyScore: 0.0,
        isConsistent: false,
      ),
    );
  }

  /// Get average score per session
  double get averageScorePerSession => totalSessions > 0 
      ? aggregateScore.percentage / totalSessions 
      : 0.0;

  /// Get improvement from first to last
  double get overallImprovement => progressTrend.percentageChange;

  /// Check if user is improving
  bool get isImproving => progressTrend.isImproving;

  /// Get most problematic subject
  SubjectPerformance? get weakestSubject => 
      subjectBreakdown.isNotEmpty ? subjectBreakdown.last : null;

  /// Get best performing subject
  SubjectPerformance? get strongestSubject => 
      subjectBreakdown.isNotEmpty ? subjectBreakdown.first : null;
}

class ProgressTrend {
  final TrendDirection trend;
  final double percentageChange;
  final double improvement;
  final bool isImproving;

  ProgressTrend({
    required this.trend,
    required this.percentageChange,
    required this.improvement,
    required this.isImproving,
  });
}

enum TrendDirection { improving, declining, stable }

class SubjectPerformance {
  final String subjectId;
  final String subjectName;
  final int sessionCount;
  final int totalQuestions;
  final int correct;
  final int incorrect;
  final int skipped;
  final int totalMarks;
  final int obtainedMarks;
  final double percentage;
  final double averagePerSession;
  final ExamGrade grade;

  SubjectPerformance({
    required this.subjectId,
    required this.subjectName,
    required this.sessionCount,
    required this.totalQuestions,
    required this.correct,
    required this.incorrect,
    required this.skipped,
    required this.totalMarks,
    required this.obtainedMarks,
    required this.percentage,
    required this.averagePerSession,
    required this.grade,
  });
}

class ConsistencyMetrics {
  final double standardDeviation;
  final double variance;
  final double consistencyScore;
  final bool isConsistent;

  ConsistencyMetrics({
    required this.standardDeviation,
    required this.variance,
    required this.consistencyScore,
    required this.isConsistent,
  });
}

class AggregateWeakAreaData {
  final String topicId;
  final String topicName;
  int totalQuestions;
  final List<String> incorrectQuestions;
  final List<String> skippedQuestions;
  int occurrences;

  AggregateWeakAreaData({
    required this.topicId,
    required this.topicName,
    required this.totalQuestions,
    required this.incorrectQuestions,
    required this.skippedQuestions,
    required this.occurrences,
  });
}

class SubjectPerformanceData {
  final String subjectId;
  int sessionCount;
  int totalQuestions;
  int totalCorrect;
  int totalIncorrect;
  int totalSkipped;
  int totalMarks;
  int obtainedMarks;

  SubjectPerformanceData({
    required this.subjectId,
    required this.sessionCount,
    required this.totalQuestions,
    required this.totalCorrect,
    required this.totalIncorrect,
    required this.totalSkipped,
    required this.totalMarks,
    required this.obtainedMarks,
  });
}

// ============================================================================
// TIME-RELATED DATA CLASSES
// ============================================================================

class TimeMetrics {
  final int totalTimeMinutes;
  final int totalTimeSeconds;
  final int timeSpentMinutes;
  final int timeSpentSeconds;
  final int timeRemainingMinutes;
  final int timeRemainingSeconds;
  final double timeUsedPercentage;
  final double timeEfficiency;
  final bool isTimeUp;
  final String formattedTotalTime;
  final String formattedTimeSpent;
  final String formattedTimeRemaining;

  TimeMetrics({
    required this.totalTimeMinutes,
    required this.totalTimeSeconds,
    required this.timeSpentMinutes,
    required this.timeSpentSeconds,
    required this.timeRemainingMinutes,
    required this.timeRemainingSeconds,
    required this.timeUsedPercentage,
    required this.timeEfficiency,
    required this.isTimeUp,
    required this.formattedTotalTime,
    required this.formattedTimeSpent,
    required this.formattedTimeRemaining,
  });

  /// Get readable total time
  String get readableTotalTime => ExamCalculator.formatTimeReadable(totalTimeSeconds);

  /// Get readable time spent
  String get readableTimeSpent => ExamCalculator.formatTimeReadable(timeSpentSeconds);

  /// Get readable time remaining
  String get readableTimeRemaining => ExamCalculator.formatTimeReadable(timeRemainingSeconds);
}

class QuestionTimeMetrics {
  final int totalQuestions;
  final int questionsAttempted;
  final int questionsRemaining;
  final double averageTimePerQuestion;
  final double averageTimePerAttempted;
  final double estimatedTimeForRemaining;
  final String formattedAvgTime;
  final String formattedAvgAttemptedTime;

  QuestionTimeMetrics({
    required this.totalQuestions,
    required this.questionsAttempted,
    required this.questionsRemaining,
    required this.averageTimePerQuestion,
    required this.averageTimePerAttempted,
    required this.estimatedTimeForRemaining,
    required this.formattedAvgTime,
    required this.formattedAvgAttemptedTime,
  });

  /// Get readable average time
  String get readableAvgTime => 
      ExamCalculator.formatTimeReadable(averageTimePerQuestion.toInt());

  /// Get readable estimated time for remaining questions
  String get readableEstimatedTime => 
      ExamCalculator.formatTimeReadable(estimatedTimeForRemaining.toInt());
}

class TimeAlerts {
  final List<String> alerts;
  final TimeUrgency urgency;
  final bool hasAlerts;

  TimeAlerts({
    required this.alerts,
    required this.urgency,
    required this.hasAlerts,
  });
}

enum TimeUrgency {
  normal,    // More than 10 minutes
  warning,   // 5-10 minutes
  critical,  // Less than 5 minutes
  timeUp,    // Time's up
}