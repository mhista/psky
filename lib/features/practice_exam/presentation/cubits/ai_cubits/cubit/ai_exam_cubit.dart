import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/exam_timer.dart';
import 'package:ahiaa_web/core/services/gemini_chat_service.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/ai_exam_models.dart/ai_question_data.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/exam_question.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_question_entity.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'ai_exam_state.dart';
part 'ai_exam_cubit.freezed.dart';

@lazySingleton
class AiExamCubit extends Cubit<AiExamState> {
  final ExamCubit _examCubit;
  final ExamSessionCubit _examSessionCubit;

  AiExamCubit(
    this._examCubit,
    this._examSessionCubit,
  ) : super(const AiExamState.initial());

  // ============================================================================
  // INITIALIZATION
  // ============================================================================

  /// Initialize with a new AI question data
  void initializeExam({
    required String id,
    required String studentName,
    required String subject,
    required String examBody,
    required String paperType,
    required int numberOfQuestions,
    required int totalNumberOfQuestions,
    List<String>? topics,
    String? difficultyLevel,
    int? yearReference,
    List<String>? excludeQuestions,
    bool? focusWeakAreas,
    int? timeLimitMinutes,
  }) {
    final aiQuestionData = AiQuestionData(
      id: id,
      studentName: studentName,
      subject: subject,
      examBody: examBody,
      topics: topics,
      paperType: paperType,
      numberOfQuestions: numberOfQuestions,
      totalNumberOfQuestions: totalNumberOfQuestions,
      difficultyLevel: difficultyLevel,
      yearReference: yearReference,
      excludeQuestions: excludeQuestions,
      focusWeakAreas: focusWeakAreas,
      timeLimitMinutes: timeLimitMinutes,
    );

    addExamConfiguration(aiQuestionData);
  }

  // ============================================================================
  // UPDATE INDIVIDUAL FIELDS
  // ============================================================================

  /// Update student name
  void updateStudentName(String studentName) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExam = currentState.activeExam.copyWith(
      studentName: studentName,
    );

