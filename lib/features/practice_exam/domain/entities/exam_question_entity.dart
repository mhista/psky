// ============================================================================
// EXAM PROGRESS & QUESTION MODELS
// Enhanced models for tracking exam progress and storing AI-generated questions
// ============================================================================


// ============================================================================
// QUESTION MODELS
// ============================================================================

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';

/// Represents a single exam question with complete details
class ExamQuestionEntity {
  final String questionId;
  final int questionNumber;
  final String questionText;
  final QuestionType questionType;
  final String subjectId;
  final String topicId;
  final ExamBody examBody;
  final DifficultyLevel difficultyLevel;
  final int marks;
  final int timeEstimateMinutes;
  
  // For objective questions
  final List<QuestionOption>? options;
  final String? correctAnswer; // Option ID for objective
  final String? selectedAnswer;
  
  // For essay questions
  final String? answerText;
  final MarkingScheme? markingScheme;
  
  // Educational content
  final String explanation;
  final List<String> commonMistakes;
  final String syllabusReference;
  
  // Visual aids
  final bool requiresDiagram;
  final String? diagramDescription;
  final String? diagramUrl;
  
  // Metadata
  final int? pastYearReference;
  final DateTime createdAt;
  final String createdBy; // 'coach_kai' or 'official'

  ExamQuestionEntity({
    required this.questionId,
    required this.questionNumber,
    required this.questionText,
    required this.questionType,
    required this.subjectId,
    required this.topicId,
    required this.examBody,
    required this.difficultyLevel,
    required this.marks,
    required this.timeEstimateMinutes,
    this.options,
    this.correctAnswer,
    this.selectedAnswer,

    this.answerText,
    this.markingScheme,
    required this.explanation,
    this.commonMistakes = const [],
    required this.syllabusReference,
    this.requiresDiagram = false,
    this.diagramDescription,
    this.diagramUrl,
    this.pastYearReference,
    DateTime? createdAt,
    this.createdBy = 'coach_kai',
  }) : createdAt = createdAt ?? DateTime.now();

}




/// Question option for multiple choice questions
class QuestionOption {
  final String id; // A, B, C, D, E
  final String text;
  final String? imageUrl;

  QuestionOption({
    required this.id,
    required this.text,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'imageUrl': imageUrl,
    };
  }

  factory QuestionOption.fromJson(Map<String, dynamic> json) {
    return QuestionOption(
      id: json['id'] as String,
      text: json['text'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}

/// Marking scheme for essay questions
class MarkingScheme {
  final List<MarkingPoint> points;
  final int totalMarks;

  MarkingScheme({
    required this.points,
    required this.totalMarks,
  });

  Map<String, dynamic> toJson() {
    return {
      'points': points.map((p) => p.toJson()).toList(),
      'totalMarks': totalMarks,
    };
  }

  factory MarkingScheme.fromJson(Map<String, dynamic> json) {
    return MarkingScheme(
      points: (json['points'] as List)
          .map((p) => MarkingPoint.fromJson(p as Map<String, dynamic>))
          .toList(),
      totalMarks: json['totalMarks'] as int,
    );
  }
}

/// Individual marking point
class MarkingPoint {
  final String criterion;
  final int marks;
  final String? description;

  MarkingPoint({
    required this.criterion,
    required this.marks,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'criterion': criterion,
      'marks': marks,
      'description': description,
    };
  }

  factory MarkingPoint.fromJson(Map<String, dynamic> json) {
    return MarkingPoint(
      criterion: json['criterion'] as String,
      marks: json['marks'] as int,
      description: json['description'] as String?,
    );
  }
}
