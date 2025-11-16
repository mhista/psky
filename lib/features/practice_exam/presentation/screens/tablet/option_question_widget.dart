import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart' show getIt;
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/text_strings.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class OptionedQuestionWidget extends StatelessWidget {
  const OptionedQuestionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final session = getIt<ExamSessionCubit>();

    return BlocBuilder<ExamSessionCubit, ExamSessionState>(
      bloc: session,
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
        final currentQuestionIndex = (sessionData?.$2 ?? 0);
        final currentQuestion = sessionData?.$1.questions[currentQuestionIndex];
        final options = currentQuestion?.options ?? [];
        final selectedAnswer = currentQuestion?.selectedAnswer;
        return TRoundedContainer(
            backgroundColor: PColors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: options.map((option) {
                // Determine background color based on session status and answer correctness
                Color backgroundColor = PColors.white;

                if (sessionData?.$1?.status == ExamSessionStatus.completed) {
                  final isCorrectAnswer =
                      option.id == currentQuestion?.correctAnswer;
                  final isSelectedAnswer = option.id == selectedAnswer;

                  if (isSelectedAnswer && isCorrectAnswer) {
                    // User selected the correct answer - Green
                    backgroundColor = PColors.secondary1;
                  } else if (isSelectedAnswer && !isCorrectAnswer) {
                    // User selected wrong answer - Red
                    backgroundColor =
                        PColors.error.withOpacity(0.2); // Light red
                  } else if (!isSelectedAnswer && isCorrectAnswer) {
                    // Show correct answer if user selected wrong - Green
                    backgroundColor = PColors.secondary1;
                  }
                }

                return MouseRegion(
                  cursor: sessionData?.$1?.status != ExamSessionStatus.completed
                      ? SystemMouseCursors.click
                      : SystemMouseCursors
                          .basic, // Change cursor for completed state
                  child: TRoundedContainer(
                    radius: 0,
                    backgroundColor: backgroundColor,
                    onTap: () {
                      // Disable clicks in completed mode
                      if (sessionData?.$1?.status ==
                          ExamSessionStatus.completed) return;

                      session.submitAnswer(option.id).then((v) {
                        Future.delayed(const Duration(milliseconds: 200), () {
                          session.nextQuestion();
                        });
                      });
                    },
                    height: 56,
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Stack(
                            children: [
                              const Positioned(
                                top: 4,
                                left: 4,
                                child: TRoundedContainer(
                                  height: 16,
                                  width: 16,
                                  radius: 100,
                                  showShadow: false,
                                  showBorder: true,
                                  borderColor: PColors.primary,
                                ),
                              ),
                              if (selectedAnswer != null &&
                                  selectedAnswer.isNotEmpty &&
                                  selectedAnswer == option.id)
                                const Positioned(
                                  top: 7.2,
                                  left: 7.6,
                                  child: TRoundedContainer(
                                    height: 9.33,
                                    width: 9.33,
                                    radius: 100,
                                    showShadow: false,
                                    showBorder: false,
                                    backgroundColor: PColors.primary,
                                  ),
                                ),
                              // Show checkmark or X icon in completed mode
                             
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: ResponsiveText('(${option.id})').withSize(10),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.5),
                          child: GptMarkdown(
                            option.text,
                            style: const TextStyle(fontSize: 11),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ));
      },
    );
  }
}
