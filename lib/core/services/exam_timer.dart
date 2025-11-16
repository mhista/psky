// ============================================================================
// EXAM TIME HELPERS
// Calculate subject time, estimate time from questions, and run exam timers
// ============================================================================

import 'dart:async';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/subject.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/syllabus.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/exampaper.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:injectable/injectable.dart';

// ============================================================================
// 1. SUBJECT TIME CALCULATOR
// ============================================================================

class SubjectTimeHelper {
  /// Calculate total subject time from all papers
  /// Returns formatted time as "HH:MM"
  static String calculateSubjectTime(Subject subject, {ExamBody? examBody, int? year}) {
    final totalMinutes = _calculateTotalMinutes(subject, examBody: examBody, year: year);
    return _formatMinutesToHHMM(totalMinutes);
  }

  /// Get total minutes for a subject
  static int _calculateTotalMinutes(Subject subject, {ExamBody? examBody, int? year}) {
    Syllabus? targetSyllabus;
    
    if (examBody != null && year != null) {
      targetSyllabus = subject.syllabuses.firstWhere(
        (s) => s.examBody == examBody && s.year == year,
        orElse: () => subject.syllabuses.isNotEmpty ? subject.syllabuses.first : null!,
      );
    } else if (subject.syllabuses.isNotEmpty) {
      targetSyllabus = subject.syllabuses.first;
    }

    if (targetSyllabus == null || targetSyllabus.papers.isEmpty) {
      return 0;
    }

    int totalMinutes = 0;
    for (final paper in targetSyllabus.papers) {
      totalMinutes += _parseDurationToMinutes(paper.duration);
    }

    return totalMinutes;
  }

  /// Parse duration string to minutes
  static int _parseDurationToMinutes(String duration) {
    if (duration.isEmpty) return 0;

    duration = duration.toLowerCase().trim();
    duration = duration.replaceAll('½', '.5').replaceAll('¼', '.25').replaceAll('¾', '.75');

    int totalMinutes = 0;

    // Parse hours
    final hoursRegex = RegExp(r'(\d+\.?\d*)\s*(?:hour|hr|h)');
    final hoursMatch = hoursRegex.firstMatch(duration);
    if (hoursMatch != null) {
      final hours = double.parse(hoursMatch.group(1)!);
      totalMinutes += (hours * 60).round();
    }

    // Parse minutes (only if no hours to avoid double counting)
    final minutesRegex = RegExp(r'(\d+)\s*(?:minute|min|m)(?!.*hour)');
    final minutesMatch = minutesRegex.firstMatch(duration);
    if (minutesMatch != null && hoursMatch == null) {
      final minutes = int.parse(minutesMatch.group(1)!);
      totalMinutes += minutes;
    }

    // Combined format "2 hours 30 minutes"
    final combinedRegex = RegExp(r'(\d+)\s*(?:hour|hr|h).*?(\d+)\s*(?:minute|min|m)');
    final combinedMatch = combinedRegex.firstMatch(duration);
    if (combinedMatch != null) {
      final hours = int.parse(combinedMatch.group(1)!);
      final minutes = int.parse(combinedMatch.group(2)!);
      totalMinutes = (hours * 60) + minutes;
    }

    return totalMinutes;
  }

  static String _formatMinutesToHHMM(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}

// ============================================================================
// 2. TIME ESTIMATOR FROM QUESTIONS
// ============================================================================

class QuestionTimeEstimator {
  // Time allocation per question type (in seconds)
  static const Map<PaperType, int> timePerQuestion = {
    PaperType.objective: 100,    // 1.25 minutes per MCQ
    PaperType.essay: 1200,            // 20 minutes per essay question
    PaperType.practical: 2400,        // 40 minutes per practical task
    PaperType.oral: 180,              // 3 minutes per oral question
  };

  /// Calculate estimated time in minutes based on question count and paper type
  static int calculateEstimatedMinutes({
    required int numberOfQuestions,
    required PaperType paperType,
  }) {
    final secondsPerQuestion = timePerQuestion[paperType] ?? 60;
    final totalSeconds = numberOfQuestions * secondsPerQuestion;
    return (totalSeconds / 60).ceil();
  }

  /// Calculate estimated time in seconds
  static int calculateEstimatedSeconds({
    required int numberOfQuestions,
    required PaperType paperType,
  }) {
    final secondsPerQuestion = timePerQuestion[paperType] ?? 60;
    return numberOfQuestions * secondsPerQuestion;
  }

