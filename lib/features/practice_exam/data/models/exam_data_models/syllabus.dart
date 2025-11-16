// ============================================================================
// SYLLABUS MODEL
// ============================================================================

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/exampaper.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/topic.dart';

class Syllabus {
  final String id;
  final String subjectId;
  final ExamBody examBody;
  final int year;
  final List<String> aims;
  final List<ExamPaper> papers;
  final List<Topic> topics;
  final Map<String, dynamic>? additionalInfo; // For any extra information

  Syllabus({
    required this.id,
    required this.subjectId,
    required this.examBody,
    required this.year,
    this.aims = const [],
    this.papers = const [],
    this.topics = const [],
    this.additionalInfo,
  });

  // Get topics by name search
  List<Topic> searchTopics(String query) {
    final lowerQuery = query.toLowerCase();
    return topics.where((topic) {
      return topic.name.toLowerCase().contains(lowerQuery) ||
          topic.description.toLowerCase().contains(lowerQuery) ||
          topic.subtopics.any((sub) => sub.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  // Get topic by ID
  Topic? getTopicById(String topicId) {
    try {
      return topics.firstWhere((topic) => topic.id == topicId);
    } catch (e) {
      return null;
    }
  }

  // Get total marks for all papers
  int get totalMarks {
    return papers.fold(0, (sum, paper) => sum + paper.totalMarks);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectId': subjectId,
      'examBody': examBody.name,
      'year': year,
      'aims': aims,
      'papers': papers.map((p) => p.toJson()).toList(),
      'topics': topics.map((t) => t.toJson()).toList(),
      'additionalInfo': additionalInfo,
    };
  }

  factory Syllabus.fromJson(Map<String, dynamic> json) {
    return Syllabus(
      id: json['id'] as String,
      subjectId: json['subjectId'] as String,
      examBody: ExamBody.values.firstWhere(
        (e) => e.name == json['examBody'],
        orElse: () => ExamBody.waec,
      ),
      year: json['year'] as int,
      aims: (json['aims'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      papers: (json['papers'] as List<dynamic>?)
              ?.map((e) => ExamPaper.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      topics: (json['topics'] as List<dynamic>?)
              ?.map((e) => Topic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
    );
  }
}
