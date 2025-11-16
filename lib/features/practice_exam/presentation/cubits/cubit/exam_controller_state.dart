
// ====================================================================
// EXAM STATE
// ====================================================================
part of 'exam_controller_cubit.dart';

class ExamPageState extends Equatable {
  final int currentQuestionIndex;
  final int totalQuestions;
  final Map<int, String> answers;
  final Set<int> reviewLater;
  final DateTime startTime;
  final bool isSubmitting;
  final bool isSaving;
  final String? errorMessage;

  const ExamPageState({
    required this.currentQuestionIndex,
    required this.totalQuestions,
    required this.answers,
    required this.reviewLater,
    required this.startTime,
    this.isSubmitting = false,
    this.isSaving = false,
    this.errorMessage,
  });

  ExamPageState copyWith({
    int? currentQuestionIndex,
    int? totalQuestions,
    Map<int, String>? answers,
    Set<int>? reviewLater,
    DateTime? startTime,
    bool? isSubmitting,
    bool? isSaving,
    String? errorMessage,
  }) {
    return ExamPageState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      answers: answers ?? this.answers,
      reviewLater: reviewLater ?? this.reviewLater,
      startTime: startTime ?? this.startTime,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        currentQuestionIndex,
        totalQuestions,
        answers,
        reviewLater,
        startTime,
        isSubmitting,
        isSaving,
        errorMessage,
      ];
}

