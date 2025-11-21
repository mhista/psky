import 'dart:async';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/services/exam_result_calculator.dart';
import 'package:ahiaa_web/core/utils/constants/text_strings.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/exam_question.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/exam_progress.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'exam_session_state.dart';
part 'exam_session_cubit.freezed.dart';

@lazySingleton
class ExamSessionCubit extends Cubit<ExamSessionState> {
  final ExamCubit _examCubit;

  Timer? _timer;
  StreamSubscription? _examCubitSubscription;

  ExamSessionCubit(this._examCubit) : super(const ExamSessionState.initial()) {
    _listenToExamCubit();
  }

  // ============================================================================
  // INITIALIZATION
  // ============================================================================

  /// Listen to ExamCubit for current session updates
  void _listenToExamCubit() {
    _examCubitSubscription = _examCubit.stream.listen((examState) {
      examState.maybeWhen(
        hasData: (mode, selectedSubjects, sessions, currentSession) {
          // Only update if we don't have a session or if it's a different session
          final currentState = state;
          if (currentState is! _Active ||
              currentState.session.examSessionId !=
                  currentSession.examSessionId) {
            _initializeSession(currentSession);
          }
        },
        completed: (sessions, completedSession) {
          _handleSessionCompletion(completedSession);
        },
        orElse: () {},
      );
    });
  }

  void _initializeSession(ExamSession session) {
    // if (session.status == ExamSessionStatus.inProgress) {
    //   // startTimer();
    // }
    if (session.status == ExamSessionStatus.completed) {
      ExamSessionState.completed(session: session, currentQuestionIndex: 0);
    }

    final hasReachedLimit = session.questions.length >= PTexts.examTotalCounts;

    emit(ExamSessionState.active(
      session: session,
      currentQuestionIndex: session.progress?.currentQuestionIndex ?? 0,
      timeRemainingSeconds: _calculateTimeRemaining(session),
      hasReachedQuestionLimit: hasReachedLimit,
    ));
  }

  // ============================================================================
  // NAVIGATION
  // ============================================================================

  /// Navigate to next question
  Future<void> nextQuestion() async {
    final currentState = state;
    if (currentState is! _Active) return;

    final nextIndex = currentState.currentQuestionIndex + 1;
    if (nextIndex >= currentState.session.questions.length) return;

    await _updateCurrentQuestionIndex(nextIndex);
  }

  /// Navigate to next question for completed session
  Future<void> nextAnsweredQuestion() async {
    final currentState = state;
    if (currentState is! _Completed) return;

    final nextIndex = currentState.currentQuestionIndex + 1;
    if (nextIndex >= currentState.session.questions.length) return;

    await updateCompletedCurrentQuestionIndex(nextIndex);
  }

  /// Navigate to previous question for completed session
  Future<void> previousAnswereedQuestion() async {
    final currentState = state;
    if (currentState is! _Completed) return;

    final prevIndex = currentState.currentQuestionIndex - 1;
    if (prevIndex < 0) return;

    await updateCompletedCurrentQuestionIndex(prevIndex);
  }

  /// Navigate to previous question
  Future<void> previousQuestion() async {
    final currentState = state;
    if (currentState is! _Active) return;

    final prevIndex = currentState.currentQuestionIndex - 1;
    if (prevIndex < 0) return;

    await _updateCurrentQuestionIndex(prevIndex);
  }

  /// Jump to specific question
  Future<void> goToQuestion(int index) async {
    final currentState = state;
    if (currentState is! _Active) return;

    if (index < 0 || index >= currentState.session.questions.length) return;

    await _updateCurrentQuestionIndex(index);
  }

  Future<void> updateCompletedCurrentQuestionIndex(int index) async {
    final currentState = state;
    if (currentState is! _Completed) return;

    emit(ExamSessionState.completed(
      session: currentState.session,
      currentQuestionIndex: index,
    ));
  }

  Future<void> _updateCurrentQuestionIndex(int index) async {
    final currentState = state;
    if (currentState is! _Active) return;

    final updatedProgress = currentState.session.progress!.copyWith(
        currentQuestionIndex: index,
        timeElapsedMinutes: currentState.session.timeLimitMinutes -
            (currentState.timeRemainingSeconds ~/ 60));

    final updatedSession = _updateSessionProgress(
      currentState.session,
      updatedProgress,
    );

    emit(ExamSessionState.active(
      session: updatedSession,
      currentQuestionIndex: index,
      timeRemainingSeconds: currentState.timeRemainingSeconds,
      hasReachedQuestionLimit:
          currentState.hasReachedQuestionLimit, // Preserve flag
    ));

    await _syncWithExamCubit(updatedSession);
  }

  // ============================================================================
  // ANSWER MANAGEMENT
  // ============================================================================