  /// Get formatted time "HH:MM" from question count
  static String calculateFormattedTime({
    required int numberOfQuestions,
    required PaperType paperType,
  }) {
    final totalMinutes = calculateEstimatedMinutes(
      numberOfQuestions: numberOfQuestions,
      paperType: paperType,
    );
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  /// Get formatted time "HH:MM:SS" from question count
  static String calculateFormattedTimeWithSeconds({
    required int numberOfQuestions,
    required PaperType paperType,
  }) {
    final totalSeconds = calculateEstimatedSeconds(
      numberOfQuestions: numberOfQuestions,
      paperType: paperType,
    );
    return _formatSecondsToHHMMSS(totalSeconds);
  }

  /// Get readable time string
  static String getReadableTime({
    required int numberOfQuestions,
    required PaperType paperType,
  }) {
    final totalMinutes = calculateEstimatedMinutes(
      numberOfQuestions: numberOfQuestions,
      paperType: paperType,
    );
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

  static String _formatSecondsToHHMMSS(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:'
           '${minutes.toString().padLeft(2, '0')}:'
           '${seconds.toString().padLeft(2, '0')}';
  }
}

// ============================================================================
// 3. EXAM TIMER (Countdown)
// ============================================================================
class ExamTimer {
  Timer? _timer;
  int _remainingSeconds;
  int _totalSeconds;
  bool _isRunning = false;
  
  final void Function(String formattedTime) onTick;
  final void Function()? onComplete;
  final void Function()? onPaused;
  final void Function()? onResumed;

  ExamTimer({
    required int durationMinutes,
    required this.onTick,
    this.onComplete,
    this.onPaused,
    this.onResumed,
  })  : _totalSeconds = durationMinutes * 60,
        _remainingSeconds = durationMinutes * 60;

  /// Start the timer
  void start() {
    if (_isRunning) return;
    
    _isRunning = true;
    onResumed?.call();
    
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        onTick(formattedTime);
      } else {
        stop();
        onComplete?.call();
      }
    });
    
    // Emit initial time immediately
    onTick(formattedTime);
  }

  /// Pause the timer
  void pause() {
    if (!_isRunning) return;
    
    _timer?.cancel();
    _isRunning = false;
    onPaused?.call();
  }

  /// Resume the timer
  void resume() {
    if (_isRunning) return;
    start();
  }

  /// Stop the timer completely
  void stop() {
    _timer?.cancel();
    _isRunning = false;
  }

  /// Reset timer to initial duration
  void reset() {
    stop();
    _remainingSeconds = _totalSeconds;
    onTick(formattedTime);
  }

  /// Add time (in minutes)
  void addTime(int minutes) {
    _remainingSeconds += minutes * 60;
    _totalSeconds += minutes * 60;
    onTick(formattedTime);
  }

  /// Set specific time remaining (in minutes)
  void setTime(int minutes) {
    _remainingSeconds = minutes * 60;
    onTick(formattedTime);
  }

  /// Get formatted time "HH:MM:SS"
  String get formattedTime {
    final hours = _remainingSeconds ~/ 3600;
    final minutes = (_remainingSeconds % 3600) ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:'
           '${minutes.toString().padLeft(2, '0')}:'
           '${seconds.toString().padLeft(2, '0')}';
  }

  /// Get formatted time "MM:SS" (for short durations)
  String get formattedTimeShort {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:'
           '${seconds.toString().padLeft(2, '0')}';
  }

  /// Get remaining time in seconds
  int get remainingSeconds => _remainingSeconds;

  /// Get remaining time in minutes
  int get remainingMinutes => (_remainingSeconds / 60).ceil();

  /// Get percentage completed (0.0 to 1.0)
  double get percentageCompleted {
    if (_totalSeconds == 0) return 0.0;
    return 1.0 - (_remainingSeconds / _totalSeconds);
  }

  /// Check if timer is running
  bool get isRunning => _isRunning;

  /// Check if time is up
  bool get isTimeUp => _remainingSeconds <= 0;

  /// Check if less than certain minutes remaining
  bool hasLessThan(int minutes) {
    return _remainingSeconds < (minutes * 60);
  }

  /// Dispose the timer
  void dispose() {
    _timer?.cancel();
  }
}

// ============================================================================
// 4. STOPWATCH TIMER (Count Up)
// ============================================================================
class ExamStopwatch {
  Timer? _timer;
  int _elapsedSeconds = 0;
  int? _maxSeconds;
  bool _isRunning = false;
  
