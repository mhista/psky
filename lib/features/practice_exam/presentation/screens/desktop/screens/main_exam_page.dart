import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/icons/circular_icon.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/services/exam_timer.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/text_strings.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/ai_exam_models.dart/ai_question_data.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/ai_cubits/cubit/ai_exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_controller_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_session_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/component_widgets/question_index_containers.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/component_widgets/question_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class MainExamScreenDesktop extends StatefulWidget {
  const MainExamScreenDesktop({
    super.key,
  });

  @override
  State<MainExamScreenDesktop> createState() => _MainExamScreenDesktopState();
}

class _MainExamScreenDesktopState extends State<MainExamScreenDesktop> {
  bool _isFetchingQuestions = false;
  final subjectRepo = getIt<SubjectRepository>();
  final ai = getIt<AiExamCubit>();
  final session = getIt<ExamSessionCubit>();
  final examPageController = getIt<ExamControllerCubit>();
  final examCubit = getIt<ExamCubit>();
  bool _isNavigating = false;

  @override
  void initState() {
    session.state.maybeWhen(
      orElse: () {},
      active: (examSession, currentQuestionIndex, timeRemainingSeconds,
          hasReachedQuestionLimit) {
        if (examSession.status == ExamSessionStatus.inProgress) {
          session.startTimer();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamSessionCubit, ExamSessionState>(
      bloc: session,
      listener: (context, sessionState) {
        // Listen for question index changes
        sessionState.maybeWhen(
          orElse: () {},
          active: (examSession, currentQuestionIndex, timeRemaining,
              hasReachedLimit) {
            _handleQuestionIndexChange(
                currentQuestionIndex: currentQuestionIndex,
                totalQuestions: examSession.questions.length - 1,
                ai: ai,
                hasReachedLimit: hasReachedLimit);
          },
        );
      },
      builder: (context, sessionState) {
        pskyLog(session.state);
        final sessionData = sessionState.maybeWhen(
          orElse: () {},
          active: (session, currentQuestionIndex, timeRemainingSeconds,
                  hasReachedLimit) =>
              (
            session,
            currentQuestionIndex,
            timeRemainingSeconds,
            hasReachedLimit
          ),
          completed: (session, currentQuestionIndex) {
            return (
              session,
              currentQuestionIndex,
              session.timeLimitMinutes * 60,
              session.questions.length >= PTexts.examTotalCounts
            );
          },
        );
        final subjects =
            subjectRepo.getSubjectById(sessionData?.$1.subjectId ?? '');
        final currentQuestionInd = (sessionData?.$2 ?? 0) + 1;
        final currentQuestionText =
            sessionData?.$1.questions[currentQuestionInd - 1].questionText;
        final currentQuestion =
            sessionData?.$1.questions[currentQuestionInd - 1];
        final questionLength = sessionData?.$1.questions.length;
        final selectedAnswer = currentQuestion?.selectedAnswer;
    
        return TRoundedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              // SUBJECT INTRO SECTION
              TRoundedContainer(
                padding: const EdgeInsets.all(12),
                backgroundColor: PColors.light,
                height: 72,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ResponsiveText('Subject').withSize(8),
                        ResponsiveText(subjects?.name ?? '')
                            .withSize(16)
                            .bold,
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const ResponsiveText('Time left:')
                                .withSize(10)
                                .bold
                                .withColor(PColors.primary),
                            ExamTimerWidget(
                                timeLeft:
                                    sessionData?.$1.timeLimitMinutes ?? 0),
                          ],
                        ),
                        const PCircularIcon(
                          icon: Icons.filter_list,
                          height: 40,
                          width: 40,
                        )
                      ],
                    )
                  ],
                ),
              ),
              // MAIN QUESTION SECTION
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TRoundedContainer(
                        backgroundColor: PColors.light,
                        // padding: const EdgeInsets.all(0),
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 15,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ResponsiveText(
                                          'Question ${currentQuestionInd ?? 1} of ${PTexts.examTotalCounts}')
                                      .withSize(9)
                                      .bold,
                                  const Icon(Icons.flag_outlined)
                                ],
                              ),
                              GptMarkdown(
                                currentQuestionText ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                              const TRoundedContainer(
                                  padding: EdgeInsets.all(0),
                                  height: 224,
                                  child: QuestionPageView())
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TElevatedButton(
                              text: 'Previous',
                              onTap: currentQuestionInd < 2
                                  ? null
                                  : () {
                                      if (sessionData?.$1?.status ==
                                          ExamSessionStatus.completed) {
                                        examPageController
                                            .previousQuestion();
    
                                        session.previousAnswereedQuestion();
                                        return;
                                      }
                                      examPageController.previousQuestion();
    
                                      session.previousQuestion();
                                    },
                              bgColor: PColors.primary,
                              color: PColors.white,
                            ),
                            TElevatedButton(
                              text: currentQuestionInd ==
                                      PTexts.examTotalCounts
                                  ? sessionData?.$1?.status ==
                                          ExamSessionStatus.completed
                                      ? 'Finish'
                                      : 'Submit'
                                  : 'Next',
                              onTap: _getNextButtonAction(
                                currentQuestionInd: currentQuestionInd,
                                questionLength: questionLength,
                                selectedAnswer: selectedAnswer,
                                ai: ai,
                                session: session,
                                examPageController: examPageController,
                                sessionData: sessionData,
                              ),
                              bgColor: PColors.primary,
                              color: PColors.white,
                            )
                          ],
                        ),
                      ),
                      const QuestionIndexContainers()
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Handle question index changes and trigger AI fetch if needed
  void _handleQuestionIndexChange(
      {required int currentQuestionIndex,
      required int totalQuestions,
      required AiExamCubit ai,
      required bool hasReachedLimit}) {
    // Prevent multiple simultaneous fetches
    if (_isFetchingQuestions) return;

    final aiState = ai.state;
    // if (aiState is! _HasData) return;
    final aiStateData = aiState.maybeWhen(
      orElse: () {},
      hasData: (activeExam,
          allExams,
          currentIndex,
          currentNumberOfQuestionsGenerated,
          lastFetchThreshold,
          didFetchAnyExam) {
        pskyLog(lastFetchThreshold);
        return (
          activeExam,
          allExams,
          currentIndex,
          currentNumberOfQuestionsGenerated,
          lastFetchThreshold,
          didFetchAnyExam
        );
      },
    );
    // If we've reached 30 questions, check if there's another subject to start
    if (hasReachedLimit || totalQuestions >= PTexts.examTotalCounts - 1) {
      _checkAndStartNextSubject(
          ai: ai,
          currentIndex: aiStateData?.$3 ?? 0,
          allExams: aiStateData?.$2 ?? []);
      return;
    } else {
      _fetchNewQuestions(
        currentQuestionIndex: currentQuestionIndex,
        totalQuestions: totalQuestions,
        ai: ai,
      );
    }

    // Check if we should fetch new questions for current subject
    // if (ai.shouldFetchNewQuestions(currentQuestionIndex, totalQuestions)) {

    // }
  }

  /// Check if there's another subject in queue and start it
  void _checkAndStartNextSubject({
    required AiExamCubit ai,
    required int currentIndex,
    required List<AiQuestionData> allExams,
  }) {
    // Check if there are more exams in the queue
    if (currentIndex < (allExams.length - 1) &&
        (allExams.length - 1) > currentIndex) {
      final nextIndex = currentIndex + 1;
      pskyLog('Starting next subject at index $nextIndex');

      // Fetch questions for the next exam (this will start a new session)
      // ai.fetchAiQuestion(skipSwitch: false, index: nextIndex);
    } else {
      pskyLog('No more subjects in queue. Exam complete at 30 questions.');
    }
  }

  /// Fetch new questions from AI
  Future<void> _fetchNewQuestions({
    required int currentQuestionIndex,
    required int totalQuestions,
    required AiExamCubit ai,
  }) async {
    _isFetchingQuestions = true;

    try {
      // final aiState = ai.state;
      // if (aiState is! _HasData) return;
      final questionLength = totalQuestions;
      // Get questions to exclude
      final session = getIt<ExamSessionCubit>();
      final sessionState = session.state;

      final questionsToExclude = sessionState.maybeWhen(
        orElse: () => <String>[],
        active: (examSession, _, __, ___) =>
            examSession.questions.map((q) => q.questionText).toList(),
      );

      // Update exclude list
      ai.updateExcludeQuestions(questionsToExclude);
      // Update the threshold to prevent refetching at this point
      ai.updateLastFetchThreshold(totalQuestions - 2);

      // Fetch new questions
      await ai.fetchAiQuestion(skipSwitch: true);

      pskyLog('Fetched new questions at index $totalQuestions-2');
    } catch (e) {
      pskyLog('Error fetching questions: $e');
    } finally {
      _isFetchingQuestions = false;
    }
  }

  /// Get the action for the next button
  VoidCallback? _getNextButtonAction({
    required int currentQuestionInd,
    required int? questionLength,
    required String? selectedAnswer,
    required AiExamCubit ai,
    required ExamSessionCubit session,
    required ExamControllerCubit examPageController,
    required dynamic sessionData,
  }) {
    // if(_isNavigating) return (){};
    // Handle navigation at question 30
    if (currentQuestionInd == PTexts.examTotalCounts) {
      // _isNavigating = true;
      return () {
        examCubit.subjects;

        // The listener will handle checking for next subject
        // This button just triggers the navigation that will fire the listener
        final aiState = ai.state;
        aiState.maybeWhen(
          orElse: () {},
          hasData: (activeExam,
              allExams,
              currentIndex,
              currentNumberOfQuestionsGenerated,
              lastFetchThreshold,
              didFetchAnyExam) async {
            // Check if there are more exams in queue
            if (currentIndex < (allExams.length - 1)) {
              // There's another subject, the listener will handle it
              pskyLog('More subjects available, will start next one');
            } else {
              if (sessionData?.$1?.status == ExamSessionStatus.completed) {
                getIt<AppRouter>().router.pushReplacementNamed(KRoutes.dashboard);
                return;
              }
              await session.submitExam();

              pskyLog('No more subjects, submitting exam');
              session.calculateSessionResult();
              examCubit.calculateAggregateResults();
              // No more subjects, actually submit the exam
              getIt<AppRouter>().router.goNamed(KRoutes.result);
            }
          },
        );
      };
    }

    // Handle normal next
    return () {
      if (sessionData?.$1?.status == ExamSessionStatus.completed) {
        examPageController.nextQuestion();

        session.nextAnsweredQuestion();
        return;
      }
      if ((sessionData?.$2 ?? 0) <= ((questionLength ?? 5) - 1)) {
        if (selectedAnswer == null) {
          examPageController.nextQuestion();
          session.skipQuestion();
          return;
        }
        examPageController.nextQuestion();
        session.nextQuestion(); //is called by skipQuestion if needed
      }
    };
  }
}

class ExamTimerWidget extends StatefulWidget {
  const ExamTimerWidget({
    super.key,
    required this.timeLeft,
  });
  final int timeLeft;
  @override
  State<ExamTimerWidget> createState() => _ExamTimerWidgetState();
}

class _ExamTimerWidgetState extends State<ExamTimerWidget> {
  late ExamTimer timer;
  String time = '';
  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    timer.stop();
    super.dispose();
  }

  startTimer() {
    timer = ExamTimer(
        durationMinutes: widget.timeLeft,
        onTick: (v) {
          // debugPrint(v);
          setState(() {
            time = v;
          });
        });
    timer.start();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveText(time).withSize(15).bold.withColor(PColors.primary);
  }
}