  /// Submit answer for current question
  Future<void> submitAnswer(String answer) async {
    final currentState = state;
    if (currentState is! _Active) return;

    final currentQuestion =
        currentState.session.questions[currentState.currentQuestionIndex];

    // Update question with answer
    final updatedQuestions =
        List<ExamQuestion>.from(currentState.session.questions);
    updatedQuestions[currentState.currentQuestionIndex] = ExamQuestion(
      questionId: currentQuestion.questionId,
      questionNumber: currentQuestion.questionNumber,
      questionText: currentQuestion.questionText,
      questionType: currentQuestion.questionType,
      subjectId: currentQuestion.subjectId,
      topicId: currentQuestion.topicId,
      examBody: currentQuestion.examBody,
      difficultyLevel: currentQuestion.difficultyLevel,
      marks: currentQuestion.marks,
      timeEstimateMinutes: currentQuestion.timeEstimateMinutes,
      options: currentQuestion.options,
      correctAnswer: currentQuestion.correctAnswer,
      answerText: currentQuestion.answerText,
      selectedAnswer: answer,
      markingScheme: currentQuestion.markingScheme,
      explanation: currentQuestion.explanation,
      commonMistakes: currentQuestion.commonMistakes,
      syllabusReference: currentQuestion.syllabusReference,
      requiresDiagram: currentQuestion.requiresDiagram,
      diagramDescription: currentQuestion.diagramDescription,
      diagramUrl: currentQuestion.diagramUrl,
      pastYearReference: currentQuestion.pastYearReference,
      createdAt: currentQuestion.createdAt,
      createdBy: currentQuestion.createdBy,
    );

    // Update progress
    final answeredQuestions =
        List<int>.from(currentState.session.progress!.answeredQuestions);
    if (!answeredQuestions.contains(currentState.currentQuestionIndex)) {
      answeredQuestions.add(currentState.currentQuestionIndex);
    }

    // Remove from skipped if it was there
    final skippedQuestions =
        List<int>.from(currentState.session.progress!.skippedQuestions)
          ..remove(currentState.currentQuestionIndex);

    // Remove from review if there
    final reviewedAnsweres =
        List<int>.from(currentState.session.progress!.reviewedQuestions)
          ..remove(currentState.currentQuestionIndex);

    final updatedProgress = currentState.session.progress!.copyWith(
        answeredCount: answeredQuestions.length,
        answeredQuestions: answeredQuestions,
        skippedQuestions: skippedQuestions,
        reviewedQuestions: reviewedAnsweres,
        skippedCount: skippedQuestions.length,
        timeElapsedMinutes: currentState.session.timeLimitMinutes -
            (currentState.timeRemainingSeconds ~/ 60));

    final updatedSession = currentState.session.copyWith(
      questions: updatedQuestions,
      progress: updatedProgress,
    );

    emit(ExamSessionState.active(
      session: updatedSession,
      currentQuestionIndex: currentState.currentQuestionIndex,
      timeRemainingSeconds: currentState.timeRemainingSeconds,
      hasReachedQuestionLimit:
          currentState.hasReachedQuestionLimit, // Preserve flag
    ));

    await _syncWithExamCubit(updatedSession);
  }

  /// Skip current question
  Future<void> skipQuestion() async {
    final currentState = state;
    if (currentState is! _Active) return;

    final skippedQuestions =
        List<int>.from(currentState.session.progress!.skippedQuestions);
    if (!skippedQuestions.contains(currentState.currentQuestionIndex)) {
      skippedQuestions.add(currentState.currentQuestionIndex);
    }
    // Remove from review if there
    final reviewedAnsweres =
        List<int>.from(currentState.session.progress!.reviewedQuestions)
          ..remove(currentState.currentQuestionIndex);

    final updatedProgress = currentState.session.progress!.copyWith(
        skippedQuestions: skippedQuestions,
        skippedCount: skippedQuestions.length,
        reviewedQuestions: reviewedAnsweres,
        timeElapsedMinutes: currentState.session.timeLimitMinutes -
            (currentState.timeRemainingSeconds ~/ 60));

    final updatedSession = _updateSessionProgress(
      currentState.session,
      updatedProgress,
    );

    emit(ExamSessionState.active(
      session: updatedSession,
      currentQuestionIndex: currentState.currentQuestionIndex,
      timeRemainingSeconds: currentState.timeRemainingSeconds,
      hasReachedQuestionLimit:
          currentState.hasReachedQuestionLimit, // Preserve flag
    ));

    await _syncWithExamCubit(updatedSession);

    // Auto-navigate to next question
    await nextQuestion();
  }