  final void Function(String formattedTime) onTick;
  final void Function()? onMaxTimeReached;

  ExamStopwatch({
    required this.onTick,
    this.onMaxTimeReached,
    int? maxMinutes,
  }) : _maxSeconds = maxMinutes != null ? maxMinutes * 60 : null;

  /// Start the stopwatch
  void start() {
    if (_isRunning) return;
    
    _isRunning = true;
    
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsedSeconds++;
      onTick(formattedTime);
      
      // Check if max time reached
      if (_maxSeconds != null && _elapsedSeconds >= _maxSeconds!) {
        stop();
        onMaxTimeReached?.call();
      }
    });
    
    onTick(formattedTime);
  }

  /// Pause the stopwatch
  void pause() {
    if (!_isRunning) return;
    _timer?.cancel();
    _isRunning = false;
  }

  /// Resume the stopwatch
  void resume() {
    if (_isRunning) return;
    start();
  }

  /// Stop the stopwatch
  void stop() {
    _timer?.cancel();
    _isRunning = false;
  }

  /// Reset stopwatch to zero
  void reset() {
    stop();
    _elapsedSeconds = 0;
    onTick(formattedTime);
  }

  /// Get formatted time "HH:MM:SS"
  String get formattedTime {
    final hours = _elapsedSeconds ~/ 3600;
    final minutes = (_elapsedSeconds % 3600) ~/ 60;
    final seconds = _elapsedSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:'
           '${minutes.toString().padLeft(2, '0')}:'
           '${seconds.toString().padLeft(2, '0')}';
  }

  /// Get elapsed time in seconds
  int get elapsedSeconds => _elapsedSeconds;

  /// Get elapsed time in minutes
  int get elapsedMinutes => (_elapsedSeconds / 60).ceil();

  /// Check if running
  bool get isRunning => _isRunning;

  /// Dispose the timer
  void dispose() {
    _timer?.cancel();
  }
}

// ============================================================================
// USAGE EXAMPLES
// ============================================================================

void demonstrateUsage() {
  print('=== EXAM TIME HELPERS DEMO ===\n');

  // Example 1: Calculate subject time
  // final mathSubject = WaecSubjectsData._generalMathematics();
  // String time = SubjectTimeHelper.calculateSubjectTime(mathSubject);
  // print('Math Total Time: $time'); // "04:00"

  // Example 2: Estimate time from questions
  print('Question Time Estimates:');
  print('50 MCQs: ${QuestionTimeEstimator.calculateFormattedTime(
    numberOfQuestions: 50,
    paperType: PaperType.objective,
  )}'); // "01:03"
  
  print('6 Essay Questions: ${QuestionTimeEstimator.calculateFormattedTime(
    numberOfQuestions: 6,
    paperType: PaperType.essay,
  )}'); // "02:00"

  // Example 3: Countdown Timer
  print('\nCountdown Timer Example:');
  final examTimer = ExamTimer(
    durationMinutes: 90, // 1 hour 30 minutes
    onTick: (time) {
      print('Time Remaining: $time');
    },
    onComplete: () {
      print('Time is up!');
    },
  );
  
  examTimer.start();
  // Later...
  examTimer.pause();
  examTimer.resume();
  examTimer.stop();

  // Example 4: Stopwatch Timer
  print('\nStopwatch Example:');
  final stopwatch = ExamStopwatch(
    maxMinutes: 120, // Stop at 2 hours
    onTick: (time) {
      print('Time Elapsed: $time');
    },
    onMaxTimeReached: () {
      print('Maximum time reached!');
    },
  );
  
  stopwatch.start();
  // Later...
  stopwatch.pause();
  stopwatch.resume();
  stopwatch.stop();
}

// ============================================================================
// HELPER FUNCTIONS FOR QUICK ACCESS
// ============================================================================

/// Quick helper to get estimated time for exam
String getEstimatedExamTime(int questions, PaperType paperType) {
  return QuestionTimeEstimator.calculateFormattedTimeWithSeconds(
    numberOfQuestions: questions,
    paperType: paperType,
  );
}

/// Quick helper to create countdown timer
ExamTimer createCountdownTimer({
  required int minutes,
  required Function(String) onTick,
  Function()? onComplete,
}) {
  return ExamTimer(
    durationMinutes: minutes,
    onTick: onTick,
    onComplete: onComplete,
  );
}