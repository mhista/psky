import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_question_entity.dart';

class ExamQuestion extends ExamQuestionEntity {
  final DateTime createdAt;

  ExamQuestion({
    required super.questionId,
    required super.questionNumber,
    required super.questionText,
    required super.questionType,
    required super.subjectId,
    required super.topicId,
    required super.examBody,
    required super.difficultyLevel,
    required super.marks,
    required super.timeEstimateMinutes,
    super.options,
    super.correctAnswer,
    super.selectedAnswer,
    super.answerText,
    super.markingScheme,
    required super.explanation,
    super.commonMistakes = const [],
    required super.syllabusReference,
    super.requiresDiagram = false,
    super.diagramDescription,
    super.diagramUrl,
    super.pastYearReference,
    DateTime? createdAt,
    super.createdBy = 'coach_kai',
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionNumber': questionNumber,
      'questionText': questionText,
      'questionType': questionType.name,
      'subjectId': subjectId,
      'topicId': topicId,
      'examBody': examBody.displayName,
      'difficultyLevel': difficultyLevel.name,
      'marks': marks,
      'timeEstimateMinutes': timeEstimateMinutes,
      'options': options?.map((o) => o.toJson()).toList(),
      'correctAnswer': correctAnswer,
      'selectedAnswer': selectedAnswer,
      'answerText': answerText,
      'markingScheme': markingScheme?.toJson(),
      'explanation': explanation,
      'commonMistakes': commonMistakes,
      'syllabusReference': syllabusReference,
      'requiresDiagram': requiresDiagram,
      'diagramDescription': diagramDescription,
      'diagramUrl': diagramUrl,
      'pastYearReference': pastYearReference,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
    };
  }

  factory ExamQuestion.fromJson(Map<String, dynamic> json) {
    try {
      return ExamQuestion(
        questionId: json['questionId'] as String,
        questionNumber: json['questionNumber'] as int,
        questionText: json['questionText'] as String,
        questionType: QuestionTypeExtension.fromString(json['questionType']),
        subjectId: json['subjectId'] as String,
        topicId: json['topicId'] as String,
        examBody: _parseExamBody(json['examBody']),
        difficultyLevel: DifficultyLevel.values.firstWhere(
          (e) => e.name.toLowerCase() == (json['difficultyLevel'] as String).toLowerCase(),
          orElse: () => DifficultyLevel.medium,
        ),
        marks: json['marks'] as int,
        timeEstimateMinutes: json['timeEstimateMinutes'] as int,
        options: (json['options'] as List?)
            ?.map((o) => QuestionOption.fromJson(o as Map<String, dynamic>))
            .toList(),
        correctAnswer: json['correctAnswer'] as String?,
        selectedAnswer: json['selectedAnswer'] as String?, // This can be null
        answerText: json['answerText'] as String? ?? '',
        markingScheme: json['markingScheme'] != null
            ? MarkingScheme.fromJson(json['markingScheme'] as Map<String, dynamic>)
            : null,
        explanation: json['explanation'] as String? ?? '',
        commonMistakes: (json['commonMistakes'] as List?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        syllabusReference: json['syllabusReference'] as String? ?? '',
        requiresDiagram: json['requiresDiagram'] as bool? ?? false,
        diagramDescription: json['diagramDescription'] as String?,
        diagramUrl: json['diagramUrl'] as String?,
        pastYearReference: json['pastYearReference'] as int?,
        createdAt: json['createdAt'] != null 
            ? DateTime.parse(json['createdAt'] as String)
            : DateTime.now(),
        createdBy: json['createdBy'] as String? ?? 'coach kai ai',
      );
    } catch (e) {
      pskyLog('Error parsing ExamQuestion: $e');
      pskyLog('JSON data: $json');
      rethrow;
    }
  }

  // Helper to parse examBody (handles both name and displayName)
  static ExamBody _parseExamBody(dynamic examBodyValue) {
    if (examBodyValue == null) return ExamBody.waec;
    
    final String examBodyStr = examBodyValue.toString().toUpperCase();
    
    // Try to match by name first
    try {
      return ExamBody.values.firstWhere(
        (e) => e.name.toUpperCase() == examBodyStr,
      );
    } catch (_) {
      // If not found, try displayName
      try {
        return ExamBody.values.firstWhere(
          (e) => e.displayName.toUpperCase() == examBodyStr,
        );
      } catch (_) {
        // Default to WAEC if nothing matches
        return ExamBody.waec;
      }
    }
  }

  factory ExamQuestion.fromAi(Map<String, dynamic> json) {
    return ExamQuestion.fromJson(json);
  }
}