import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/services/exam_timer.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/services/time_calculator.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/text_strings.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/ai_exam_models.dart/ai_question_data.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/subject.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/ai_cubits/cubit/ai_exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:uuid/uuid.dart';

class CustomExamDuration extends StatelessWidget {
  const CustomExamDuration({super.key, required this.examCubit});
  final ExamCubit examCubit;

  @override
  Widget build(BuildContext context) {
    final aiCubit = getIt<AiExamCubit>();
    final responsive = ResponsiveBreakpoints.of(context);

    return BlocListener<ExamCubit, ExamState>(
      bloc: examCubit,
      // listenWhen: (previous, current) {
      //   // Only listen when we're in modeSelected state and subject/topics change
      //   final prevData = previous.maybeWhen(
      //     modeSelected:
      //         (_, seelectedSubjectTopicMap, selectedSubject, selectedTopics) =>
      //             (seelectedSubjectTopicMap, selectedSubject, selectedTopics),
      //     orElse: () => null,
      //   );

      //   final currentData = current.maybeWhen(
      //     modeSelected:
      //         (_, seelectedSubjectTopicMap, selectedSubject, selectedTopics) =>
      //             (seelectedSubjectTopicMap, selectedSubject, selectedTopics),
      //     orElse: () => null,
      //   );

      //   // Return true if subject or topics changed
      //   return currentData != null && prevData != currentData;
      // },
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          modeSelected: (examMode, selectedSubjectAndTopic, selectedSubject,
              selectedSubjectTopics) {
            // Validate we have a subject selected
            if (selectedSubject == null || selectedSubject.isEmpty) {
              debugPrint('❌ No subject selected');
              return;
            }

            if (examCubit.subjects.isEmpty) {
              aiCubit.reset();
              debugPrint('❌ All exams reseted');

              return;
            }

            // Validate we have topics
            if (selectedSubjectTopics.isEmpty) {
              debugPrint('❌ No topics selected for subject: $selectedSubject');
              return;
            }

            debugPrint('✅ ExamCubit - Subject: $selectedSubject');
            debugPrint(
                '✅ ExamCubit - Topics: ${examCubit.selectedSubjectTopics}');

            // Check if this subject already exists in AiExamCubit
            final aiState = aiCubit.state;

            aiState.maybeWhen(
              orElse: () {
                // No existing data, initialize new exam
                debugPrint('🆕 Initializing new AI exam for: $selectedSubject');
                _initializeNewExam(
                    aiCubit, selectedSubject, examCubit.selectedSubjectTopics);
                debugPrint(aiCubit.state.toString());
              },
              hasData: (activeExam,
                  allExams,
                  currentIndex,
                  currentNumberOfQuestionsGenerated,
                  thrshold,
                  didFetchAnyExam) {
                // Check if this subject already exists
                final existingExam = allExams.firstWhereOrNull(
                  (exam) => exam.subject == selectedSubject,
                );

                if (existingExam != null) {
                  // Subject exists, update its topics
                  debugPrint('🔄 Updating existing exam for: $selectedSubject');
                  debugPrint('   Old topics: ${existingExam.topics}');
                  debugPrint(
                      '   New topics: ${examCubit.selectedSubjectTopics}');

                  aiCubit.updateTopics(examCubit.selectedSubjectTopics);

                  debugPrint('   ✅ Topics updated');
                } else {
                  // Subject doesn't exist, create new exam
                  debugPrint('🆕 Adding new exam for: $selectedSubject');
                  _initializeNewExam(aiCubit, selectedSubject,
                      examCubit.selectedSubjectTopics);
                }
              },
            );
          },
        );
      },
      child: BlocBuilder<AiExamCubit, AiExamState>(
        bloc: aiCubit,
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            hasData: (activeExam, allExams, currentIndex,
                currentNumberOfQuestionsGenerated, thrshold, didFetchAnyExam) {
              // Check if we have an exam for the currently selected subject
              final currentSubject = examCubit.selectedSubject;
              // if (currentSubject == null) return const SizedBox.shrink();

              final relevantExam = allExams.isNotEmpty;

              if (!relevantExam) return const SizedBox.shrink();

              // Build the UI with the relevant exam data
              return _buildExamDurationUI(context, aiCubit);
            },
          );
        },
      ),
    );
  }

  void _initializeNewExam(
    AiExamCubit aiCubit,
    String subject,
    List<String> topics,
  ) {
    final user = getIt<UserCubit>().user ?? UserEntity.empty();
    final _uuid = Uuid();

    debugPrint(user.email);
    aiCubit.initializeExam(
      id: _uuid.v4(),
      studentName: user.fullName,
      subject: subject,
      totalNumberOfQuestions: PTexts.examTotalCounts,
      topics: topics,
      examBody: ExamBody.waec.name,
      paperType: PaperType.objective.name,
      numberOfQuestions: 5,
      // timeLimitMinutes:
    );
  }

  Widget _buildExamDurationUI(BuildContext context, AiExamCubit aiCubit) {
    final responsive = ResponsiveBreakpoints.of(context);

    final hasData = aiCubit.state.maybeWhen(
      orElse: () {},
      hasData: (activeExam, allExams, currentIndex,
              currentNumberOfQuestionsGenerated, threshold, didFetchAnyExam) =>
          (
        activeExam,
        allExams,
        currentIndex,
        currentNumberOfQuestionsGenerated,
        threshold,
        didFetchAnyExam
      ),
    );
    final aiList = hasData!.$2.where(
        (data) => examCubit.getTopicsForSubject(data.subject).isNotEmpty);
    final totalQuestion =
        aiList.fold(0, (prev, next) => next.totalNumberOfQuestions + prev);
    List<Subject?> subjects = aiList
        .map((s) => getIt<SubjectRepository>()
            .getSubjectByNameAndExamBody(s.subject, ExamBody.waec))
        .toList();
    final totalTime = QuestionTimeEstimator.calculateFormattedTime(
        numberOfQuestions: totalQuestion, paperType: PaperType.objective);
    // final totalTime =
    //     aiList.fold(0, (prev, next) => (next.timeLimitMinutes ?? 0) + prev);

    return TRoundedContainer(
      borderColor: PColors.darkGrey,
      showBorder: true,
      width: double.infinity,
      child: Column(
        spacing: 14,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: responsive.isMobile ? 40 : 46,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ResponsiveText('Custom Exam')
                      .withSize(responsive.isMobile ? 13 : 16)
                      .bold,
                  Row(
                    spacing: 9,
                    children: [
                      const ResponsiveText('Total :').withSize(8),
                      ResponsiveText('$totalQuestion Questions')
                          .withSize(8)
                          .bold,
                    ],
                  ),
                  if (!responsive.isMobile)
                    Row(
                      spacing: 9,
                      children: [
                        const ResponsiveText('Exam Duration :').withSize(8),
                        Column(
                          spacing: 3,
                          children: [
                            TRoundedContainer(
                              padding: const EdgeInsets.all(0),
                              backgroundColor: PColors.light,
                              height: 37,
                              width: 37,
                              radius: 8,
                              child: Center(
                                child: ResponsiveText(
                                  totalTime.split(':')[0],
                                ).withSize(12).bold,
                              ),
                            ),
                            const ResponsiveText(
                              'Hours',
                            ).withSize(5)
                          ],
                        ),
                        Column(
                          spacing: 3,
                          children: [
                            TRoundedContainer(
                              padding: const EdgeInsets.all(0),
                              backgroundColor: PColors.light,
                              height: 37,
                              width: 37,
                              radius: 8,
                              child: Center(
                                child: ResponsiveText(
                                  totalTime.split(':')[1],
                                ).withSize(12).bold,
                              ),
                            ),
                            const ResponsiveText(
                              'Minutes',
                            ).withSize(5)
                          ],
                        ),
                      ],
                    ),
                ],
              ),
              // TElevatedButton(
              //   text: 'Adjust',
              //   color: PColors.primary5,
              //   bgColor: PColors.primary.withValues(alpha: 0.2),
              //   onTap: () {
              //     // Show time picker dialog
              //     _showTimeAdjustDialog(context);
              //   },
              // )
            ],
          ),
          if (responsive.isMobile)
            Column(
              spacing: 9,
              children: [
                const ResponsiveText('Exam Duration :').withSize(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 9,
                  children: [
                    Column(
                      spacing: 3,
                      children: [
                        TRoundedContainer(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: PColors.light,
                          height: 37,
                          width: 37,
                          radius: 8,
                          child: Center(
                            child: ResponsiveText(
                              totalTime.split(':')[0],
                            ).withSize(12).bold,
                          ),
                        ),
                        const ResponsiveText(
                          'Hours',
                        ).withSize(5)
                      ],
                    ),
                    Column(
                      spacing: 3,
                      children: [
                        TRoundedContainer(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: PColors.light,
                          height: 37,
                          width: 37,
                          radius: 8,
                          child: Center(
                            child: ResponsiveText(
                              totalTime.split(':')[1],
                            ).withSize(12).bold,
                          ),
                        ),
                        const ResponsiveText(
                          'Minutes',
                        ).withSize(5)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          Column(
            children: [
              TRoundedContainer(
                backgroundColor: PColors.light,
                height: 52,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ResponsiveText('Subject').withSize(9).bold,
                    const ResponsiveText('Questions').withSize(9).bold,
                  ],
                ),
              ),
              ...aiList.map((data) {
                return TRoundedContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: responsive.isMobile ? 5 : 0,
                    children: [
                      Expanded(
                        child: ResponsiveText(data.subject).withSize(9).bold,
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (data.numberOfQuestions > 5) {
                                getIt<AiExamCubit>().updateNumberOfAiQuestion(
                                    data.numberOfQuestions - 1, data);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: responsive.isMobile ? 0 : 2.0),
                              child: Icon(Icons.minimize, size: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TRoundedContainer(
                              padding: const EdgeInsets.all(0),
                              backgroundColor: PColors.light,
                              height: 32,
                              width: 38,
                              radius: 8,
                              child: Center(
                                child: ResponsiveText(
                                  '${data.totalNumberOfQuestions}',
                                ).withSize(10).bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (data.numberOfQuestions < 100) {
                                getIt<AiExamCubit>().updateNumberOfAiQuestion(
                                    data.numberOfQuestions + 1, data);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: responsive.isMobile ? 8.0 : 12.0),
                              child: Icon(Icons.add, size: 20),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
              const Gap(20),
              Align(
                alignment: Alignment.centerRight,
                child: TElevatedButton(
                  text: 'Start Test',
                  color: PColors.white,
                  bgColor: PColors.primary,
                  size: 8,
                  onTap: () => _fetchAiQuestion(
                      aiCubit, hasData, totalQuestion, context),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _fetchAiQuestion(
      AiExamCubit aiCubit,
      (AiQuestionData, List<AiQuestionData>, int, int?, int, bool)? hasData,
      int totalQuestion,
      BuildContext context) async {
    // Validate before starting
    if (totalQuestion < PTexts.examTotalCounts) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least 5 questions'),
        ),
      );
      return;
    }
    await aiCubit.fetchAiQuestion();
    getIt<ExamSessionCubit>().state.maybeWhen(
          orElse: () {},
          active: (session, currentQuestionIndex, timeRemainingSeconds,
              hssReachedLimit) {
            if (session.questions.isEmpty) {
              pskyLog('retrying');
              _fetchAiQuestion(
                aiCubit,
                hasData,
                totalQuestion,
                context,
              );
            } else {
              getIt<AppRouter>().router.goNamed(KRoutes.examInstruct);
            }
          },
        );
  }

  void _showTimeAdjustDialog(BuildContext context) {
    // Implement time adjustment dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adjust Exam Duration'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select exam duration:'),
            // Add slider or time picker here
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Save time
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