    _updateActiveExam(updatedExam);
  }

  /// Update subject
  void updateSubject(String subject) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExam = currentState.activeExam.copyWith(
      subject: subject,
    );

    _updateActiveExam(updatedExam);
  }

  /// Update exam body
  void updateExamBody(String examBody) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExam = currentState.activeExam.copyWith(
      examBody: examBody,
    );

    _updateActiveExam(updatedExam);
  }

  /// Update topics
  void updateTopics(List<String> topics) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExam = currentState.activeExam.copyWith(
      topics: topics,
    );

    _updateActiveExam(updatedExam);
  }

  /// Update paper type
  void updatePaperType(String paperType) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExam = currentState.activeExam.copyWith(
      paperType: paperType,
    );

    _updateActiveExam(updatedExam);
  }

  /// Update number of questions
  void updateNumberOfQuestions(int numberOfQuestions) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExam = currentState.activeExam.copyWith(
      numberOfQuestions: numberOfQuestions,
    );

    _updateActiveExam(updatedExam);
  }

  /// Update number of questions
  void updateNumberOfAiQuestion(int numberOfQuestions, AiQuestionData data) {
    final currentState = state;
    if (currentState is! _HasData) return;

    // Find the index of the data to update
    final index =
        currentState.allExams.indexWhere((exam) => exam.id == data.id);

    // If not found, return early
    if (index == -1) return;

    // Create the updated data
    final dataToUpdate = currentState.allExams[index]
        .copyWith(numberOfQuestions: numberOfQuestions);

    // Create a new list with the updated data at the correct index
    final updatedExams = List<AiQuestionData>.from(currentState.allExams);
    updatedExams[index] = dataToUpdate;
    bool currentIndex = dataToUpdate.id == currentState.activeExam.id;
    emit(AiExamState.hasData(
      activeExam: currentIndex ? dataToUpdate : currentState.activeExam,
      allExams: updatedExams,
      currentIndex: currentState.currentIndex,
    ));
  }

  /// Update difficulty level
  void updateDifficultyLevel(String? difficultyLevel) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExam = currentState.activeExam.copyWith(
      difficultyLevel: difficultyLevel,
    );

    _updateActiveExam(updatedExam);
  }

  /// Update year reference
  void updateYearReference(int? yearReference) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExam = currentState.activeExam.copyWith(
      yearReference: yearReference,
    );

    _updateActiveExam(updatedExam);
  }

  /// Update exclude questions
  void updateExcludeQuestions(List<String>? excludeQuestions) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExam = currentState.activeExam.copyWith(
      excludeQuestions: excludeQuestions,
    );

    _updateActiveExam(updatedExam);
  }

  /// Update focus weak areas
  void updateFocusWeakAreas(bool? focusWeakAreas) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExam = currentState.activeExam.copyWith(
      focusWeakAreas: focusWeakAreas,
    );

    _updateActiveExam(updatedExam);
  }

  /// Update time limit
  void updateTimeLimitMinutes(int? timeLimitMinutes) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExam = currentState.activeExam.copyWith(
      timeLimitMinutes: timeLimitMinutes,
    );

    _updateActiveExam(updatedExam);
  }

  // fetch ai questions
  Future<void> fetchAiQuestion({bool skipSwitch = false, index = 0}) async {
    final currentState = state;
    if (currentState is! _HasData) {
      emit(const AiExamState.error(message: 'No active exam configuration'));
      return;
    }

    try {
      if (skipSwitch == false) {
        switchToExam(index);
      }

      final aiQuestionData = currentState.activeExam.toAiJson();

      final prompt = """[DATA_ONLY] $aiQuestionData""";
      await getIt<GeminiChatService>().sendAiMessage(prompt);
      return;
    } catch (e) {
      print(e);
      // emit(AiExamState.error(message: 'Failed to fetch questions: $e'));
    }
  }

  /// Update the last fetch threshold
  void updateLastFetchThreshold(int threshold) {
    final currentState = state;
    if (currentState is! _HasData) return;

    emit(AiExamState.hasData(
      activeExam: currentState.activeExam,
      allExams: currentState.allExams,
      currentIndex: currentState.currentIndex,
      currentNumberOfQuestionsGenerated:
          currentState.currentNumberOfQuestionsGenerated,
      lastFetchThreshold: threshold,
    ));
  }

  // /// Check if we should fetch new questions
  // bool shouldFetchNewQuestions(int currentIndex, int totalQuestions) {
  //   final currentState = state;
  //   if (currentState is! _HasData) return false;

  //   // Don't fetch if we've reached 30 questions
  //   if (currentState.hasReachedLimit || totalQuestions >= 29) return false;

  //   // Calculate the current threshold (2 steps before current length)
  //   final currentThreshold = totalQuestions - 2;
  //   if (currentThreshold >= 27) false;
  //   // Only fetch if:
  //   // 1. We're at or past the threshold
  //   // 2. We haven't fetched at this threshold yet
  //   // 3. Current index is greater than last fetch threshold (moving forward)
  //   return currentIndex >= currentThreshold &&
  //       currentIndex > currentState.lastFetchThreshold &&
  //       currentThreshold > currentState.lastFetchThreshold;
  // }

  // ============================================================================
  // FETCH FROM AI AND INITIALIZE EXAM SESSION
  // ============================================================================

  /// Fetch questions from AI and initialize exam session
  Future<bool> fetchQuestionsFromAI({
    required List<Map<String, dynamic>> aiResponse,
    required Map<String, dynamic> metadata,
    ExamMode examMode = ExamMode.custom,
  }) async {
    final currentState = state;
    if (currentState is! _HasData) {
        pskyLog('No active exam configuration');

      emit(const AiExamState.error(message: 'No active exam configuration'));
      return false;
    }

    try {
      emit(const AiExamState.loading());

      final aiQuestionData = currentState.activeExam;

      // Convert AI response to ExamQuestion list
      final questions = _convertAIResponseToQuestions(
        aiResponse,
        aiQuestionData,
      );

      if (questions.isEmpty) {
        pskyLog('No questions generated from AI');
        emit(
            const AiExamState.error(message: 'No questions generated from AI'));
        if (currentState.allExams.isNotEmpty) {
          emit(AiExamState.hasData(
            activeExam: aiQuestionData,
            allExams: currentState.allExams,
            currentIndex: currentState.currentIndex,
            currentNumberOfQuestionsGenerated:
                metadata["currentNumberOfQuestionsGenerated"],
            lastFetchThreshold:
                currentState.lastFetchThreshold,
                didFetchAnyExam: false
          ));
        }
        return false;
      }

      // Get subject info
      final subject = aiQuestionData.getSubjectFromName();
      if (subject == null) {
        emit(AiExamState.error(
            message: 'Subject "${aiQuestionData.subject}" not found'));
        if (currentState.allExams.isNotEmpty) {
          emit(AiExamState.hasData(
            activeExam: aiQuestionData,
            allExams: currentState.allExams,
            currentIndex: currentState.currentIndex,
            currentNumberOfQuestionsGenerated:
                metadata["currentNumberOfQuestionsGenerated"],
            lastFetchThreshold:
                currentState.lastFetchThreshold,
                didFetchAnyExam: false
          ));
        }
        return false;
      }

      // if it is a data to update, update it here
      final sessionData = _examSessionCubit.state.maybeWhen(
        orElse: () {},
        active: (session, currentQuestionIndex, timeRemainingSeconds, hasReachedLimit) =>
            (session, currentQuestionIndex, timeRemainingSeconds, hasReachedLimit),
      );
      if (sessionData?.$1.subjectId == subject.id) {
        await _examSessionCubit.appendQuestions(questions);
        // Update state to reflect successful initialization
        emit(AiExamState.hasData(
          activeExam: aiQuestionData,
          allExams: currentState.allExams,
          currentIndex: currentState.currentIndex,
          currentNumberOfQuestionsGenerated:
              metadata["currentNumberOfQuestionsGenerated"],
          lastFetchThreshold: currentState.lastFetchThreshold,
          didFetchAnyExam: true
        ));
        return false;
      }

      final user = getIt<UserCubit>().currentUser ?? UserEntity.empty();

      final totalQuestion = currentState.activeExam.totalNumberOfQuestions;
      final totalTime = QuestionTimeEstimator.calculateEstimatedMinutes(
          numberOfQuestions: totalQuestion, paperType: PaperType.objective);
      // Start exam in ExamCubit
      await _examCubit.startExam(
        userId: user.id,
        subjectId: subject.id,
        examBody: aiQuestionData.getExamBody(),
        paperType: aiQuestionData.getPaperType(),
        questions: questions,
        currentSubjects: _examCubit.subjects,
        examMode: examMode,
        customTimeLimit: totalTime,
        totalMarks : (totalQuestion * 2) 
      );

      // Update state to reflect successful initialization
      emit(AiExamState.hasData(
        activeExam: aiQuestionData,
        allExams: currentState.allExams,
        currentIndex: currentState.currentIndex,
        currentNumberOfQuestionsGenerated:
            metadata["currentNumberOfQuestionsGenerated"],
        lastFetchThreshold: currentState.lastFetchThreshold,
        didFetchAnyExam: true
      ));
      print('Successfully initialized exam with ${questions.length} questions');

      return true;
    } catch (e) {
      emit(AiExamState.error(message: 'Failed to fetch questions: $e'));
      return false;
    }
  }

  /// Convert AI response JSON to ExamQuestion objects
  /// Convert AI response JSON to ExamQuestion objects
  List<ExamQuestion> _convertAIResponseToQuestions(
    List<Map<String, dynamic>> aiResponse,
    AiQuestionData aiQuestionData,
  ) {
    final questions = <ExamQuestion>[];

    for (final questionJson in aiResponse) {
      try {
        // Parse options if present
        List<QuestionOption>? options;
        if (questionJson['options'] != null) {
          options = (questionJson['options'] as List)
              .map((opt) => QuestionOption(
                    id: opt['id'] as String,
                    text: opt['text'] as String,
                  ))
              .toList();
        }

        // Parse marking scheme if present (FIXED: using camelCase)
        MarkingScheme? markingScheme;
        if (questionJson['markingScheme'] != null) {
          final schemeData =
              questionJson['markingScheme'] as Map<String, dynamic>;
          markingScheme = MarkingScheme(
            points: (schemeData['points'] as List?)
                    ?.map((p) => MarkingPoint(
                          criterion: p['criterion'] as String,
                          marks: p['marks'] as int,
                        ))
                    .toList() ??
                [],
            totalMarks: ((schemeData['points'] as List?)
                        ?.map((p) => MarkingPoint(
                              criterion: p['criterion'] as String,
                              marks: p['marks'] as int,
                            ))
                        .toList() ??
                    [])
                .fold<int>(0, (prev, next) => prev + next.marks),
          );
        }

        // Parse question type (FIXED: using camelCase)
        final questionTypeString = questionJson['questionType'] as String;
        final questionType =
            QuestionTypeExtension.fromString(questionTypeString) ??
                QuestionType.objective;

        // Parse difficulty level (FIXED: using camelCase)
        final difficultyString = questionJson['difficultyLevel'] as String;
        final difficultyLevel =
            DifficultyLevelExtension.fromString(difficultyString) ??
                DifficultyLevel.medium;

        // Get subject info for topicId (use first topic or empty string)
        final subject = aiQuestionData.getSubjectFromName();
        final topicId = aiQuestionData.topics?.first ?? '';

        final question = ExamQuestion(
          // generate a stable id
          questionId:
              'ai_${DateTime.now().millisecondsSinceEpoch}_${questionJson['questionNumber']}',
          questionNumber: questionJson['questionNumber'] as int,
          questionText: questionJson['questionText'] as String,
          questionType: questionType,
          subjectId: subject?.id ?? '',
          topicId: topicId,
          examBody: aiQuestionData.getExamBody(),
          difficultyLevel: difficultyLevel,
          marks: questionJson['marks'] as int? ?? 1,
          timeEstimateMinutes: questionJson['timeEstimateMinutes'] as int? ?? 2,
          options: options,
          correctAnswer: questionJson['correctAnswer'] as String?,
          answerText: questionJson['answerText'] as String?,
          markingScheme: markingScheme,
          explanation: questionJson['explanation'] as String? ?? '',
          commonMistakes: (questionJson['commonMistakes'] as List?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
          syllabusReference: questionJson['syllabusReference'] as String? ?? '',
          requiresDiagram: questionJson['requiresDiagram'] as bool? ?? false,
          diagramDescription: questionJson['diagramDescription'] as String?,
          diagramUrl: questionJson['diagramUrl'] as String?,
          pastYearReference: questionJson['pastYearReference'] as int?,
          createdAt: DateTime.now(),
          createdBy: 'coach kai ai',
        );

        questions.add(question);
      } catch (e) {
        // FIXED: using camelCase for error message
        print('Error parsing question ${questionJson['questionNumber']}: $e');
        continue;
      }
    }

    return questions;
  }

  // ============================================================================
  // NAVIGATION & MANAGEMENT
  // ============================================================================

  /// Switch to a different exam configuration
  void switchToExam(int index) {
    final currentState = state;
    if (currentState is! _HasData) return;

    if (index < 0 || index >= currentState.allExams.length) return;

    emit(AiExamState.hasData(
      activeExam: currentState.allExams[index],
      allExams: currentState.allExams,
      currentIndex: index,
    ));
  }

  /// Add a new exam configuration to the list
  void addExamConfiguration(AiQuestionData aiQuestionData) {
    final currentState = state;
    debugPrint(currentState.toString());
    if (currentState is! _HasData) {
      emit(AiExamState.hasData(
        activeExam: aiQuestionData,
        allExams: [aiQuestionData],
        currentIndex: 0,
      ));
      debugPrint(currentState.toString());

      return;
    }

    final updatedExams = List<AiQuestionData>.from(currentState.allExams)
      ..add(aiQuestionData);
    debugPrint(updatedExams.length.toString());

    emit(AiExamState.hasData(
      activeExam: aiQuestionData,
      allExams: updatedExams,
      currentIndex: updatedExams.length - 1,
    ));
  }

  /// Remove an exam configuration
  void removeExamConfiguration(int index) {
    final currentState = state;
    if (currentState is! _HasData) return;

    if (index < 0 || index >= currentState.allExams.length) return;
    if (currentState.allExams.length == 1) {
      emit(const AiExamState.initial());
      return;
    }

    final updatedExams = List<AiQuestionData>.from(currentState.allExams)
      ..removeAt(index);

    final newIndex = currentState.currentIndex >= updatedExams.length
        ? updatedExams.length - 1
        : currentState.currentIndex;

    emit(AiExamState.hasData(
      activeExam: updatedExams[newIndex],
      allExams: updatedExams,
      currentIndex: newIndex,
    ));
  }

  /// Reset to initial state
  void reset() {
    emit(const AiExamState.initial());
  }

  // ============================================================================
  // HELPERS
  // ============================================================================

  void _updateActiveExam(AiQuestionData updatedExam) {
    final currentState = state;
    if (currentState is! _HasData) return;

    final updatedExams = List<AiQuestionData>.from(currentState.allExams);
    updatedExams[currentState.currentIndex] = updatedExam;

    emit(AiExamState.hasData(
      activeExam: updatedExam,
      allExams: updatedExams,
      currentIndex: currentState.currentIndex,
    ));
  }

  /// Get the active exam configuration as JSON (for AI request)
  Map<String, dynamic>? getActiveExamAsJson() {
    final currentState = state;
    if (currentState is! _HasData) return null;

    return currentState.activeExam.toMap();
  }
}
