// ============================================================================
// ENUMS WITH EXTENSIONS
// ============================================================================

enum ExamBody {
  waec,
  neco,
  jamb,
}

extension ExamBodyExtension on ExamBody {
  String get displayName {
    switch (this) {
      case ExamBody.waec:
        return 'WAEC';
      case ExamBody.neco:
        return 'NECO';
      case ExamBody.jamb:
        return 'JAMB';
    }
  }

  String get fullName {
    switch (this) {
      case ExamBody.waec:
        return 'West African Examinations Council';
      case ExamBody.neco:
        return 'National Examinations Council';
      case ExamBody.jamb:
        return 'Joint Admissions and Matriculation Board';
    }
  }

  static ExamBody? fromString(String value) {
    return ExamBody.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase() ||
             e.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => ExamBody.waec,
    );
  }
}

enum SubjectCategory {
  compulsory,
  science,
  arts,
  languages,
  commercial,
  technical,
  homeEconomics,
}

extension SubjectCategoryExtension on SubjectCategory {
  String get displayName {
    switch (this) {
      case SubjectCategory.compulsory:
        return 'Compulsory';
      case SubjectCategory.science:
        return 'Science';
      case SubjectCategory.arts:
        return 'Arts';
      case SubjectCategory.languages:
        return 'Languages';
      case SubjectCategory.commercial:
        return 'Commercial';
      case SubjectCategory.technical:
        return 'Technical';
      case SubjectCategory.homeEconomics:
        return 'Home Economics';
    }
  }

  String get icon {
    switch (this) {
      case SubjectCategory.compulsory:
        return '📚';
      case SubjectCategory.science:
        return '🔬';
      case SubjectCategory.arts:
        return '🎨';
      case SubjectCategory.languages:
        return '🗣️';
      case SubjectCategory.commercial:
        return '💼';
      case SubjectCategory.technical:
        return '🔧';
      case SubjectCategory.homeEconomics:
        return '🏠';
    }
  }

  static SubjectCategory? fromString(String value) {
    return SubjectCategory.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase() ||
             e.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => SubjectCategory.compulsory,
    );
  }
}

enum PaperType {
  objective,
  essay,
  practical,
  oral,
  all
}

extension PaperTypeExtension on PaperType {
  String get displayName {
    switch (this) {
      case PaperType.objective:
        return 'Multiple Choice';
      case PaperType.essay:
        return 'Essay';
      case PaperType.practical:
        return 'Practical';
      case PaperType.oral:
        return 'Oral';
        case PaperType.all:
        return 'All (Multichoice, Essay)';
    }
  }

  String get shortName {
    switch (this) {
      case PaperType.objective:
        return 'MC';
      case PaperType.essay:
        return 'Essay';
      case PaperType.practical:
        return 'Prac';
      case PaperType.oral:
        return 'Oral';
         case PaperType.all:
        return 'All';
    }
  }

  Duration get typicalDuration {
    switch (this) {
      case PaperType.objective:
        return const Duration(minutes: 90);
      case PaperType.essay:
        return const Duration(hours: 2);
      case PaperType.practical:
        return const Duration(hours: 3);
      case PaperType.oral:
        return const Duration(minutes: 30);
        case PaperType.all:
        return const Duration(hours:3, minutes: 30);
    }
  }

  static PaperType? fromString(String value) {
    return PaperType.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase() ||
             e.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => PaperType.objective,
    );
  }
}

enum QuestionStatus {
  notAnswered,
  answered,
  review,
}

extension QuestionStatusExtension on QuestionStatus {
  String get displayName {
    switch (this) {
      case QuestionStatus.notAnswered:
        return 'Not Answered';
      case QuestionStatus.answered:
        return 'Answered';
      case QuestionStatus.review:
        return 'Review';
    }
  }

  String get icon {
    switch (this) {
      case QuestionStatus.notAnswered:
        return '⚪';
      case QuestionStatus.answered:
        return '✅';
      case QuestionStatus.review:
        return '🔖';
    }
  }

