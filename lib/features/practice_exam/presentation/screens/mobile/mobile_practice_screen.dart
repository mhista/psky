import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/widgets/custom_duration.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/widgets/practice_area_first_section.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/widgets/practice_area_fourth_section.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/widgets/practice_area_second_section.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/widgets/practice_area_third_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide TextButton, Theme, Colors, Checkbox, Switch, IconButton;

class MobilePracticeScreen extends StatelessWidget {
  const MobilePracticeScreen(
      {super.key,
      this.isLoading = false,
      this.hasError = false,
      this.expand = false,
      this.isFirstTime = true,
      this.hasData = false});
  final bool isLoading, hasError, hasData, expand, isFirstTime;
  @override
  Widget build(BuildContext context) {
    final examCubit = getIt<ExamCubit>();
    final subjectRepo = getIt<SubjectRepository>();
    return BlocBuilder<ExamCubit, ExamState>(
      bloc: examCubit,
      builder: (context, state) {
        final stateData = state.maybeWhen(
          orElse: () {},
          hasData: (
            examMode,
            subjects,
            examSessions,
            currentSession,
          ) =>
              (
            examMode,
            subjects,
            examSessions,
            currentSession,
          ),
        );

        final modeSelected = state.maybeWhen(
          orElse: () {},
          modeSelected: (examMode, selectedSubjectAndTopic, selectedSubject,
                  selectedSubjectTopics) =>
              (
            examMode,
            selectedSubjectAndTopic,
            selectedSubject,
            selectedSubjectTopics
          ),
        );
        final isCustom = modeSelected?.$1 == ExamMode.custom;
        final isSingle = modeSelected?.$1 == ExamMode.singleSubject;
        final isQuick = modeSelected?.$1 == ExamMode.quickDrill;
        return TRoundedContainer(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: [
                // FIRST SECTION
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: PracticeExamFirstSection(
                      isLoading: isLoading,
                      hasData: hasData,
                      hasError: hasError),
                ),

                // SECOND SECTION
                PracticeExamSecondSection(
                    examCubit: examCubit,
                    stateData: stateData,
                    subjectRepo: subjectRepo,
                    isCustom: isCustom,
                    isSingle: isSingle,
                    isQuick: isQuick,
                    isFirstTime: isFirstTime),
                // FOCUS AREA SECTION
                if (stateData?.$1 != ExamMode.quickDrill)
                  const PracticeExamThirdSection(),
                // THIRD SECTION
                if ((isCustom || isSingle) && examCubit.subjects.isNotEmpty)
                  PracticeAreaFourthSection(
                      examCubit: examCubit,
                      runtimeType: runtimeType,
                      hashCode: hashCode,
                      isCustom: isCustom,
                      isSingle: isSingle,
                      isFirstTime: isFirstTime),
                // CUSTOM DURATION SETTING
                if (isCustom || isSingle )
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomExamDuration(examCubit: examCubit),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}

class SubjectBox extends StatelessWidget {
  const SubjectBox({
    super.key,
    required this.onTap,
    required this.text,
  });

  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TRoundedContainer(
        // width: ('Acid-Base Balance').length * 8,
        padding: const EdgeInsets.all(6),
        showBorder: true,
        borderColor: PColors.deepBlack,
        radius: 8,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResponsiveText(text).withSize(8).bold,
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.cancel_outlined,
                  size: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
