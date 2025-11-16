import 'dart:convert';

import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/subject.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/exam_question.dart';

class AiQuestionData {
  final String? id;
  final String studentName;
  final String subject;
  final String examBody;
  final List<String>? topics;
  final String paperType;
  final int numberOfQuestions;
  final int totalNumberOfQuestions;
  final String? difficultyLevel;
  final int? yearReference;
  final List<String>? excludeQuestions;
  final bool? focusWeakAreas;
  final int? timeLimitMinutes;

  AiQuestionData(
      {this.id,
      required this.studentName,
      required this.subject,
      required this.examBody,
      this.topics,
      required this.paperType,
      required this.numberOfQuestions,
      required this.totalNumberOfQuestions,
      this.difficultyLevel,
      this.yearReference,
      this.excludeQuestions,
      this.focusWeakAreas,
      this.timeLimitMinutes});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'studentName': studentName});
    result.addAll({'subject': subject});
    result.addAll({'examBody': examBody});
    if (topics != null) {
      result.addAll({'topics': topics});
    }
    result.addAll({'paperType': paperType});
    result.addAll({'numberOfQuestions': numberOfQuestions});
    result.addAll({'totalNumberOfQuestions': totalNumberOfQuestions});

    if (difficultyLevel != null) {
      result.addAll({'difficultyLevel': difficultyLevel});
    }
    if (yearReference != null) {
      result.addAll({'yearReference': yearReference});
    }
    if (excludeQuestions != null) {
      result.addAll({'excludeQuestions': excludeQuestions});
    }
    if (focusWeakAreas != null) {
      result.addAll({'focusWeakAreas': focusWeakAreas});
    }
    if (timeLimitMinutes != null) {
      result.addAll({'timeLimitMinutes': timeLimitMinutes});
    }

    return result;
  }

  factory AiQuestionData.fromMap(Map<String, dynamic> map) {
    return AiQuestionData(
      id: map['id']?.toString(),
      studentName: map['studentName'] ?? '',
      subject: map['subject'] ?? '',
      examBody: map['examBody'] ?? '',
      topics: map['topics'] != null ? List<String>.from(map['topics']) : null,
      paperType: map['paperType'] ?? '',
      numberOfQuestions: map['numberOfQuestions']?.toInt() ?? 0,
      totalNumberOfQuestions: map['totalNumberOfQuestions']?.toInt() ?? 0,
      difficultyLevel: map['difficultyLevel']?.toString(),
      yearReference: map['yearReference']?.toInt(),
      excludeQuestions: map['excludeQuestions'] != null
          ? List<String>.from(map['excludeQuestions'])
          : null,
      focusWeakAreas: map['focusWeakAreas'] as bool?,
      timeLimitMinutes: map['timeLimitMinutes']?.toInt(),
    );
  }

  // ============================================================================
  // COPY WITH METHOD
  // ============================================================================

  AiQuestionData copyWith({
    String? id,
    String? studentName,
    String? subject,
    String? examBody,
    List<String>? topics,
    String? paperType,
    int? numberOfQuestions,
    int? totalNumberOfQuestions,
    String? difficultyLevel,
    int? yearReference,
    List<String>? excludeQuestions,
    bool? focusWeakAreas,
    int? timeLimitMinutes,
  }) {
    return AiQuestionData(
      id: id ?? this.id,
      studentName: studentName ?? this.studentName,
      subject: subject ?? this.subject,
      examBody: examBody ?? this.examBody,
      topics: topics ?? this.topics,
      paperType: paperType ?? this.paperType,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      totalNumberOfQuestions:
          totalNumberOfQuestions ?? this.totalNumberOfQuestions,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      yearReference: yearReference ?? this.yearReference,
      excludeQuestions: excludeQuestions ?? this.excludeQuestions,
      focusWeakAreas: focusWeakAreas ?? this.focusWeakAreas,
      timeLimitMinutes: timeLimitMinutes ?? this.timeLimitMinutes,
    );
  }

  Map<String, dynamic> toAiFormat() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'student_name': studentName});
    result.addAll({'subject': subject});
    result.addAll({'examBody': examBody});
    if (topics != null) {
      result.addAll({'topics': topics});
    }
    result.addAll({'paper_type': paperType});
    result.addAll({'number_of_questions': numberOfQuestions});

    if (difficultyLevel != null) {
      result.addAll({'difficulty_level': difficultyLevel});
    }
    if (yearReference != null) {
      result.addAll({'year_reference': yearReference});
    }
    if (excludeQuestions != null) {
      result.addAll({'exclude_questions': excludeQuestions});
    }
    if (focusWeakAreas != null) {
      result.addAll({'focus_weak_areas': focusWeakAreas});
    }
    if (timeLimitMinutes != null) {
      result.addAll({'time_limit_minutes': timeLimitMinutes});
    }

    return result;
  }

  String toJson() => json.encode(toMap());
  String toAiJson() => json.encode(toAiFormat());

  factory AiQuestionData.fromJson(String source) =>
      AiQuestionData.fromMap(json.decode(source));

  ExamBody getExamBody() =>
      ExamBodyExtension.fromString(examBody) ?? ExamBody.waec;
  PaperType getPaperType() =>
      PaperTypeExtension.fromString(paperType) ?? PaperType.objective;

  Subject? getSubjectFromName() =>
      getIt<SubjectRepository>().getSubjectByNameAndExamBody(
          subject, ExamBodyExtension.fromString(examBody) ?? ExamBody.waec);

      
          @override
          String toString() {
            return 'AiQuestionData(id: $id, studentName: $studentName, subject: $subject, examBody: $examBody, topics: ${topics ?? []}, paperType: $paperType, numberOfQuestions: $numberOfQuestions, totalNumberOfQuestions: $totalNumberOfQuestions, difficultyLevel: $difficultyLevel, yearReference: $yearReference, excludeQuestions: ${excludeQuestions ?? []}, focusWeakAreas: $focusWeakAreas, timeLimitMinutes: $timeLimitMinutes)';
          }

          /// Returns a human-friendly, multiline representation suitable for logs or
          /// console output.
          String toPrintableString() {
            final buf = StringBuffer()
              ..writeln('AiQuestionData:')
              ..writeln('  id: ${id ?? '-'}')
              ..writeln('  studentName: $studentName')
              ..writeln('  subject: $subject')
              ..writeln('  examBody: $examBody')
              ..writeln('  topics: ${topics == null || topics!.isEmpty ? '-' : topics!.join(", ")}')
              ..writeln('  paperType: $paperType')
              ..writeln('  numberOfQuestions: $numberOfQuestions')
              ..writeln('  totalNumberOfQuestions: $totalNumberOfQuestions')
              ..writeln('  difficultyLevel: ${difficultyLevel ?? '-'}')
              ..writeln('  yearReference: ${yearReference?.toString() ?? '-'}')
              ..writeln('  excludeQuestions: ${excludeQuestions == null || excludeQuestions!.isEmpty ? '-' : excludeQuestions!.join(", ")}')
              ..writeln('  focusWeakAreas: ${focusWeakAreas == null ? '-' : focusWeakAreas}')
              ..writeln('  timeLimitMinutes: ${timeLimitMinutes?.toString() ?? '-'}');

            return buf.toString();
          }
}
