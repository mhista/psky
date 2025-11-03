// ====================================================================
// EXAM CUBIT
// ====================================================================
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'exam_state.dart';

@injectable
class ExamCubit extends Cubit<ExamState> {
  final PageController pageController = PageController();

  ExamCubit()
      : super(ExamState(
          currentQuestionIndex: 0,
          totalQuestions: 2,
          answers: const {},
          reviewLater: const {},
          startTime: DateTime.now(),
        ));

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  /// Update current question index when page changes
  void updateQuestionIndex(int index) {
    if (index != state.currentQuestionIndex) {
      emit(state.copyWith(currentQuestionIndex: index));
    }
  }

  /// Jump to specific question
  void goToQuestion(int index) {
    emit(state.copyWith(currentQuestionIndex: index));
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Navigate to next question
  void nextQuestion() {
    final nextIndex = state.currentQuestionIndex + 1;
    if (nextIndex < state.totalQuestions) {
      emit(state.copyWith(currentQuestionIndex: nextIndex));
      pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  /// Navigate to previous question
  void previousQuestion() {
    final prevIndex = state.currentQuestionIndex - 1;
    if (prevIndex >= 0) {
      emit(state.copyWith(currentQuestionIndex: prevIndex));
      pageController.animateToPage(
        prevIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  /// Save answer for a question
  void saveAnswer(int questionIndex, String answer) {
    final updatedAnswers = Map<int, String>.from(state.answers);
    updatedAnswers[questionIndex] = answer;
    emit(state.copyWith(answers: updatedAnswers));
  }

  /// Toggle review later flag for a question
  void toggleReviewLater(int questionIndex) {
    final updatedReview = Set<int>.from(state.reviewLater);
    if (updatedReview.contains(questionIndex)) {
      updatedReview.remove(questionIndex);
    } else {
      updatedReview.add(questionIndex);
    }
    emit(state.copyWith(reviewLater: updatedReview));
  }

  /// Get status of a specific question
  QuestionStatus getQuestionStatus(int index) {
    if (state.reviewLater.contains(index)) return QuestionStatus.review;
    if (state.answers.containsKey(index)) return QuestionStatus.answered;
    return QuestionStatus.notAnswered;
  }

  /// Get exam statistics
  ExamStatistics getStatistics() {
    return ExamStatistics(
      totalQuestions: state.totalQuestions,
      answered: state.answers.length,
      notAnswered: state.totalQuestions - state.answers.length,
      markedForReview: state.reviewLater.length,
    );
  }

  /// Submit exam
  Future<void> submitExam(BuildContext context) async {
    emit(state.copyWith(isSubmitting: true));

    try {
      // Add your submission logic here
      // e.g., await examRepository.submitAnswers(state.answers);

      // Navigate to results screen
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (_) => const ExamResultsScreen()),
      // );
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to submit exam: $e',
      ));
    }
  }

  /// Save and exit exam
  Future<void> saveAndExit(BuildContext context) async {
    emit(state.copyWith(isSaving: true));

    try {
      // Add your save logic here
      // e.g., await examRepository.saveProgress(state.answers);

      // Navigate back
      Navigator.of(context).pop();
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: 'Failed to save progress: $e',
      ));
    }
  }

  /// Clear error message
  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