  /// Mark question for review
  Future<void> markForReview() async {
    final currentState = state;
    if (currentState is! _Active) return;

    final reviewQuestions =
        List<int>.from(currentState.session.progress!.reviewedQuestions);
    if (!reviewQuestions.contains(currentState.currentQuestionIndex)) {
      reviewQuestions.add(currentState.currentQuestionIndex);
    }

    // Remove from skipped if there
    final skippedQuestions =
        List<int>.from(currentState.session.progress!.skippedQuestions)
          ..remove(currentState.currentQuestionIndex);

    final updatedProgress = currentState.session.progress!.copyWith(
        reviewedQuestions: reviewQuestions,
        skippedQuestions: skippedQuestions,
        skippedCount: skippedQuestions.length,
        timeElapsedMinutes: currentState.session.timeLimitMinutes -
            (currentState.timeRemainingSeconds ~/ 60));

    final updatedSession = _updateSessionProgress(
      currentState.session,
      updatedProgress,
    );

    emit(ExamSessionState.active(
      session: updatedSession,
      currentQuestionIndex: currentState.currentQuestionIndex,
      timeRemainingSeconds: currentState.timeRemainingSeconds,
      hasReachedQuestionLimit:
          currentState.hasReachedQuestionLimit, // Preserve flag
    ));

    await _syncWithExamCubit(updatedSession);

    // Auto-navigate to next question
    await nextQuestion();
  }

  /// Clear answer for current question
  Future<void> clearAnswer() async {
    final currentState = state;
    if (currentState is! _Active) return;

    final currentQuestion =
        currentState.session.questions[currentState.currentQuestionIndex];

    final updatedQuestions =
        List<ExamQuestion>.from(currentState.session.questions);
    updatedQuestions[currentState.currentQuestionIndex] = ExamQuestion(
      questionId: currentQuestion.questionId,
      questionNumber: currentQuestion.questionNumber,
      questionText: currentQuestion.questionText,
      questionType: currentQuestion.questionType,
      subjectId: currentQuestion.subjectId,
      topicId: currentQuestion.topicId,
      examBody: currentQuestion.examBody,
      difficultyLevel: currentQuestion.difficultyLevel,
      marks: currentQuestion.marks,
      timeEstimateMinutes: currentQuestion.timeEstimateMinutes,
      options: currentQuestion.options,
      correctAnswer: currentQuestion.correctAnswer,
      answerText: null, // Clear the answer
      markingScheme: currentQuestion.markingScheme,
      explanation: currentQuestion.explanation,
      commonMistakes: currentQuestion.commonMistakes,
      syllabusReference: currentQuestion.syllabusReference,
      requiresDiagram: currentQuestion.requiresDiagram,
      diagramDescription: currentQuestion.diagramDescription,
      diagramUrl: currentQuestion.diagramUrl,
      pastYearReference: currentQuestion.pastYearReference,
      createdAt: currentQuestion.createdAt,
      createdBy: currentQuestion.createdBy,
    );

    // Update progress - remove from answered
    final answeredQuestions =
        List<int>.from(currentState.session.progress!.answeredQuestions)
          ..remove(currentState.currentQuestionIndex);

    final updatedProgress = currentState.session.progress!.copyWith(
        answeredCount: answeredQuestions.length,
        answeredQuestions: answeredQuestions,
        timeElapsedMinutes: currentState.session.timeLimitMinutes -
            (currentState.timeRemainingSeconds ~/ 60));

    final updatedSession = ExamSession(
      examSessionId: currentState.session.examSessionId,
      userId: currentState.session.userId,
      subjectId: currentState.session.subjectId,
      examBody: currentState.session.examBody,
      paperType: currentState.session.paperType,
      questions: updatedQuestions,
      totalMarks: currentState.session.totalMarks,
      timeLimitMinutes: currentState.session.timeLimitMinutes,
      startedAt: currentState.session.startedAt,
      completedAt: currentState.session.completedAt,
      status: currentState.session.status,
      progress: updatedProgress,
    );

    emit(ExamSessionState.active(
      session: updatedSession,
      currentQuestionIndex: currentState.currentQuestionIndex,
      timeRemainingSeconds: currentState.timeRemainingSeconds,
      hasReachedQuestionLimit:
          currentState.hasReachedQuestionLimit, // Preserve flag
    ));

    await _syncWithExamCubit(updatedSession);
  }

