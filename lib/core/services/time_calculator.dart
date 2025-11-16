// ============================================================================
// SUBJECT TIME CALCULATOR
// Calculates total estimated time from Subject model by parsing paper durations
// ============================================================================

import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/subject.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/syllabus.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/exampaper.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';

class SubjectTimeCalculator {
  /// Calculate total estimated time for a subject
  /// Returns formatted time as "HH:MM" (e.g., "04:15" for 4 hours 15 minutes)
  static String calculateSubjectTime(Subject subject, {ExamBody? examBody, int? year}) {
    final totalMinutes = calculateSubjectTimeInMinutes(subject, examBody: examBody, year: year);
    return formatTimeFromMinutes(totalMinutes);
  }

  /// Calculate total time in minutes
  static int calculateSubjectTimeInMinutes(Subject subject, {ExamBody? examBody, int? year}) {
    // Get the appropriate syllabus
    Syllabus? targetSyllabus;
    
    if (examBody != null && year != null) {
      // Find specific syllabus
      targetSyllabus = subject.syllabuses.firstWhere(
        (s) => s.examBody == examBody && s.year == year,
        orElse: () => subject.syllabuses.isNotEmpty ? subject.syllabuses.first : null!,
      );
    } else if (subject.syllabuses.isNotEmpty) {
      // Use first available syllabus
      targetSyllabus = subject.syllabuses.first;
    }

    if (targetSyllabus == null || targetSyllabus.papers.isEmpty) {
      return 0;
    }

    // Calculate total time from all papers
    int totalMinutes = 0;
    for (final paper in targetSyllabus.papers) {
      totalMinutes += parseDurationToMinutes(paper.duration);
    }

    return totalMinutes;
  }

  /// Parse duration string to minutes
  /// Handles formats like: "2½ hours", "1 hour", "45 minutes", "1½ hours", "2 hours 30 minutes"
  static int parseDurationToMinutes(String duration) {
    if (duration.isEmpty) return 0;

    duration = duration.toLowerCase().trim();
    int totalMinutes = 0;

    // Replace special characters
    duration = duration.replaceAll('½', '.5');
    duration = duration.replaceAll('¼', '.25');
    duration = duration.replaceAll('¾', '.75');

    // Pattern 1: "2.5 hours" or "2 hours"
    final hoursRegex = RegExp(r'(\d+\.?\d*)\s*(?:hour|hr|h)');
    final hoursMatch = hoursRegex.firstMatch(duration);
    if (hoursMatch != null) {
      final hours = double.parse(hoursMatch.group(1)!);
      totalMinutes += (hours * 60).round();
    }

    // Pattern 2: "45 minutes" or "30 min"
    final minutesRegex = RegExp(r'(\d+)\s*(?:minute|min|m)(?!.*hour)');
    final minutesMatch = minutesRegex.firstMatch(duration);
    if (minutesMatch != null && hoursMatch == null) {
      // Only add if no hours were found (to avoid double counting)
      final minutes = int.parse(minutesMatch.group(1)!);
      totalMinutes += minutes;
    }

    // Pattern 3: Combined "2 hours 30 minutes"
    final combinedRegex = RegExp(r'(\d+)\s*(?:hour|hr|h).*?(\d+)\s*(?:minute|min|m)');
    final combinedMatch = combinedRegex.firstMatch(duration);
    if (combinedMatch != null) {
      final hours = int.parse(combinedMatch.group(1)!);
      final minutes = int.parse(combinedMatch.group(2)!);
      totalMinutes = (hours * 60) + minutes;
    }

    return totalMinutes;
  }

  /// Format minutes to "HH:MM" format
  static String formatTimeFromMinutes(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  /// Get detailed breakdown of time per paper
  static Map<String, String> getTimeBreakdown(Subject subject, {ExamBody? examBody, int? year}) {
    final Map<String, String> breakdown = {};
    
    Syllabus? targetSyllabus;
    if (examBody != null && year != null) {
      targetSyllabus = subject.syllabuses.firstWhere(
        (s) => s.examBody == examBody && s.year == year,
        orElse: () => subject.syllabuses.isNotEmpty ? subject.syllabuses.first : null!,
      );
    } else if (subject.syllabuses.isNotEmpty) {
      targetSyllabus = subject.syllabuses.first;
    }

    if (targetSyllabus == null) return breakdown;

    for (final paper in targetSyllabus.papers) {
      final minutes = parseDurationToMinutes(paper.duration);
      breakdown[paper.name] = formatTimeFromMinutes(minutes);
    }

    // Add total
    final totalMinutes = calculateSubjectTimeInMinutes(subject, examBody: examBody, year: year);
    breakdown['Total'] = formatTimeFromMinutes(totalMinutes);

    return breakdown;
  }

  /// Get human-readable time string
  static String getReadableTime(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    
    if (hours == 0) {
      return '$minutes minutes';
    } else if (minutes == 0) {
      return '$hours ${hours == 1 ? 'hour' : 'hours'}';
    } else {
      return '$hours ${hours == 1 ? 'hour' : 'hours'} $minutes minutes';
    }
  }

  /// Validate if duration string is parseable
  static bool isValidDuration(String duration) {
    try {
      final minutes = parseDurationToMinutes(duration);
      return minutes > 0;
    } catch (e) {
      return false;
    }
  }

  /// Get time for specific paper type
  static String getTimeForPaperType(Subject subject, PaperType paperType, {ExamBody? examBody, int? year}) {
    Syllabus? targetSyllabus;
    if (examBody != null && year != null) {
      targetSyllabus = subject.syllabuses.firstWhere(
        (s) => s.examBody == examBody && s.year == year,
        orElse: () => subject.syllabuses.isNotEmpty ? subject.syllabuses.first : null!,
      );
    } else if (subject.syllabuses.isNotEmpty) {
      targetSyllabus = subject.syllabuses.first;
    }

    if (targetSyllabus == null) return '00:00';

    for (final paper in targetSyllabus.papers) {
      if (paper.type == paperType) {
        final minutes = parseDurationToMinutes(paper.duration);
        return formatTimeFromMinutes(minutes);
      }
    }

    return '00:00';
  }
}

// ============================================================================
// EXTENSION ON SUBJECT CLASS (Optional - for convenience)
// ============================================================================

extension SubjectTimeExtension on Subject {
  /// Get formatted total time "HH:MM"
  String get formattedTime {
    return SubjectTimeCalculator.calculateSubjectTime(this);
  }

