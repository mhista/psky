// ============================================================================
// EXAM SESSION MODELS
// ============================================================================

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/exam_question.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/exam_progress.dart';

/// Represents a complete exam session
class ExamSessionEntity {
  final String examSessionId;
  final String userId;
  final String subjectId;
  final ExamBody examBody;
  final PaperType paperType;
  final List<ExamQuestion> questions;
  final int totalMarks;
  final int timeLimitMinutes;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final ExamSessionStatus status;
  final ExamProgress? progress;
  final bool sessionStatrted;
  final bool sessionEnded;
  
  

  ExamSessionEntity({
    required this.examSessionId,
    required this.userId,
    required this.subjectId,
    required this.examBody,
    required this.paperType,
    required this.questions,
    required this.totalMarks,
    required this.timeLimitMinutes,
    this.startedAt,
    this.completedAt,
    this.status = ExamSessionStatus.inProgress,
    this.progress,
    this.sessionEnded = false,
    this.sessionStatrted = false
  })  ;
}