  /// Append new questions to the current exam session (max PTexts.examTotalCounts questions)
  Future<void> appendQuestions(List<ExamQuestion> newQuestions) async {
    final currentState = state;
    if (currentState is! _Active && currentState is! _Paused) return;

    final session = currentState is _Active
        ? currentState.session
        : (currentState as _Paused).session;

    final currentLength = session.questions.length;

    // Check if we've already reached the limit
    if (currentLength >= PTexts.examTotalCounts) {
      pskyLog(
          'Question limit of PTexts.examTotalCounts already reached. Cannot append more questions.');
      return;
    }

    // Calculate how many questions we can add without exceeding PTexts.examTotalCounts
    final questionsNeeded = PTexts.examTotalCounts - currentLength;
    final questionsToAdd = newQuestions.length > questionsNeeded
        ? newQuestions.take(questionsNeeded).toList()
        : newQuestions;

    // Merge existing questions with new ones (capped at PTexts.examTotalCounts total)
    final updatedQuestions = [
      ...session.questions,
      ...questionsToAdd,
    ];

    final updatedSession = session.copyWith(
      questions: updatedQuestions,
    );

    final hasReachedLimit = updatedQuestions.length >= PTexts.examTotalCounts;

    pskyLog('Updated questions length: ${updatedSession.questions.length}');
    if (hasReachedLimit) {
      pskyLog(
          '✓ Reached question limit of PTexts.examTotalCounts. No more questions will be added.');
    }

    if (currentState is _Active) {
      emit(ExamSessionState.active(
        session: updatedSession,
        currentQuestionIndex: currentState.currentQuestionIndex,
        timeRemainingSeconds: currentState.timeRemainingSeconds,
        hasReachedQuestionLimit: hasReachedLimit,
      ));
    } else if (currentState is _Paused) {
      emit(ExamSessionState.paused(
        session: updatedSession,
        currentQuestionIndex: currentState.currentQuestionIndex,
        timeRemainingSeconds: currentState.timeRemainingSeconds,
        hasReachedQuestionLimit: hasReachedLimit,
      ));
    }

    await _syncWithExamCubit(updatedSession);
  }

  // ============================================================================
  // SESSION CONTROL
  // ============================================================================

  /// Pause the exam session
  Future<void> pauseSession() async {
    final currentState = state;
    if (currentState is! _Active) return;

    _timer?.cancel();

    final updatedSession = ExamSession(
      examSessionId: currentState.session.examSessionId,
      userId: currentState.session.userId,
      subjectId: currentState.session.subjectId,
      examBody: currentState.session.examBody,
      paperType: currentState.session.paperType,
      questions: currentState.session.questions,
      totalMarks: currentState.session.totalMarks,
      timeLimitMinutes: currentState.session.timeLimitMinutes,
      startedAt: currentState.session.startedAt,
      completedAt: currentState.session.completedAt,
      status: ExamSessionStatus.paused,
      progress: currentState.session.progress,
    );

    emit(ExamSessionState.paused(
      session: updatedSession,
      currentQuestionIndex: currentState.currentQuestionIndex,
      timeRemainingSeconds: currentState.timeRemainingSeconds,
      hasReachedQuestionLimit:
          currentState.hasReachedQuestionLimit, // Preserve flag
    ));

    await _examCubit.pauseAndSave();
  }

  /// Resume the exam session
  Future<void> resumeSession() async {
    final currentState = state;
    if (currentState is! _Paused) return;

    final updatedSession = ExamSession(
      examSessionId: currentState.session.examSessionId,
      userId: currentState.session.userId,
      subjectId: currentState.session.subjectId,
      examBody: currentState.session.examBody,
      paperType: currentState.session.paperType,
      questions: currentState.session.questions,
      totalMarks: currentState.session.totalMarks,
      timeLimitMinutes: currentState.session.timeLimitMinutes,
      startedAt: currentState.session.startedAt,
      completedAt: currentState.session.completedAt,
      status: ExamSessionStatus.inProgress,
      progress: currentState.session.progress,
    );

    emit(ExamSessionState.active(
      session: updatedSession,
      currentQuestionIndex: currentState.currentQuestionIndex,
      timeRemainingSeconds: currentState.timeRemainingSeconds,
      hasReachedQuestionLimit:
          currentState.hasReachedQuestionLimit, // Preserve flag
    ));

    startTimer();
    await _syncWithExamCubit(updatedSession);
  }

  /// Submit and complete the exam
  Future<void> submitExam() async {
    final currentState = state;
    if (currentState is! _Active && currentState is! _Paused) return;

    _timer?.cancel();

    final session = currentState is _Active
        ? currentState.session
        : (currentState as _Paused).session;

    final completedSession = ExamSession(
      examSessionId: session.examSessionId,
      userId: session.userId,
      subjectId: session.subjectId,
      examBody: session.examBody,
      paperType: session.paperType,
      questions: session.questions,
      totalMarks: session.totalMarks,
      timeLimitMinutes: session.timeLimitMinutes,
      startedAt: session.startedAt,
      completedAt: DateTime.now(),
      status: ExamSessionStatus.completed,
      progress: session.progress,
    );
    await _examCubit.endAndSave();

    emit(ExamSessionState.completed(
        session: completedSession, currentQuestionIndex: 0));
  }

  /// Abandon the exam
  Future<void> abandonExam() async {
    final currentState = state;
    if (currentState is! _Active && currentState is! _Paused) return;

    _timer?.cancel();

    final session = currentState is _Active
        ? currentState.session
        : (currentState as _Paused).session;

    final abandonedSession = ExamSession(
      examSessionId: session.examSessionId,
      userId: session.userId,
      subjectId: session.subjectId,
      examBody: session.examBody,
      paperType: session.paperType,
      questions: session.questions,
      totalMarks: session.totalMarks,
      timeLimitMinutes: session.timeLimitMinutes,
      startedAt: session.startedAt,
      completedAt: DateTime.now(),
      status: ExamSessionStatus.abandoned,
      progress: session.progress,
    );

    emit(ExamSessionState.abandoned(session: abandonedSession));
    await _syncWithExamCubit(abandonedSession);
  }

