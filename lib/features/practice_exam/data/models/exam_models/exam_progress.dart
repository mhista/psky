import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_progress_entity.dart';

/// Tracks exam progress in real-time
class ExamProgress extends ExamProgressEntity {
  ExamProgress({
    required super.totalQuestions,
    super.currentQuestionIndex = 0,
    super.answeredCount = 0,
    super.skippedCount = 0,
    super.unansweredCount = 0,
    super.answeredQuestions = const [],
    super.skippedQuestions = const [],
    super.reviewedQuestions = const [],
    super.timeElapsedMinutes = 0,
    super.lastUpdated,
  });

  ExamProgress copyWith({
    int? currentQuestionIndex,
    int? answeredCount,
    int? skippedCount,
    List<int>? answeredQuestions,
    List<int>? skippedQuestions,
    List<int>? reviewedQuestions,
    int? timeElapsedMinutes,
  }) {
    return ExamProgress(
      totalQuestions: totalQuestions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      answeredCount: answeredCount ?? this.answeredCount,
      skippedCount: skippedCount ?? this.skippedCount,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      reviewedQuestions: reviewedQuestions ?? this.reviewedQuestions,
      skippedQuestions: skippedQuestions ?? this.skippedQuestions,
      timeElapsedMinutes: timeElapsedMinutes ?? this.timeElapsedMinutes,
      lastUpdated: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalQuestions': totalQuestions,
      'currentQuestionIndex': currentQuestionIndex,
      'answeredCount': answeredCount,
      'skippedCount': skippedCount,
      'unansweredCount': unansweredCount,
      'reviewedQuestions': reviewedQuestions,
      'answeredQuestions': answeredQuestions,
      'skippedQuestions': skippedQuestions,
      'timeElapsedMinutes': timeElapsedMinutes,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  factory ExamProgress.fromJson(Map<String, dynamic> json) {
    try {
      return ExamProgress(
        totalQuestions: json['totalQuestions'] as int? ?? 0,
        currentQuestionIndex: json['currentQuestionIndex'] as int? ?? 0,
        answeredCount: json['answeredCount'] as int? ?? 0,
        skippedCount: json['skippedCount'] as int? ?? 0,
        unansweredCount: json['unansweredCount'] as int? ?? 0,
        answeredQuestions: _parseIntList(json['answeredQuestions']),
        skippedQuestions: _parseIntList(json['skippedQuestions']),
        reviewedQuestions: _parseIntList(json['reviewedQuestions']),
        timeElapsedMinutes: json['timeElapsedMinutes'] as int? ?? 0,
        lastUpdated: json['lastUpdated'] != null
            ? DateTime.parse(json['lastUpdated'] as String)
            : DateTime.now(),
      );
    } catch (e) {
      pskyLog('Error parsing ExamProgress: $e');
      pskyLog('JSON data: $json');
      // Return default progress on error
      return ExamProgress(
        totalQuestions: 0,
        lastUpdated: DateTime.now(),
      );
    }
  }

  // Helper to safely parse int lists
  static List<int> _parseIntList(dynamic value) {
    if (value == null) return [];
    if (value is! List) return [];
    
    try {
      return value.map((e) {
        if (e is int) return e;
        if (e is String) return int.tryParse(e) ?? 0;
        if (e is double) return e.toInt();
        return 0;
      }).toList();
    } catch (e) {
      pskyLog('Error parsing int list: $e');
      return [];
    }
  }
}