  // Color codes for UI
  String get colorHex {
    switch (this) {
      case QuestionStatus.notAnswered:
        return '#9E9E9E';
      case QuestionStatus.answered:
        return '#4CAF50';
      case QuestionStatus.review:
        return '#FF9800';
    }
  }

  static QuestionStatus? fromString(String value) {
    return QuestionStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => QuestionStatus.notAnswered,
    );
  }
}

class ExamStatistics {
  final int totalQuestions;
  final int answered;
  final int notAnswered;
  final int markedForReview;

  ExamStatistics({
    required this.totalQuestions,
    required this.answered,
    required this.notAnswered,
    required this.markedForReview,
  });

  double get completionPercentage {
    if (totalQuestions == 0) return 0.0;
    return (answered / totalQuestions) * 100;
  }

  double get answeredPercentage {
    if (totalQuestions == 0) return 0.0;
    return (answered / totalQuestions) * 100;
  }

  bool get isComplete => answered == totalQuestions;

  int get remainingQuestions => totalQuestions - answered;

  @override
  String toString() {
    return 'ExamStatistics(total: $totalQuestions, answered: $answered, '
        'notAnswered: $notAnswered, review: $markedForReview, '
        'completion: ${completionPercentage.toStringAsFixed(1)}%)';
  }
}

enum QuestionType {
  objective,
  essay,
  practical,
  oral,
}

extension QuestionTypeExtension on QuestionType {
  String get displayName {
    switch (this) {
      case QuestionType.objective:
        return 'Objective';
      case QuestionType.essay:
        return 'Essay';
      case QuestionType.practical:
        return 'Practical';
      case QuestionType.oral:
        return 'Oral';
    }
  }

  PaperType get correspondingPaperType {
    switch (this) {
      case QuestionType.objective:
        return PaperType.objective;
      case QuestionType.essay:
        return PaperType.essay;
      case QuestionType.practical:
        return PaperType.practical;
      case QuestionType.oral:
        return PaperType.oral;
    }
  }

  bool get isAutoGradable {
    return this == QuestionType.objective;
  }

  static QuestionType fromString(String value) {
    return QuestionType.values.firstWhere(  
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => QuestionType.objective,
    );
  }
}

enum DifficultyLevel {
  easy,
  medium,
  hard,
}

extension DifficultyLevelExtension on DifficultyLevel {
  String get displayName {
    switch (this) {
      case DifficultyLevel.easy:
        return 'Easy';
      case DifficultyLevel.medium:
        return 'Medium';
      case DifficultyLevel.hard:
        return 'Hard';
    }
  }

  String get icon {
    switch (this) {
      case DifficultyLevel.easy:
        return '⭐';
      case DifficultyLevel.medium:
        return '⭐⭐';
      case DifficultyLevel.hard:
        return '⭐⭐⭐';
    }
  }

  int get points {
    switch (this) {
      case DifficultyLevel.easy:
        return 1;
      case DifficultyLevel.medium:
        return 2;
      case DifficultyLevel.hard:
        return 3;
    }
  }

  String get colorHex {
    switch (this) {
      case DifficultyLevel.easy:
        return '#4CAF50';
      case DifficultyLevel.medium:
        return '#FF9800';
      case DifficultyLevel.hard:
        return '#F44336';
    }
  }

  static DifficultyLevel? fromString(String value) {
    return DifficultyLevel.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => DifficultyLevel.medium,
    );
  }
}

enum ExamSessionStatus {
  inProgress,
  paused,
  completed,
  abandoned,
}

extension ExamSessionStatusExtension on ExamSessionStatus {
  String get displayName {
    switch (this) {
      case ExamSessionStatus.inProgress:
        return 'In Progress';
      case ExamSessionStatus.paused:
        return 'Paused';
      case ExamSessionStatus.completed:
        return 'Completed';
      case ExamSessionStatus.abandoned:
        return 'Abandoned';
    }
  }

