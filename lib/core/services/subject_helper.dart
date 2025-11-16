
// ============================================================================
// HELPER FUNCTIONS
// ============================================================================
import 'package:ahiaa_web/core/data/populated_jamb_data.dart';
import 'package:ahiaa_web/core/data/populated_neco_data.dart';
import 'package:ahiaa_web/core/data/prepopulated_waec_data.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/subject.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:injectable/injectable.dart';

// ============================================================================
// UPDATED SUBJECT DATA HELPER
// Now supports WAEC, NECO, and JAMB
// ============================================================================

import 'package:injectable/injectable.dart';

@lazySingleton
class SubjectDataHelper {
  // Load all subjects from all exam bodies into repository
   SubjectRepository loadAllSubjects({List<ExamBody>? examBodies}) {
    final repository = getIt<SubjectRepository>();
    
    final bodiesToLoad = examBodies ?? ExamBody.values;
    
    for (var examBody in bodiesToLoad) {
      switch (examBody) {
        case ExamBody.waec:
          repository.addSubjects(WaecSubjectsData.getAllSubjects());
          break;
        case ExamBody.neco:
          repository.addSubjects(NecoSubjectsData.getAllSubjects());
          break;
        case ExamBody.jamb:
          repository.addSubjects(JambSubjectsData.getAllSubjects());
          break;
      }
    }
    
    return repository;
  }

  // Load subjects for a specific exam body
   SubjectRepository loadSubjectsForExamBody(ExamBody examBody) {
    return loadAllSubjects(examBodies: [examBody]);
  }

  // Get subjects by category (across all exam bodies or specific one)
   List<Subject> getSubjectsByCategory(
    SubjectCategory category, {
    ExamBody? examBody,
  }) {
    final allSubjects = <Subject>[];
    
    if (examBody == null || examBody == ExamBody.waec) {
      allSubjects.addAll(
        WaecSubjectsData.getAllSubjects()
            .where((s) => s.category == category),
      );
    }
    if (examBody == null || examBody == ExamBody.neco) {
      allSubjects.addAll(
        NecoSubjectsData.getAllSubjects()
            .where((s) => s.category == category),
      );
    }
    if (examBody == null || examBody == ExamBody.jamb) {
      allSubjects.addAll(
        JambSubjectsData.getAllSubjects()
            .where((s) => s.category == category),
      );
    }
    
    return allSubjects;
  }

  // Get compulsory subjects (across all exam bodies or specific one)
   List<Subject> getCompulsorySubjects({ExamBody? examBody}) {
    final allSubjects = <Subject>[];
    
    if (examBody == null || examBody == ExamBody.waec) {
      allSubjects.addAll(
        WaecSubjectsData.getAllSubjects()
            .where((s) => s.isCompulsory),
      );
    }
    if (examBody == null || examBody == ExamBody.neco) {
      allSubjects.addAll(
        NecoSubjectsData.getAllSubjects()
            .where((s) => s.isCompulsory),
      );
    }
    if (examBody == null || examBody == ExamBody.jamb) {
      allSubjects.addAll(
        JambSubjectsData.getAllSubjects()
            .where((s) => s.isCompulsory),
      );
    }
    
    return allSubjects;
  }

  // Export all subjects to JSON (optionally filter by exam body)
   List<Map<String, dynamic>> exportAllSubjectsToJson({ExamBody? examBody}) {
    final allSubjects = <Subject>[];
    
    if (examBody == null || examBody == ExamBody.waec) {
      allSubjects.addAll(WaecSubjectsData.getAllSubjects());
    }
    if (examBody == null || examBody == ExamBody.neco) {
      allSubjects.addAll(NecoSubjectsData.getAllSubjects());
    }
    if (examBody == null || examBody == ExamBody.jamb) {
      allSubjects.addAll(JambSubjectsData.getAllSubjects());
    }
    
    return allSubjects.map((s) => s.toJson()).toList();
  }

  // Print subjects summary by exam body
   void printSubjectsSummary({ExamBody? examBody}) {
    final bodies = examBody != null ? [examBody] : ExamBody.values;
    
    for (var body in bodies) {
      print('\n=== ${body.name.toUpperCase()} SUBJECTS ===');
      
      final subjects = body == ExamBody.waec
          ? WaecSubjectsData.getAllSubjects()
          : body == ExamBody.neco
              ? NecoSubjectsData.getAllSubjects()
              : JambSubjectsData.getAllSubjects();
      
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
  }

  // Get total topics count (across all exam bodies or specific one)
   int getTotalTopicsCount({ExamBody? examBody}) {
    int count = 0;
    
    final subjects = <Subject>[];
    if (examBody == null || examBody == ExamBody.waec) {
      subjects.addAll(WaecSubjectsData.getAllSubjects());
    }
    if (examBody == null || examBody == ExamBody.neco) {
      subjects.addAll(NecoSubjectsData.getAllSubjects());
    }
    if (examBody == null || examBody == ExamBody.jamb) {
      subjects.addAll(JambSubjectsData.getAllSubjects());
    }
    
    for (var subject in subjects) {
      for (var syllabus in subject.syllabuses) {
        if (examBody == null || syllabus.examBody == examBody) {
          count += syllabus.topics.length;
        }
      }
    }
    return count;
  }

  // Get comprehensive statistics across all exam bodies
   Map<String, dynamic> getStatistics({ExamBody? examBody}) {
    final stats = <String, dynamic>{};
    
    final bodies = examBody != null ? [examBody] : ExamBody.values;
    
    for (var body in bodies) {
      final subjects = body == ExamBody.waec
          ? WaecSubjectsData.getAllSubjects()
          : body == ExamBody.neco
              ? NecoSubjectsData.getAllSubjects()
              : JambSubjectsData.getAllSubjects();
      
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

      stats[body.name] = {
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
    
    return stats;
  }

  // Compare subjects across exam bodies
   Map<String, dynamic> compareExamBodies() {
    return {
      'waec': WaecSubjectsData.getAllSubjects().length,
      'neco': NecoSubjectsData.getAllSubjects().length,
      'jamb': JambSubjectsData.getAllSubjects().length,
      'commonSubjects': _findCommonSubjects(),
    };
  }

   List<String> _findCommonSubjects() {
    final waecSubjects = WaecSubjectsData.getAllSubjects().map((s) => s.name).toSet();
    final necoSubjects = NecoSubjectsData.getAllSubjects().map((s) => s.name).toSet();
    final jambSubjects = JambSubjectsData.getAllSubjects().map((s) => s.name).toSet();
    
    return waecSubjects.intersection(necoSubjects).intersection(jambSubjects).toList();
  }
}