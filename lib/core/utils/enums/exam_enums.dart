// ============================================================================
// ENUMS
// ============================================================================

enum ExamBody {
  waec,
  neco,
  jamb,
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

enum PaperType {
  multipleChoice,
  essay,
  practical,
  oral,
}



enum QuestionStatus {
  notAnswered,
  answered,
  review,
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
}
