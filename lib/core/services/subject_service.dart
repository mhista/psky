

// ============================================================================
// SUBJECT REPOSITORY (For managing subjects and searching)
// ============================================================================

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/subject.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/syllabus.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/topic.dart';
import 'package:injectable/injectable.dart';


// ============================================================================
// UPDATED SUBJECT REPOSITORY
// Now handles WAEC, NECO, and JAMB
// ============================================================================


@lazySingleton
class SubjectRepository {
  final List<Subject> _subjects = [];

  // Add subject
  void addSubject(Subject subject) {
    _subjects.add(subject);
  }

  // Add multiple subjects
  void addSubjects(List<Subject> subjects) {
    _subjects.addAll(subjects);
  }

  // Get all subjects
  List<Subject> getAllSubjects() => List.unmodifiable(_subjects);

  // Get subjects by exam body
  List<Subject> getSubjectsByExamBody(ExamBody examBody) {
    return _subjects.where((s) => s.availableIn.contains(examBody)).toList();
  }

  // Get subject by ID (now includes exam body in ID)
  Subject? getSubjectById(String id) {
    try {
      return _subjects.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get subject by code and exam body
  Subject? getSubjectByCodeAndExamBody(String code, ExamBody examBody) {
    try {
      return _subjects.firstWhere(
        (s) => s.code == code && s.availableIn.contains(examBody),
      );
    } catch (e) {
      return null;
    }
  }

  // Get subject by name and exam body
  Subject? getSubjectByNameAndExamBody(String name, ExamBody examBody) {
    try {
      return _subjects.firstWhere(
        (s) => s.name.toLowerCase() == name.toLowerCase() && 
               s.availableIn.contains(examBody),
      );
    } catch (e) {
      return null;
    }
  }

  // Get subject by code (returns first match across all exam bodies)
  Subject? getSubjectByCode(String code) {
    try {
      return _subjects.firstWhere((s) => s.code == code);
    } catch (e) {
      return null;
    }
  }

  // Get subject by name (returns first match across all exam bodies)
  Subject? getSubjectByName(String name) {
    try {
      return _subjects.firstWhere(
        (s) => s.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Search subjects across all exam bodies
  List<Subject> searchSubjects(String query, {ExamBody? examBody}) {
    final lowerQuery = query.toLowerCase();
    var results = _subjects.where((subject) {
      final matchesQuery = subject.name.toLowerCase().contains(lowerQuery) ||
          subject.code.toLowerCase().contains(lowerQuery) ||
          (subject.description?.toLowerCase().contains(lowerQuery) ?? false);
      
      if (examBody != null) {
        return matchesQuery && subject.availableIn.contains(examBody);
      }
      return matchesQuery;
    });
    
    return results.toList();
  }

  // Get subjects by category and optionally filter by exam body
  List<Subject> getSubjectsByCategory(SubjectCategory category, {ExamBody? examBody}) {
    var results = _subjects.where((s) => s.category == category);
    
    if (examBody != null) {
      results = results.where((s) => s.availableIn.contains(examBody));
    }
    
    return results.toList();
  }

  // Get compulsory subjects for a specific exam body
  List<Subject> getCompulsorySubjects({ExamBody? examBody}) {
    var results = _subjects.where((s) => s.isCompulsory);
    
    if (examBody != null) {
      results = results.where((s) => s.availableIn.contains(examBody));
    }
    
    return results.toList();
  }

  // Search topics across all subjects (optionally filter by exam body)
  Map<Subject, List<Topic>> searchTopicsAcrossSubjects(String query, {ExamBody? examBody}) {
    final results = <Subject, List<Topic>>{};
    
    var subjectsToSearch = _subjects;
    if (examBody != null) {
      subjectsToSearch = _subjects.where((s) => s.availableIn.contains(examBody)).toList();
    }
    
    for (var subject in subjectsToSearch) {
      final topics = subject.searchTopics(query);
      if (topics.isNotEmpty) {
        results[subject] = topics;
      }
    }
    return results;
  }

  // Get syllabus for a subject
  Syllabus? getSyllabus({
    required String subjectId,
    required ExamBody examBody,
    int? year,
  }) {
    final subject = getSubjectById(subjectId);
    return subject?.getSyllabus(examBody: examBody, year: year);
  }

  // Get syllabus by subject name
  Syllabus? getSyllabusByName({
    required String subjectName,
    required ExamBody examBody,
    int? year,
  }) {
    final subject = getSubjectByNameAndExamBody(subjectName, examBody);
    return subject?.getSyllabus(examBody: examBody, year: year);
  }

  // Clear all subjects
  void clear() {
    _subjects.clear();
  }

  // Load from JSON array
  void loadFromJson(List<dynamic> jsonArray) {
    clear();
    final subjects = jsonArray
        .map((json) => Subject.fromJson(json as Map<String, dynamic>))
        .toList();
    addSubjects(subjects);
  }

  // Export to JSON array (optionally filter by exam body)
  List<Map<String, dynamic>> exportToJson({ExamBody? examBody}) {
    if (examBody != null) {
      return getSubjectsByExamBody(examBody).map((s) => s.toJson()).toList();
    }
    return _subjects.map((s) => s.toJson()).toList();
  }

  // Get statistics by exam body
  Map<String, dynamic> getStatisticsByExamBody(ExamBody examBody) {
    final subjects = getSubjectsByExamBody(examBody);
    int totalTopics = 0;
    int totalSubtopics = 0;

    for (var subject in subjects) {
      for (var syllabus in subject.syllabuses) {
        if (syllabus.examBody == examBody) {
          totalTopics += syllabus.topics.length;
          for (var topic in syllabus.topics) {
            totalSubtopics += topic.subtopics.length;
          }
        }
      }
    }

    return {
      'examBody': examBody.name,
      'totalSubjects': subjects.length,
      'compulsorySubjects': subjects.where((s) => s.isCompulsory).length,
      'totalTopics': totalTopics,
      'totalSubtopics': totalSubtopics,
      'categoryCounts': {
        for (var category in SubjectCategory.values)
          category.name: subjects.where((s) => s.category == category).length,
      },
    };
  }
}