  /// Get total time in minutes
  int get totalMinutes {
    return SubjectTimeCalculator.calculateSubjectTimeInMinutes(this);
  }

  /// Get readable time string
  String get readableTime {
    return SubjectTimeCalculator.getReadableTime(totalMinutes);
  }

  /// Get time breakdown per paper
  Map<String, String> get timeBreakdown {
    return SubjectTimeCalculator.getTimeBreakdown(this);
  }

  /// Get time for specific exam body and year
  String getTimeFor({ExamBody? examBody, int? year}) {
    return SubjectTimeCalculator.calculateSubjectTime(this, examBody: examBody, year: year);
  }

}

// ============================================================================
// USAGE EXAMPLES
// ============================================================================

void demonstrateUsage() {
  // Assuming you have a subject loaded from WaecSubjectsData
  // final mathSubject = WaecSubjectsData._generalMathematics();
  
  print('=== SUBJECT TIME CALCULATOR DEMO ===\n');

  // Example 1: Calculate total time
  // String totalTime = SubjectTimeCalculator.calculateSubjectTime(mathSubject);
  // print('Total Time: $totalTime'); // Output: "04:00"

  // Example 2: Get time in minutes
  // int minutes = SubjectTimeCalculator.calculateSubjectTimeInMinutes(mathSubject);
  // print('Total Minutes: $minutes'); // Output: 240

  // Example 3: Get readable time
  // String readable = SubjectTimeCalculator.getReadableTime(minutes);
  // print('Readable: $readable'); // Output: "4 hours"

  // Example 4: Get time breakdown
  // Map<String, String> breakdown = SubjectTimeCalculator.getTimeBreakdown(mathSubject);
  // print('\nTime Breakdown:');
  // breakdown.forEach((paper, time) {
  //   print('  $paper: $time');
  // });
  // Output:
  //   Paper 1: 01:30
  //   Paper 2: 02:30
  //   Total: 04:00

  // Example 5: Using extension methods (if added to Subject class)
  // print('\nUsing Extension Methods:');
  // print('Formatted: ${mathSubject.formattedTime}');
  // print('Readable: ${mathSubject.readableTime}');
  // print('Total Minutes: ${mathSubject.totalMinutes}');

  // Example 6: Test duration parsing
  print('\nDuration Parsing Tests:');
  final testDurations = [
    '2½ hours',
    '1 hour',
    '45 minutes',
    '1½ hours',
    '2 hours 30 minutes',
    '30 minutes',
    '3 hours',
  ];

  for (final duration in testDurations) {
    final minutes = SubjectTimeCalculator.parseDurationToMinutes(duration);
    final formatted = SubjectTimeCalculator.formatTimeFromMinutes(minutes);
    print('  "$duration" -> $minutes min -> $formatted');
  }
}

// ============================================================================
// BATCH CALCULATOR FOR MULTIPLE SUBJECTS
// ============================================================================

class BatchTimeCalculator {
  /// Calculate total time for multiple subjects
  static String calculateTotalTimeForSubjects(List<Subject?> subjects) {
    if(subjects.isEmpty) return '00:00';

    int totalMinutes = 0;
    for (final subject in subjects) {
      totalMinutes += SubjectTimeCalculator.calculateSubjectTimeInMinutes(subject!);
    }
    return SubjectTimeCalculator.formatTimeFromMinutes(totalMinutes);
  }

  /// Get detailed breakdown for multiple subjects
  static Map<String, String> getSubjectsBreakdown(List<Subject> subjects) {
    final Map<String, String> breakdown = {};
    int totalMinutes = 0;

    for (final subject in subjects) {
      final minutes = SubjectTimeCalculator.calculateSubjectTimeInMinutes(subject);
      totalMinutes += minutes;
      breakdown[subject.name] = SubjectTimeCalculator.formatTimeFromMinutes(minutes);
    }

    breakdown['Total'] = SubjectTimeCalculator.formatTimeFromMinutes(totalMinutes);
    return breakdown;
  }

  /// Calculate average time per subject
  static String calculateAverageTime(List<Subject> subjects) {
    if (subjects.isEmpty) return '00:00';
    
    int totalMinutes = 0;
    for (final subject in subjects) {
      totalMinutes += SubjectTimeCalculator.calculateSubjectTimeInMinutes(subject);
    }
    
    final averageMinutes = totalMinutes ~/ subjects.length;
    return SubjectTimeCalculator.formatTimeFromMinutes(averageMinutes);
  }
}