  void clear() {
    emit(const ExamSessionState.initial());
  }
  // ============================================================================
  // TIMER MANAGEMENT
  // ============================================================================

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentState = state;
      if (currentState is _Active) {
        final newTimeRemaining = currentState.timeRemainingSeconds - 1;

        if (newTimeRemaining <= 0) {
          // Time's up - auto submit
          timer.cancel();
          submitExam();
          calculateSessionResult();
          _examCubit.calculateAggregateResults();
          // No more subjects, actually submit the exam
          getIt<AppRouter>().router.goNamed(KRoutes.result);
          return;
        }

        // Update time elapsed in progress every minute
        if (newTimeRemaining % 60 == 0) {
          final elapsedMinutes =
              (currentState.session.timeLimitMinutes * 60 - newTimeRemaining) ~/
                  60;
          final updatedProgress = currentState.session.progress!.copyWith(
            timeElapsedMinutes: elapsedMinutes,
          );

          final updatedSession = _updateSessionProgress(
            currentState.session,
            updatedProgress,
          );

          _syncWithExamCubit(updatedSession);
        }

        emit(ExamSessionState.active(
          session: currentState.session,
          currentQuestionIndex: currentState.currentQuestionIndex,
          timeRemainingSeconds: newTimeRemaining,
          hasReachedQuestionLimit:
              currentState.hasReachedQuestionLimit, // Preserve flag
        ));
      }
    });
  }

  int _calculateTimeRemaining(ExamSession session) {
    if (session.completedAt != null) return 0;

    final elapsedMinutes = session.progress?.timeElapsedMinutes ?? 0;
    final remainingMinutes = session.timeLimitMinutes - elapsedMinutes;
    return remainingMinutes * 60; // Convert to seconds
  }

  // ============================================================================
  // STATISTICS & HELPERS
  // ============================================================================

  /// Check if the session has reached the PTexts.examTotalCounts question limit
  bool hasReachedQuestionLimit() {
    final currentState = state;
    return currentState.maybeWhen(
      active: (_, __, ___, hasReachedLimit) => hasReachedLimit,
      paused: (_, __, ___, hasReachedLimit) => hasReachedLimit,
      orElse: () => false,
    );
  }

  /// Get current number of questions
  int getCurrentQuestionCount() {
    final currentState = state;
    return currentState.maybeWhen(
      active: (session, _, __, ___) => session.questions.length,
      paused: (session, _, __, ___) => session.questions.length,
      orElse: () => 0,
    );
  }

  /// Get current exam statistics
  ExamStatistics getStatistics() {
    final currentState = state;
    if (currentState is! _Active && currentState is! _Paused) {
      return ExamStatistics(
        totalQuestions: 0,
        answered: 0,
        notAnswered: 0,
        markedForReview: 0,
      );
    }

    final session = currentState is _Active
        ? currentState.session
        : (currentState as _Paused).session;

    final progress = session.progress!;

    return ExamStatistics(
      totalQuestions: progress.totalQuestions,
      answered: progress.answeredCount,
      notAnswered: progress.totalQuestions -
          progress.answeredCount -
          progress.skippedCount,
      markedForReview: progress.skippedCount,
    );
  }

  /// Get current question
  ExamQuestion? getCurrentQuestion() {
    final currentState = state;
    if (currentState is! _Active && currentState is! _Paused) return null;

    final session = currentState is _Active
        ? currentState.session
        : (currentState as _Paused).session;

    final index = currentState is _Active
        ? currentState.currentQuestionIndex
        : (currentState as _Paused).currentQuestionIndex;

    if (index < 0 || index >= session.questions.length) return null;

    return session.questions[index];
  }

  /// Check if current question is answered
  bool isCurrentQuestionAnswered() {
    final question = getCurrentQuestion();
    return question?.answerText != null && question!.answerText!.isNotEmpty;
  }

  /// Get completion percentage
  double getCompletionPercentage() {
    final stats = getStatistics();
    if (stats.totalQuestions == 0) return 0.0;
    return (stats.answered / stats.totalQuestions) * 100;
  }

  // ============================================================================
  // SYNC & PRIVATE HELPERS
  // ============================================================================

  Future<void> _syncWithExamCubit(ExamSession updatedSession) async {
    // Update the session in ExamCubit using the new updateCurrentSession method
    await _examCubit.updateCurrentSession(updatedSession);
  }

  ExamSession _updateSessionProgress(
    ExamSession session,
    ExamProgress updatedProgress,
  ) {
    return ExamSession(
      examSessionId: session.examSessionId,
      userId: session.userId,
      subjectId: session.subjectId,
      examBody: session.examBody,
      paperType: session.paperType,
      questions: session.questions,
      totalMarks: session.totalMarks,
      timeLimitMinutes: session.timeLimitMinutes,
      startedAt: session.startedAt,
      completedAt: session.completedAt,
      status: session.status,
      progress: updatedProgress,
    );
  }

  void _handleSessionCompletion(ExamSession completedSession) {
    _timer?.cancel();
    emit(ExamSessionState.completed(
        session: completedSession, currentQuestionIndex: 0));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _examCubitSubscription?.cancel();
    return super.close();
  }

  // ============================================================================
