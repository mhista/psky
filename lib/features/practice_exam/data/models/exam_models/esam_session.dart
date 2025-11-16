// ============================================================================
// EXAM SESSION MODELS
// ============================================================================

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/exam_question.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/exam_progress.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_session_entity.dart';

/// Represents a complete exam session
class ExamSession extends ExamSessionEntity {
  ExamSession({
    required super.examSessionId,
    required super.userId,
    required super.subjectId,
    required super.examBody,
    required super.paperType,
    required super.questions,
    required super.totalMarks,
    required super.timeLimitMinutes,
    DateTime? startedAt,
    super.completedAt,
    super.status,
    ExamProgress? progress,
  }) : super(
          startedAt: startedAt ?? DateTime.now(),
          progress: progress ?? ExamProgress(totalQuestions: questions.length),
        );

  // ============================================================================
  // COPY WITH METHOD
  // ============================================================================
  factory ExamSession.empty() {
    return ExamSession(
      examSessionId: '',
      userId: '',
      subjectId: '',
      examBody: ExamBody.values.first,
      paperType: PaperType.values.first,
      questions: const <ExamQuestion>[],
      totalMarks: 0,
      timeLimitMinutes: 0,
      // startedAt omitted to use default (DateTime.now())
      // completedAt omitted (null)
      status: ExamSessionStatus.values.first,
    );
  }
  ExamSession copyWith({
    String? examSessionId,
    String? userId,
    String? subjectId,
    ExamBody? examBody,
    PaperType? paperType,
    List<ExamQuestion>? questions,
    int? totalMarks,
    int? timeLimitMinutes,
    DateTime? startedAt,
    DateTime? completedAt,
    ExamSessionStatus? status,
    ExamProgress? progress,
  }) {
    return ExamSession(
      examSessionId: examSessionId ?? this.examSessionId,
      userId: userId ?? this.userId,
      subjectId: subjectId ?? this.subjectId,
      examBody: examBody ?? this.examBody,
      paperType: paperType ?? this.paperType,
      questions: questions ?? this.questions,
      totalMarks: totalMarks ?? this.totalMarks,
      timeLimitMinutes: timeLimitMinutes ?? this.timeLimitMinutes,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  } 

  Map<String, dynamic> toJson() {
    return {
      'examSessionId': examSessionId,
      'userId': userId,
      'subjectId': subjectId,
      'examBody': examBody.name,
      'paperType': paperType.name,
      'questions': questions.map((q) => q.toJson()).toList(),
      'totalMarks': totalMarks,
      'timeLimitMinutes': timeLimitMinutes,
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'status': status.name,
      'progress': progress?.toJson(),
    };
  }

  factory ExamSession.fromJson(Map<String, dynamic> json) {
    return ExamSession(
      examSessionId: json['examSessionId'] as String,
      userId: json['userId'] as String,
      subjectId: json['subjectId'] as String,
      examBody: ExamBody.values.firstWhere(
        (e) => e.name == json['examBody'],
      ),
      paperType: PaperType.values.firstWhere(
        (e) => e.name == json['paperType'],
      ),
      questions: (json['questions'] as List)
          .map((q) => ExamQuestion.fromJson(q as Map<String, dynamic>))
          .toList(),
      totalMarks: json['totalMarks'] as int,
      timeLimitMinutes: json['timeLimitMinutes'] as int,
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      status: ExamSessionStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
      progress: ExamProgress.fromJson(json['progress'] as Map<String, dynamic>),
    );
  }
}