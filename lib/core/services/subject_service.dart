

// ============================================================================
// SUBJECT REPOSITORY (For managing subjects and searching)
// ============================================================================

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/subject.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/syllabus.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/topic.dart';
import 'package:injectable/injectable.dart';
@injectable
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

  // Get subject by ID
  Subject? getSubjectById(String id) {
    try {
      return _subjects.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get subject by code
  Subject? getSubjectByCode(String code) {
    try {
      return _subjects.firstWhere((s) => s.code == code);
    } catch (e) {
      return null;
    }
  }

  // Get subject by name
  Subject? getSubjectByName(String name) {
    try {
      return _subjects.firstWhere(
        (s) => s.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Search subjects by name
  List<Subject> searchSubjects(String query) {
    final lowerQuery = query.toLowerCase();
    return _subjects.where((subject) {
      return subject.name.toLowerCase().contains(lowerQuery) ||
          subject.code.toLowerCase().contains(lowerQuery) ||
          (subject.description?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  // Get subjects by category
  List<Subject> getSubjectsByCategory(SubjectCategory category) {
    return _subjects.where((s) => s.category == category).toList();
  }

  // Get compulsory subjects
  List<Subject> getCompulsorySubjects() {
    return _subjects.where((s) => s.isCompulsory).toList();
  }

  // Get subjects available in specific exam body
  List<Subject> getSubjectsByExamBody(ExamBody examBody) {
    return _subjects.where((s) => s.availableIn.contains(examBody)).toList();
  }

  // Search topics across all subjects
  Map<Subject, List<Topic>> searchTopicsAcrossSubjects(String query) {
    final results = <Subject, List<Topic>>{};
    for (var subject in _subjects) {
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

  // Clear all subjects
  void clear() {
    _subjects.clear();
  }
}