// ADD TO ExamSessionCubit (exam_session_cubit.dart)
// ============================================================================

// Add these methods to ExamSessionCubit class

  // ============================================================================
  // EXAM RESULT CALCULATION (Single Session)
  // ============================================================================

  /// Calculate exam result for the current session
  ExamResult? calculateSessionResult() {
    final currentState = state;

    // Only calculate for completed or abandoned sessions
    if (currentState is! _Completed && currentState is! _Abandoned) {
      pskyLog('Cannot calculate result: Session is not completed or abandoned');
      return null;
    }

    try {
      final session = currentState is _Completed
          ? currentState.session
          : (currentState as _Abandoned).session;

      // Validate session has questions
      if (session.questions.isEmpty) {
        pskyLog('Cannot calculate result: No questions in session');
        return null;
      }

      // Calculate and return result
      final result = ExamCalculator.calculateResult(session);
      pskyLog(
          'Session result calculated: ${result.score.percentage}% - Grade ${result.grade.grade}');
      return result;
    } catch (e) {
      pskyLog('Error calculating session result: $e');
      return null;
    }
  }

  /// Get real-time score preview (for active sessions)
  ExamScore? getCurrentScore() {
    final currentState = state;

    if (currentState is! _Active && currentState is! _Paused) {
      return null;
    }

    try {
      final session = currentState is _Active
          ? currentState.session
          : (currentState as _Paused).session;

      if (session.questions.isEmpty) return null;

      return ExamCalculator.calculateScore(session.questions);
    } catch (e) {
      pskyLog('Error calculating current score: $e');
      return null;
    }
  }

  /// Get real-time grade preview
  ExamGrade? getCurrentGrade() {
    final score = getCurrentScore();
    if (score == null) return null;

    try {
      return ExamCalculator.calculateGrade(score.percentage);
    } catch (e) {
      pskyLog('Error calculating current grade: $e');
      return null;
    }
  }

  /// Get performance metrics for current session
  PerformanceMetrics? getCurrentPerformanceMetrics() {
    final currentState = state;

    if (currentState is! _Active &&
        currentState is! _Paused &&
        currentState is! _Completed &&
        currentState is! _Abandoned) {
      return null;
    }

    try {
      ExamSession session;
      if (currentState is _Active) {
        session = currentState.session;
      } else if (currentState is _Paused) {
        session = (currentState as _Paused).session;
      } else if (currentState is _Completed) {
        session = currentState.session;
      } else {
        session = (currentState as _Abandoned).session;
      }

      return ExamCalculator.calculatePerformanceMetrics(session);
    } catch (e) {
      pskyLog('Error calculating performance metrics: $e');
      return null;
    }
  }

  /// Get time metrics for current session
  TimeMetrics? getCurrentTimeMetrics() {
    final currentState = state;

    if (currentState is! _Active && currentState is! _Paused) {
      return null;
    }

    try {
      final session = currentState is _Active
          ? currentState.session
          : (currentState as _Paused).session;

      return ExamCalculator.calculateTimeMetrics(
        timeLimitMinutes: session.timeLimitMinutes,
        timeElapsedMinutes: session.progress?.timeElapsedMinutes ?? 0,
      );
    } catch (e) {
      pskyLog('Error calculating time metrics: $e');
      return null;
    }
  }

  /// Get time alerts for current session
  TimeAlerts? getCurrentTimeAlerts() {
    final timeMetrics = getCurrentTimeMetrics();
    final currentState = state;

    if (timeMetrics == null || currentState is! _Active) {
      return null;
    }

    try {
      final session = currentState.session;
      final questionsRemaining =
          session.questions.length - (session.progress?.answeredCount ?? 0);

      return ExamCalculator.calculateTimeAlerts(
        timeRemainingMinutes: timeMetrics.timeRemainingMinutes,
        questionsRemaining: questionsRemaining,
      );
    } catch (e) {
      pskyLog('Error calculating time alerts: $e');
      return null;
    }
  }

  /// Get weak areas for current session
  List<WeakArea> getCurrentWeakAreas() {
    final currentState = state;

    if (currentState is! _Active &&
        currentState is! _Paused &&
        currentState is! _Completed &&
        currentState is! _Abandoned) {
      return [];
    }

    try {
      ExamSession session;
      if (currentState is _Active) {
        session = currentState.session;
      } else if (currentState is _Paused) {
        session = (currentState as _Paused).session;
      } else if (currentState is _Completed) {
        session = currentState.session;
      } else {
        session = (currentState as _Abandoned).session;
      }

      if (session.questions.isEmpty) return [];

      return ExamCalculator.identifyWeakAreas(session.questions);
    } catch (e) {
      pskyLog('Error identifying weak areas: $e');
      return [];
    }
  }

  /// Check if session can be calculated (has answers)
  bool canCalculateResult() {
    final currentState = state;

    if (currentState is! _Completed && currentState is! _Abandoned) {
      return false;
    }

    final session = currentState is _Completed
        ? currentState.session
        : (currentState as _Abandoned).session;

    // Check if at least one question has been attempted
    return session.questions
        .any((q) => q.selectedAnswer != null && q.selectedAnswer!.isNotEmpty);
  }