  String get icon {
    switch (this) {
      case ExamSessionStatus.inProgress:
        return '▶️';
      case ExamSessionStatus.paused:
        return '⏸️';
      case ExamSessionStatus.completed:
        return '✅';
      case ExamSessionStatus.abandoned:
        return '❌';
    }
  }

  bool get isActive => this == ExamSessionStatus.inProgress;
  
  bool get canResume => 
      this == ExamSessionStatus.paused || this == ExamSessionStatus.inProgress;
  
  bool get isFinal => 
      this == ExamSessionStatus.completed || this == ExamSessionStatus.abandoned;

  static ExamSessionStatus? fromString(String value) {
    return ExamSessionStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ExamSessionStatus.inProgress,
    );
  }
}

enum PerformanceLevel {
  excellent,
  good,
  fair,
  poor,
}

extension PerformanceLevelExtension on PerformanceLevel {
  String get displayName {
    switch (this) {
      case PerformanceLevel.excellent:
        return 'Excellent';
      case PerformanceLevel.good:
        return 'Good';
      case PerformanceLevel.fair:
        return 'Fair';
      case PerformanceLevel.poor:
        return 'Poor';
    }
  }

  String get icon {
    switch (this) {
      case PerformanceLevel.excellent:
        return '🏆';
      case PerformanceLevel.good:
        return '👍';
      case PerformanceLevel.fair:
        return '👌';
      case PerformanceLevel.poor:
        return '📉';
    }
  }

  String get colorHex {
    switch (this) {
      case PerformanceLevel.excellent:
        return '#4CAF50';
      case PerformanceLevel.good:
        return '#8BC34A';
      case PerformanceLevel.fair:
        return '#FF9800';
      case PerformanceLevel.poor:
        return '#F44336';
    }
  }

  int get minPercentage {
    switch (this) {
      case PerformanceLevel.excellent:
        return 80;
      case PerformanceLevel.good:
        return 60;
      case PerformanceLevel.fair:
        return 40;
      case PerformanceLevel.poor:
        return 0;
    }
  }

  static PerformanceLevel fromPercentage(double percentage) {
    if (percentage >= 80) return PerformanceLevel.excellent;
    if (percentage >= 60) return PerformanceLevel.good;
    if (percentage >= 40) return PerformanceLevel.fair;
    return PerformanceLevel.poor;
  }

  static PerformanceLevel? fromString(String value) {
    return PerformanceLevel.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => PerformanceLevel.fair,
    );
  }
}

enum PerformanceTrend {
  improving,
  stable,
  declining,
}

extension PerformanceTrendExtension on PerformanceTrend {
  String get displayName {
    switch (this) {
      case PerformanceTrend.improving:
        return 'Improving';
      case PerformanceTrend.stable:
        return 'Stable';
      case PerformanceTrend.declining:
        return 'Declining';
    }
  }

  String get icon {
    switch (this) {
      case PerformanceTrend.improving:
        return '📈';
      case PerformanceTrend.stable:
        return '➡️';
      case PerformanceTrend.declining:
        return '📉';
    }
  }

  String get colorHex {
    switch (this) {
      case PerformanceTrend.improving:
        return '#4CAF50';
      case PerformanceTrend.stable:
        return '#2196F3';
      case PerformanceTrend.declining:
        return '#F44336';
    }
  }

  String get message {
    switch (this) {
      case PerformanceTrend.improving:
        return 'Keep up the great work!';
      case PerformanceTrend.stable:
        return 'Maintain your consistency';
      case PerformanceTrend.declining:
        return 'Focus on improvement areas';
    }
  }

  static PerformanceTrend fromScores(List<double> scores) {
    if (scores.length < 2) return PerformanceTrend.stable;
    
    final recent = scores.take(scores.length ~/ 2).toList();
    final older = scores.skip(scores.length ~/ 2).toList();
    
    final recentAvg = recent.reduce((a, b) => a + b) / recent.length;
    final olderAvg = older.reduce((a, b) => a + b) / older.length;
    
    final difference = recentAvg - olderAvg;
    
    if (difference > 5) return PerformanceTrend.improving;
    if (difference < -5) return PerformanceTrend.declining;
    return PerformanceTrend.stable;
  }

