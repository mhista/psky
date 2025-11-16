
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';

/// Complete exam result with analysis
class ExamResultEntity {
  final String resultId;
  final String examSessionId;
  final String userId;
  final int score;
  final double percentage;
  final String grade;
  final int correctAnswers;
  final int wrongAnswers;
  final int skipped;
  final int unanswered;
  final int timeTakenMinutes;
  final List<TopicPerformance> topicBreakdown;
  final List<String> strengths;
  final List<WeakArea> weaknesses;
  final List<String> recommendations;
  final List<String> nextSteps;
  final PerformanceComparison? comparisonWithPrevious;
  final String motivationalMessage;
  final DateTime? analyzedAt;

  ExamResultEntity({
    required this.resultId,
    required this.examSessionId,
    required this.userId,
    required this.score,
    required this.percentage,
    required this.grade,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skipped,
    required this.unanswered,
    required this.timeTakenMinutes,
    required this.topicBreakdown,
    required this.strengths,
    required this.weaknesses,
    required this.recommendations,
    required this.nextSteps,
    this.comparisonWithPrevious,
    required this.motivationalMessage,
    this.analyzedAt,
  }) ;

}



/// Performance breakdown by topic
class TopicPerformance {
  final String topicId;
  final String topicName;
  final int questionsAttempted;
  final int questionsCorrect;
  final double accuracy;
  final PerformanceLevel performanceLevel;
  final bool needsImprovement;

  TopicPerformance({
    required this.topicId,
    required this.topicName,
    required this.questionsAttempted,
    required this.questionsCorrect,
    required this.accuracy,
    required this.performanceLevel,
    required this.needsImprovement,
  });

  Map<String, dynamic> toJson() {
    return {
      'topicId': topicId,
      'topicName': topicName,
      'questionsAttempted': questionsAttempted,
      'questionsCorrect': questionsCorrect,
      'accuracy': accuracy,
      'performanceLevel': performanceLevel.name,
      'needsImprovement': needsImprovement,
    };
  }

  factory TopicPerformance.fromJson(Map<String, dynamic> json) {
    return TopicPerformance(
      topicId: json['topicId'] as String,
      topicName: json['topicName'] as String,
      questionsAttempted: json['questionsAttempted'] as int,
      questionsCorrect: json['questionsCorrect'] as int,
      accuracy: (json['accuracy'] as num).toDouble(),
      performanceLevel: PerformanceLevel.values.firstWhere(
        (e) => e.name == json['performanceLevel'],
      ),
      needsImprovement: json['needsImprovement'] as bool,
    );
  }
}

/// Weak area identification
class WeakArea {
  final String topicId;
  final String topicName;
  final double accuracy;
  final String recommendation;

  WeakArea({
    required this.topicId,
    required this.topicName,
    required this.accuracy,
    required this.recommendation,
  });

  Map<String, dynamic> toJson() {
    return {
      'topicId': topicId,
      'topicName': topicName,
      'accuracy': accuracy,
      'recommendation': recommendation,
    };
  }

  factory WeakArea.fromJson(Map<String, dynamic> json) {
    return WeakArea(
      topicId: json['topicId'] as String,
      topicName: json['topicName'] as String,
      accuracy: (json['accuracy'] as num).toDouble(),
      recommendation: json['recommendation'] as String,
    );
  }
}

/// Comparison with previous attempts
class PerformanceComparison {
  final int scoreChange;
  final PerformanceTrend trend;
  final String consistency;

  PerformanceComparison({
    required this.scoreChange,
    required this.trend,
    required this.consistency,
  });

  Map<String, dynamic> toJson() {
    return {
      'scoreChange': scoreChange,
      'trend': trend.name,
      'consistency': consistency,
    };
  }

  factory PerformanceComparison.fromJson(Map<String, dynamic> json) {
    return PerformanceComparison(
      scoreChange: json['scoreChange'] as int,
      trend: PerformanceTrend.values.firstWhere(
        (e) => e.name == json['trend'],
      ),
      consistency: json['consistency'] as String,
    );
  }
}

