/// Tracks exam progress in real-time
class ExamProgressEntity {
  final int totalQuestions;
  final int currentQuestionIndex;
  final int answeredCount;
  final int skippedCount;
  final int unansweredCount;
  final List<int> answeredQuestions;
  final List<int> reviewedQuestions;
  final List<int> skippedQuestions;
  final int timeElapsedMinutes;
  final DateTime? lastUpdated;

  ExamProgressEntity(
      {required this.totalQuestions,
      this.currentQuestionIndex = 0,
      this.answeredCount = 0,
      this.skippedCount = 0,
      this.unansweredCount = 0,
      this.answeredQuestions = const [],
      this.skippedQuestions = const [],
      this.reviewedQuestions = const [],
      this.timeElapsedMinutes = 0,
      this.lastUpdated});

  double get completionPercentage {
    return (answeredCount / totalQuestions) * 100;
  }
}