  static PerformanceTrend? fromString(String value) {
    return PerformanceTrend.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => PerformanceTrend.stable,
    );
  }
}



enum ExamMode {
  fullMock,
  singleSubject,
  quickDrill,
  custom,
}

extension ExamModeExtension on ExamMode {
  String get displayName {
    switch (this) {
      case ExamMode.fullMock:
        return 'Full Mock Exam';
      case ExamMode.singleSubject:
        return 'Single Subject Exam';
      case ExamMode.quickDrill:
        return 'Quick Drill';
      case ExamMode.custom:
        return 'Custom Exam';
    }
  }

  String get description {
    switch (this) {
      case ExamMode.fullMock:
        return 'Complete exam simulation with multiple subjects';
      case ExamMode.singleSubject:
        return 'Focus on one subject at a time';
      case ExamMode.quickDrill:
        return 'Quick practice with limited questions';
      case ExamMode.custom:
        return 'Create your own exam configuration';
    }
  }

  String get icon {
    switch (this) {
      case ExamMode.fullMock:
        return '📝';
      case ExamMode.singleSubject:
        return '📖';
      case ExamMode.quickDrill:
        return '⚡';
      case ExamMode.custom:
        return '⚙️';
    }
  }

  Duration get suggestedDuration {
    switch (this) {
      case ExamMode.fullMock:
        return const Duration(hours: 3);
      case ExamMode.singleSubject:
        return const Duration(minutes: 90);
      case ExamMode.quickDrill:
        return const Duration(minutes: 15);
      case ExamMode.custom:
        return const Duration(minutes: 60); // Default
    }
  }

  int get suggestedQuestionCount {
    switch (this) {
      case ExamMode.fullMock:
        return 180; // Multiple subjects
      case ExamMode.singleSubject:
        return 50;
      case ExamMode.quickDrill:
        return 10;
      case ExamMode.custom:
        return 30; // Default
    }
  }

  bool get isTimedByDefault {
    switch (this) {
      case ExamMode.fullMock:
        return true;
      case ExamMode.singleSubject:
        return true;
      case ExamMode.quickDrill:
        return false;
      case ExamMode.custom:
        return false; // User decides
    }
  }

  bool get allowsMultipleSubjects {
    return this == ExamMode.fullMock || this == ExamMode.custom;
  }

  // ============================================================================
  // STATIC HELPER METHODS
  // ============================================================================

  /// Get a list of all display names
  static List<String> get allDisplayNames {
    return ExamMode.values.map((mode) => mode.displayName).toList();
  }

  /// Get a list of all exam modes with their display names (for dropdowns)
  static List<Map<String, dynamic>> get allModesWithDetails {
    return ExamMode.values.map((mode) => {
      'value': mode,
      'displayName': mode.displayName,
      'description': mode.description,
      'icon': mode.icon,
    }).toList();
  }

  /// Convert from display name to enum value
  static ExamMode? fromDisplayName(String displayName) {
    try {
      return ExamMode.values.firstWhere(
        (mode) => mode.displayName.toLowerCase() == displayName.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Convert from any string (enum name or display name) to enum value
  static ExamMode? fromString(String value) {
    try {
      return ExamMode.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toLowerCase() ||
               e.displayName.toLowerCase() == value.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Get enum value from index
  static ExamMode? fromIndex(int index) {
    if (index < 0 || index >= ExamMode.values.length) return null;
    return ExamMode.values[index];
  }
}



// ============================================================================
// ENUMS
// ============================================================================

enum LeaderboardType {
  overall,
  subject,
  weekly,
  monthly,
}

enum OperationType {
  saveSession,
  deleteSession,
  updateLeaderboard,
}

/// Sort options for leaderboard
enum LeaderboardSortBy {
  score,
  lastUpdated,
  displayName,
}