

// ============================================================================
// SUBJECT MODEL
// ============================================================================

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/syllabus.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/topic.dart';

class Subject {
  final String id;
  final String name;
  final String code; // WAEC subject code
  final SubjectCategory category;
  final List<ExamBody> availableIn; // Which exam bodies offer this subject
  final bool isCompulsory;
  final String? description;
  final List<Syllabus> syllabuses; // Syllabuses for different exam bodies/years

  Subject({
    required this.id,
    required this.name,
    required this.code,
    required this.category,
    this.availableIn = const [ExamBody.waec, ExamBody.neco],
    this.isCompulsory = false,
    this.description,
    this.syllabuses = const [],
  });

  // Get syllabus by exam body and year
  Syllabus? getSyllabus({
    required ExamBody examBody,
    int? year,
  }) {
    final filteredSyllabuses = syllabuses.where((s) => s.examBody == examBody);
    
    if (year != null) {
      try {
        return filteredSyllabuses.firstWhere((s) => s.year == year);
      } catch (e) {
        return null;
      }
    }
    
    // Return the most recent syllabus if year not specified
    if (filteredSyllabuses.isEmpty) return null;
    return filteredSyllabuses.reduce(
      (a, b) => a.year > b.year ? a : b,
    );
  }

  // Get all topics across all syllabuses
  List<Topic> getAllTopics() {
    final allTopics = <Topic>[];
    for (var syllabus in syllabuses) {
      allTopics.addAll(syllabus.topics);
    }
    return allTopics;
  }

  // Search topics across all syllabuses
  List<Topic> searchTopics(String query) {
    final allTopics = <Topic>[];
    for (var syllabus in syllabuses) {
      allTopics.addAll(syllabus.searchTopics(query));
    }
    return allTopics;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'category': category.name,
      'availableIn': availableIn.map((e) => e.name).toList(),
      'isCompulsory': isCompulsory,
      'description': description,
      'syllabuses': syllabuses.map((s) => s.toJson()).toList(),
    };
  }

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      category: SubjectCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => SubjectCategory.compulsory,
      ),
      availableIn: (json['availableIn'] as List<dynamic>?)
              ?.map((e) => ExamBody.values.firstWhere(
                    (eb) => eb.name == e,
                    orElse: () => ExamBody.waec,
                  ))
              .toList() ??
          [ExamBody.waec, ExamBody.neco],
      isCompulsory: json['isCompulsory'] as bool? ?? false,
      description: json['description'] as String?,
      syllabuses: (json['syllabuses'] as List<dynamic>?)
              ?.map((e) => Syllabus.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Subject copyWith({
    String? id,
    String? name,
    String? code,
    SubjectCategory? category,
    List<ExamBody>? availableIn,
    bool? isCompulsory,
    String? description,
    List<Syllabus>? syllabuses,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      category: category ?? this.category,
      availableIn: availableIn ?? this.availableIn,
      isCompulsory: isCompulsory ?? this.isCompulsory,
      description: description ?? this.description,
      syllabuses: syllabuses ?? this.syllabuses,
    );
  }
}
