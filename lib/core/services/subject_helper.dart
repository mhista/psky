
// ============================================================================
// HELPER FUNCTIONS
// ============================================================================
import 'package:ahiaa_web/core/data/prepopulated_data.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/subject.dart';
import 'package:ahiaa_web/injection_container.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubjectDataHelper {
  // Load all subjects into repository
  static SubjectRepository loadAllSubjects() {
    final repository = getIt<SubjectRepository>();
    repository.addSubjects(WaecSubjectsData.getAllSubjects());
    return repository;
  }

  // Get subjects by category
  static List<Subject> getSubjectsByCategory(SubjectCategory category) {
    return WaecSubjectsData.getAllSubjects()
        .where((s) => s.category == category)
        .toList();
  }

  // Get compulsory subjects
  static List<Subject> getCompulsorySubjects() {
    return WaecSubjectsData.getAllSubjects()
        .where((s) => s.isCompulsory)
        .toList();
  }

  // Export all subjects to JSON
  static List<Map<String, dynamic>> exportAllSubjectsToJson() {
    return WaecSubjectsData.getAllSubjects()
        .map((s) => s.toJson())
        .toList();
  }

  // Print subjects summary
  static void printSubjectsSummary() {
    final subjects = WaecSubjectsData.getAllSubjects();
    print('Total Subjects: ${subjects.length}\n');

    for (var category in SubjectCategory.values) {
      final categorySubjects = subjects.where((s) => s.category == category);
      if (categorySubjects.isNotEmpty) {
        print('${category.name}: ${categorySubjects.length} subjects');
        for (var subject in categorySubjects) {
          print('  - ${subject.name} (${subject.code})');
        }
        print('');
      }
    }
  }

  // Get total topics count
  static int getTotalTopicsCount() {
    int count = 0;
    for (var subject in WaecSubjectsData.getAllSubjects()) {
      for (var syllabus in subject.syllabuses) {
        count += syllabus.topics.length;
      }
    }
    return count;
  }

  // Get subject statistics
  static Map<String, dynamic> getStatistics() {
    final subjects = WaecSubjectsData.getAllSubjects();
    int totalTopics = 0;
    int totalSubtopics = 0;

    for (var subject in subjects) {
      for (var syllabus in subject.syllabuses) {
        totalTopics += syllabus.topics.length;
        for (var topic in syllabus.topics) {
          totalSubtopics += topic.subtopics.length;
        }
      }
    }

    return {
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