// ============================================================================
// TIME CALCULATION FUNCTIONS
// ============================================================================

  /// Get total time limit as Duration
  Duration getTotalTimeLimit() {
    final currentState = state;

    // Handle _HasData state
    if (currentState is _Active) {
      return Duration(minutes: currentState.session.timeLimitMinutes);
    }

    // Handle _Completed state
    if (currentState is _Completed) {
      return Duration(minutes: currentState.session.timeLimitMinutes);
    }

    return Duration.zero;
  }

  /// Get time spent so far as Duration
  Duration getTimeSpent() {
    final currentState = state;

    // Handle _HasData state
    if (currentState is _Active) {
      return _calculateTimeSpent(currentState.session);
    }

    // Handle _Completed state
    if (currentState is _Completed) {
      return _calculateTimeSpent(currentState.session);
    }

    return Duration.zero;
  }

  /// Helper to calculate time spent for any session
  Duration _calculateTimeSpent(ExamSession session) {
    // If session hasn't started, return zero
    if (session.startedAt == null) return Duration.zero;

    // If session is completed, use the progress timeElapsed
    if (session.status == ExamSessionStatus.completed &&
        session.progress != null) {
      return Duration(minutes: session.progress!.timeElapsedMinutes);
    }

    // If session is in progress, calculate from start time
    if (session.status == ExamSessionStatus.inProgress) {
      final elapsed = DateTime.now().difference(session.startedAt!);
      return elapsed;
    }

    // For paused sessions, use the saved progress time
    if (session.status == ExamSessionStatus.paused &&
        session.progress != null) {
      return Duration(minutes: session.progress!.timeElapsedMinutes);
    }

    return Duration.zero;
  }

  /// Get time remaining as Duration
  Duration getTimeRemaining() {
    final currentState = state;

    // Handle _HasData state
    if (currentState is _Active) {
      final timeLimit =
          Duration(minutes: currentState.session.timeLimitMinutes);
      final timeSpent = _calculateTimeSpent(currentState.session);
      final remaining = timeLimit - timeSpent;
      return remaining.isNegative ? Duration.zero : remaining;
    }

    // Handle _Completed state
    if (currentState is _Completed) {
      final timeLimit =
          Duration(minutes: currentState.session.timeLimitMinutes);
      final timeSpent = _calculateTimeSpent(currentState.session);
      final remaining = timeLimit - timeSpent;
      return remaining.isNegative ? Duration.zero : remaining;
    }

    return Duration.zero;
  }

  /// Get time spent as formatted string (HH:MM:SS or MM:SS)
  String getFormattedTimeSpent() {
    final duration = getTimeSpent();
    return _formatDuration(duration);
  }

  /// Get time remaining as formatted string (HH:MM:SS or MM:SS)
  String getFormattedTimeRemaining() {
    final duration = getTimeRemaining();
    return _formatDuration(duration);
  }

  /// Get total time limit as formatted string
  String getFormattedTotalTime() {
    final duration = getTotalTimeLimit();
    return _formatDuration(duration);
  }

  /// Check if time is up
  bool isTimeUp() {
    return getTimeRemaining() == Duration.zero;
  }

  /// Get percentage of time used (0-100)
  double getTimeUsedPercentage() {
    final totalSeconds = getTotalTimeLimit().inSeconds;
    if (totalSeconds == 0) return 0.0;

    final spentSeconds = getTimeSpent().inSeconds;
    return (spentSeconds / totalSeconds) * 100;
  }

  /// Get time urgency level
  TimeUrgency getTimeUrgency() {
    final remaining = getTimeRemaining();

    if (remaining == Duration.zero) {
      return TimeUrgency.timeUp;
    } else if (remaining.inMinutes <= 5) {
      return TimeUrgency.critical;
    } else if (remaining.inMinutes <= 10) {
      return TimeUrgency.warning;
    } else {
      return TimeUrgency.normal;
    }
  }

  /// Get readable time format (e.g., "1h 30m", "45m", "30s")
  String getReadableTimeSpent() {
    final duration = getTimeSpent();
    return _formatReadableDuration(duration);
  }

  /// Get readable time remaining
  String getReadableTimeRemaining() {
    final duration = getTimeRemaining();
    return _formatReadableDuration(duration);
  }

  /// Calculate average time per question attempted
  Duration getAverageTimePerQuestion() {
    final currentState = state;

    ExamProgress? progress;

    // Get progress from current state
    if (currentState is _Active) {
      progress = currentState.session.progress;
    } else if (currentState is _Completed) {
      progress = currentState.session.progress;
    }

    if (progress == null || progress.answeredCount == 0) return Duration.zero;

    final timeSpent = getTimeSpent();
    final avgSeconds = timeSpent.inSeconds ~/ progress.answeredCount;

    return Duration(seconds: avgSeconds);
  }

  /// Calculate estimated time to complete remaining questions
  Duration getEstimatedTimeForRemaining() {
    final currentState = state;

    ExamProgress? progress;

    // Get progress from current state
    if (currentState is _Active) {
      progress = currentState.session.progress;
    } else if (currentState is _Completed) {
      progress = currentState.session.progress;
    }

    if (progress == null || progress.answeredCount == 0) return Duration.zero;

    final avgTimePerQuestion = getAverageTimePerQuestion();
    final remainingQuestions = progress.unansweredCount;

    return avgTimePerQuestion * remainingQuestions;
  }

  /// Check if projected to finish on time
  bool willFinishOnTime() {
    final timeRemaining = getTimeRemaining();
    final estimatedTimeNeeded = getEstimatedTimeForRemaining();

    return timeRemaining >= estimatedTimeNeeded;
  }

  /// Get time alerts and warnings
  List<String> getTimeAlerts() {
    final alerts = <String>[];
    final remaining = getTimeRemaining();
    final currentState = state;

    ExamProgress? progress;

    // Get progress from current state
    if (currentState is _Active) {
      progress = currentState.session.progress;
    } else if (currentState is _Completed) {
      progress = currentState.session.progress;
    }

    if (progress == null) return alerts;

    // Time's up alert
    if (remaining == Duration.zero) {
      alerts.add("Time's up! Please submit your exam.");
      return alerts;
    }

    // Critical time warning
    if (remaining.inMinutes <= 5 && remaining.inMinutes > 0) {
      alerts.add("URGENT: Only ${remaining.inMinutes} minute(s) remaining!");
    }

    // General warning
    if (remaining.inMinutes <= 10 && remaining.inMinutes > 5) {
      alerts.add("Warning: ${remaining.inMinutes} minutes left.");
    }

    // Questions vs time warning
    if (progress.unansweredCount > 0 && !willFinishOnTime()) {
      alerts.add(
          "${progress.unansweredCount} question(s) remaining - you may not finish on time!");
    }

    return alerts;
  }

  /// Get comprehensive time metrics
  TimeMetrics getTimeMetrics() {
    final currentState = state;

    // Default empty metrics
    final emptyMetrics = TimeMetrics(
      totalTimeMinutes: 0,
      totalTimeSeconds: 0,
      timeSpentMinutes: 0,
      timeSpentSeconds: 0,
      timeRemainingMinutes: 0,
      timeRemainingSeconds: 0,
      timeUsedPercentage: 0.0,
      timeEfficiency: 100.0,
      isTimeUp: false,
      formattedTotalTime: "00:00",
      formattedTimeSpent: "00:00",
      formattedTimeRemaining: "00:00",
    );

    // Return empty if not in valid state
    if (currentState is! _Active && currentState is! _Completed) {
      return emptyMetrics;
    }

    final totalTime = getTotalTimeLimit();
    final timeSpent = getTimeSpent();
    final timeRemaining = getTimeRemaining();
    final usedPercentage = getTimeUsedPercentage();

    return TimeMetrics(
      totalTimeMinutes: totalTime.inMinutes,
      totalTimeSeconds: totalTime.inSeconds,
      timeSpentMinutes: timeSpent.inMinutes,
      timeSpentSeconds: timeSpent.inSeconds,
      timeRemainingMinutes: timeRemaining.inMinutes,
      timeRemainingSeconds: timeRemaining.inSeconds,
      timeUsedPercentage: usedPercentage,
      timeEfficiency: 100 - usedPercentage,
      isTimeUp: timeRemaining == Duration.zero,
      formattedTotalTime: _formatDuration(totalTime),
      formattedTimeSpent: _formatDuration(timeSpent),
      formattedTimeRemaining: _formatDuration(timeRemaining),
    );
  }

// ============================================================================
// PRIVATE HELPER FUNCTIONS
// ============================================================================

  /// Format duration as "HH:MM:SS" or "MM:SS"
  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
  }

  /// Format duration as readable string (e.g., "1h 30m", "45m", "30s")
  String _formatReadableDuration(Duration duration) {
    if (duration == Duration.zero) return '0s';

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final parts = <String>[];
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    if (seconds > 0 && hours == 0) parts.add('${seconds}s');

    return parts.isEmpty ? '0s' : parts.join(' ');
  }
}
