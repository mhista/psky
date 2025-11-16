
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_result_entity.dart';

/// Complete exam result with analysis
class ExamResult extends ExamResultEntity{
  
  ExamResult({
    required super.resultId,
    required super.examSessionId,
    required super.userId,
    required super.score,
    required super.percentage,
    required super.grade,
    required super.correctAnswers,
    required super.wrongAnswers,
    required super.skipped,
    required super.unanswered,
    required super.timeTakenMinutes,
    required super.topicBreakdown,
    required super.strengths,
    required super.weaknesses,
    required super.recommendations,
    required super.nextSteps,
    super.comparisonWithPrevious,
    required super.motivationalMessage,
   super.analyzedAt,
  }) ;

  Map<String, dynamic> toJson() {
    return {
      'resultId': resultId,
      'examSessionId': examSessionId,
      'userId': userId,
      'score': score,
      'percentage': percentage,
      'grade': grade,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'skipped': skipped,
      'unanswered': unanswered,
      'timeTakenMinutes': timeTakenMinutes,
      'topicBreakdown': topicBreakdown.map((t) => t.toJson()).toList(),
      'strengths': strengths,
      'weaknesses': weaknesses.map((w) => w.toJson()).toList(),
      'recommendations': recommendations,
      'nextSteps': nextSteps,
      'comparisonWithPrevious': comparisonWithPrevious?.toJson(),
      'motivationalMessage': motivationalMessage,
      'analyzedAt': analyzedAt?.toIso8601String(),
    };
  }

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      resultId: json['resultId'] as String,
      examSessionId: json['examSessionId'] as String,
      userId: json['userId'] as String,
      score: json['score'] as int,
      percentage: (json['percentage'] as num).toDouble(),
      grade: json['grade'] as String,
      correctAnswers: json['correctAnswers'] as int,
      wrongAnswers: json['wrongAnswers'] as int,
      skipped: json['skipped'] as int,
      unanswered: json['unanswered'] as int,
      timeTakenMinutes: json['timeTakenMinutes'] as int,
      topicBreakdown: (json['topicBreakdown'] as List)
          .map((t) => TopicPerformance.fromJson(t as Map<String, dynamic>))
          .toList(),
      strengths: (json['strengths'] as List).map((e) => e as String).toList(),
      weaknesses: (json['weaknesses'] as List)
          .map((w) => WeakArea.fromJson(w as Map<String, dynamic>))
          .toList(),
      recommendations:
          (json['recommendations'] as List).map((e) => e as String).toList(),
      nextSteps: (json['nextSteps'] as List).map((e) => e as String).toList(),
      comparisonWithPrevious: json['comparisonWithPrevious'] != null
          ? PerformanceComparison.fromJson(
              json['comparisonWithPrevious'] as Map<String, dynamic>)
          : null,
      motivationalMessage: json['motivationalMessage'] as String,
      analyzedAt: DateTime.parse(json['analyzedAt'] as String),
    );
  }
}