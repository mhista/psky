// ============================================================================
// EXAM PAPER MODEL
// ============================================================================

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';

class ExamPaper {
  final String id;
  final String name; // e.g., "Paper 1", "Paper 2"
  final PaperType type;
  final String duration; // e.g., "1½ hours"
  final int totalMarks;
  final String description;
  final int? numberOfQuestions;
  final int? questionsToAnswer;

  ExamPaper({
    required this.id,
    required this.name,
    required this.type,
    required this.duration,
    required this.totalMarks,
    this.description = '',
    this.numberOfQuestions,
    this.questionsToAnswer,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'duration': duration,
      'totalMarks': totalMarks,
      'description': description,
      'numberOfQuestions': numberOfQuestions,
      'questionsToAnswer': questionsToAnswer,
    };
  }

  factory ExamPaper.fromJson(Map<String, dynamic> json) {
    return ExamPaper(
      id: json['id'] as String,
      name: json['name'] as String,
      type: PaperType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PaperType.multipleChoice,
      ),
      duration: json['duration'] as String,
      totalMarks: json['totalMarks'] as int,
      description: json['description'] as String? ?? '',
      numberOfQuestions: json['numberOfQuestions'] as int?,
      questionsToAnswer: json['questionsToAnswer'] as int?,
    );
  }
}
