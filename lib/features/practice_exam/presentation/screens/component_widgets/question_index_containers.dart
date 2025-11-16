import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/constants/text_strings.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_controller_cubit.dart' show ExamControllerCubit;
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_session_cubit.dart';
import 'package:flutter/material.dart' hide DropdownMenu;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide showDialog, AlertDialog;

class QuestionIndexContainers extends StatelessWidget {
  const QuestionIndexContainers({super.key, this.isExpanded = true});
  final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    final sessionExam = getIt<ExamSessionCubit>();
    return BlocBuilder<ExamSessionCubit, ExamSessionState>(
      bloc: sessionExam,
      builder: (context, state) {
        final sessionData = state.maybeWhen(
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
        final questions = sessionData?.$1.questions;

        final currentQuestionIndex = (sessionData?.$2 ?? 0);
        final currentQuestion = sessionData?.$1.questions[currentQuestionIndex];
        final options = currentQuestion?.options ?? [];
        final selectedAnswer = currentQuestion?.selectedAnswer;
        final questionLength = sessionData?.$1.questions.length;
        final data = List.generate(
            PTexts.examTotalCounts - (questionLength ?? 0), (index) => index);

        return TRoundedContainer(
          backgroundColor: PColors.light,
          height: 240,
          width: double.infinity,
          // padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // if(isExpanded)
              // const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 0, bottom: 10),
                child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.start,
                    children: [
                      ...?questions?.asMap().entries.map((entry) {
                        final inAnswered = sessionData
                            ?.$1.progress?.answeredQuestions
                            .contains(entry.key);
                        final isInReview = sessionData
                            ?.$1.progress?.answeredQuestions
                            .contains(entry.key);
                        final isInSkipped = sessionData
                            ?.$1.progress?.answeredQuestions
                            .contains(entry.key);
                        final color = (inAnswered ?? false)
                            ? PColors.primary
                            : (isInReview ?? false)
                                ? PColors.review
                                : (isInSkipped ?? false)
                                    ? PColors.transparent
                                    : PColors.transparent;
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: TRoundedContainer(
                            onTap: () {
                             if( sessionData?.$1?.status == ExamSessionStatus.completed){
                              sessionExam.updateCompletedCurrentQuestionIndex(entry.key);
                              getIt<ExamControllerCubit>().goToQuestion(entry.key);
                             }
                            },
                            padding: const EdgeInsets.all(0),
                            width: 40,
                            height: 40,
                            radius: 8,
                            backgroundColor: color,
                            showBorder: true,
                            borderColor: PColors.primary,
                            child: Center(
                                child:
                                    ResponsiveText((entry.key + 1).toString())
                                        .bold
                                        .withSize(11)),
                          ),
                        );
                      }),
                      ...data.map((i) {
                        final currentIndex = i + 1 + (questionLength ?? 0);
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: TRoundedContainer(
                            padding: const EdgeInsets.all(0),

                            width: 40,
                            height: 40,
                            radius: 8,
                            // backgroundColor: PColors.primary,
                            showBorder: true,
                            borderColor: PColors.primary,
                            child: Center(
                                child: ResponsiveText(currentIndex.toString())
                                    .bold
                                    .withSize(11)),
                          ),
                        );
                      }),
                    ]),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 20,
                  children: [
                    const QuestionInfo(
                      text: 'Not Answered',
                    ),
                    QuestionInfo(
                      text: 'Current',
                      bgColor: PColors.primary.withValues(alpha: 0.4),
                    ),
                    const QuestionInfo(
                      text: 'Answered',
                      bgColor: PColors.primary,
                    ),
                    const QuestionInfo(
                      text: 'Review',
                      bgColor: PColors.review,
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TElevatedButton(
                      text: 'Save & Exit',
                      onTap: () {},
                      bgColor: PColors.primary.withValues(alpha: 0.4),
                      color: PColors.black,
                    ),
                    TElevatedButton(
                      text: 'Submit',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const ResponsiveText('Submit Exam'),
                              content: const Text(
                                  'Are you sure you want to submit?.'),
                              actions: [
                                // Secondary action to cancel/dismiss.
                                OutlineButton(
                                  child: const Text('Go back'),
                                  onPressed: () {
                                    // Close the dialog.
                                    Navigator.pop(context);
                                  },
                                ),
                                // Primary action to accept/confirm.
                                PrimaryButton(
                                  child: const Text('Submit'),
                                  onPressed: () {
                                    // Close the dialog. In real apps, perform work before closing.
                                    // Navigator.pop(context);
                                    getIt<AppRouter>()
                                        .router
                                        .goNamed(KRoutes.result);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      bgColor: PColors.primary,
                      color: PColors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class QuestionInfo extends StatelessWidget {
  const QuestionInfo(
      {super.key, this.bgColor = PColors.transparent, this.text = ''});
  final Color bgColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        TRoundedContainer(
          height: 8,
          width: 8,
          showBorder: true,
          radius: 100,
          backgroundColor: bgColor,
        ),
        ResponsiveText(text).withSize(8).withWeight(FontWeight.w500)
      ],
    );
  }
}
