import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown_implementation.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown_with_search.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/widgets/custom_duration.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide TextButton, Theme, Colors, Checkbox, Switch, IconButton;

class DesktopPracticeScreen extends StatelessWidget {
  const DesktopPracticeScreen(
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
          hasData: ( examMode, subjects, examSessions, currentSession,) =>
              ( examMode, subjects, examSessions, currentSession,),
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
        return TRoundedContainer(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: [
                // FIRST SECTION
                ThreeToOneShimmer(
                    isLoading: isLoading,
                    hasData: hasData,
                    hasError: hasError,
                    width: double.infinity,
                    maxWidth: 699,
                    radius: 16,
                    height: 161,
                    useFunction: true,
                    errorText:
                        "Couldn't load your text progress, please refresh or try again",
                    errorColor: PColors.tertiary.withValues(alpha: 0.5),
                    loadedWidget: TRoundedContainer(
                      padding: EdgeInsets.zero,
                      height: 161,
                      width: double.infinity,
                      backgroundColor: PColors.primary2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            child: Column(
                              spacing: 4,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // WELCOME MESSAGE
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                      width: 284,
                                      child: const ResponsiveText(
                                        'Practice Exams',
                                      )
                                          .white
                                          .left
                                          .headlineMedium
                                          .responsive
                                          .withSize(30)),
                                ),
                                // if (isNotEmptyState) const Gap(10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                      width: 203,
                                      child: const ResponsiveText(
                                        'Timed, WAEC-style exams to prepare you under real conditions.',
                                      )
                                          .left
                                          .bodySmall
                                          .responsive
                                          .withSize(10)
                                          .withWeight(FontWeight.w200)
                                          .withColor(PColors.white
                                              .withValues(alpha: 0.7))),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    TElevatedButton(
                                      text: 'Start your first mock',
                                      size: 9,
                                      verticalPadding: 3,
                                      density: -3,
                                      onTap: () {},
                                    ),

                                    // if(isNotEmptyState)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const PRoundedImage(
                            imageType: ImagesType.asset,
                            image: PImages.exam,
                            height: 166,
                            width: 450,
                            fit: BoxFit.fill,
                            padding: 0,
                            borderRadius: 12,
                          )
                        ],
                      ),
                    )),

                // SECOND SECTION
                Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8,
                                children: [
                                  const ResponsiveText('Choose Exam Type')
                                      .withSize(8)
                                      .bold,
                                  TRoundedContainer(
                                    width: 312,
                                    backgroundColor: PColors.white,
                                    // showBorder: true,
                                    padding: EdgeInsets.all(0.0),

                                    radius: 28,
                                    child: KCustomDropdown(
                                      items: ExamModeExtension.allDisplayNames,
                                      onChanged: (v) {
                                        debugPrint(v);
                                        examCubit.selectMode(
                                            ExamModeExtension.fromDisplayName(
                                                    v ?? '') ??
                                                ExamMode.custom);
                                        debugPrint(stateData?.$1.name);
                                        subjectRepo.getAllSubjects();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if (isCustom)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 8,
                                    children: [
                                      const ResponsiveText('Choose Subject')
                                          .withSize(8)
                                          .bold,
                                      TRoundedContainer(
                                        // width: 312,
                                        backgroundColor: PColors.white,
                                        // showBorder: true,
                                        padding: EdgeInsets.all(0.0),

                                        radius: 28,
                                        child: KCustomDropdownWithSearch(
                                          items: subjectRepo
                                              .getAllSubjects()
                                              .map((s) => s.name)
                                              .toList(),
                                          onChanged: (value) {
                                            examCubit.addSubject(value ?? '');
                                            examCubit
                                                .selectSubject(value ?? '');
                                            examCubit.getAllTopicsForSelected(
                                                value ?? '');
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ],
                        )
                      ],
                    ),

                    // QUESTION CHIP AREA
                    TRoundedContainer(
                      width: double.infinity,
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                            color: isFirstTime
                                ? PColors.darkGrey
                                : PColors.deepBlack,
                            radius: const Radius.circular(8),
                            dashPattern: [10, 5]),
                        child: TRoundedContainer(
                            child: !isFirstTime
                                ? const TElevatedButton(
                                    text: 'Start Test',
                                    color: PColors.white,
                                  )
                                : Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    // alignment: WrapAlignment.spaceBetween,
                                    children: examCubit.subjects
                                        .map(
                                          (s) => SubjectBox(
                                            onTap: () {
                                              examCubit.removeSubject(s);
                                            },
                                            text: s,
                                          ),
                                        )
                                        .toList())),
                      ),
                    ),
                  ],
                ),
                // FOCUS AREA SECTION
                if (stateData?.$3 != ExamMode.quickDrill)
                  TRoundedContainer(
                    padding: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ResponsiveText('Focus on weak areas')
                                  .withSize(9)
                                  .bold,
                              const Gap(4),
                              const ResponsiveText(
                                      "We'll mix questions evenly across topics")
                                  .withSize(9),
                            ],
                          ),
                          Switch(value: true, onChanged: (v) {})
                        ],
                      ),
                    ),
                  ),
                // THIRD SECTION
                if (isCustom && examCubit.subjects.isNotEmpty)
                  Column(
                    children: [
                      BlocBuilder<ExamCubit, ExamState>(
                        bloc: examCubit,
                        builder: (context, state) {
                          // Debug: Print state
                          debugPrint(
                              'Current state type: ${state.runtimeType}');

                          final stateData = state.maybeWhen(
                            modeSelected: (examMode, selectedSubjectAndTopic,
                                selectedSubject, selectedSubjectTopics) {
                              debugPrint('Selected Subject: $selectedSubject');
                              debugPrint(
                                  'Available Topics: $selectedSubjectTopics');
                              return (selectedSubject, selectedSubjectTopics);
                            },
                            orElse: () {
                              debugPrint('State is not modeSelected');
                              return (null, <String>[]);
                            },
                          );

                          final selectedSubject = stateData.$1;
                          final topics = stateData.$2;

                          return Column(
                            children: [
                              // Show debug info
                            
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 8,
                                      children: [
                                        const ResponsiveText('Subject')
                                            .withSize(8)
                                            .bold,
                                        TRoundedContainer(
                                          width: 312,
                                          backgroundColor: PColors.white,
                                          padding: const EdgeInsets.all(0.0),
                                          radius: 28,
                                          child: KCustomDropdown(
                                            items: examCubit.selectedSubject !=
                                                    null
                                                ? [
                                                    examCubit.selectedSubject ??
                                                        '',
                                                    ...examCubit.subjects
                                                  ]
                                                : examCubit.subjects,
                                            onChanged: (v) {
                                              if (v != null) {
                                                debugPrint(
                                                    '=== Subject Selected: $v ===');
                                                examCubit.selectSubject(v);
                                                examCubit
                                                    .getAllTopicsForSelected(v);
                                                debugPrint(
                                                    '=== Topics should update now ===');
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 8,
                                        children: [
                                          Row(
                                            children: [
                                              const ResponsiveText(
                                                      'Choose Topics to practice')
                                                  .withSize(8)
                                                  .bold,
                                              if (kDebugMode)
                                                Text(
                                                    ' (${topics.length} topics)',
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.red)),
                                            ],
                                          ),
                                          TRoundedContainer(
                                            backgroundColor: PColors.white,
                                            padding: const EdgeInsets.all(0.0),
                                            radius: 28,
                                            child: KCustomDropdownWithSearch(
                                              key: ValueKey(
                                                  'dropdown_${selectedSubject}_${topics.hashCode}'),
                                              items: topics.isEmpty
                                                  ? ['No topics available']
                                                  : topics,
                                              onChanged: (value) {
                                                debugPrint(
                                                    '=== Topic Selected: $value ===');
                                                if (value != null &&
                                                    value !=
                                                        'No topics available' &&
                                                    topics.isNotEmpty) {
                                                  examCubit
                                                      .addTopicToSelectedSubject(
                                                          value);
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      if (isCustom)
                        // QUESTION CHIP AREA
                        TRoundedContainer(
                          width: double.infinity,
                          child: DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                                color: isFirstTime
                                    ? PColors.darkGrey
                                    : PColors.primary,
                                radius: const Radius.circular(8),
                                dashPattern: [10, 5]),
                            child: TRoundedContainer(
                                child: examCubit.totalTopicCount == 0
                                    ? const SizedBox.shrink()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 12,
                                        children: examCubit.subjects
                                            .where((s) => examCubit
                                                .getTopicsForSubject(s)
                                                .isNotEmpty)
                                            .map((s) {
                                          final subjectTopics =
                                              examCubit.getTopicsForSubject(s);
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            spacing: 8,
                                            children: [
                                              ResponsiveText(s)
                                                  .withSize(8)
                                                  .bold,
                                              Wrap(
                                                spacing: 10,
                                                runSpacing: 10,
                                                children: subjectTopics
                                                    .map((t) => SubjectBox(
                                                        onTap: () {
                                                          examCubit
                                                              .removeTopicFromSubject(
                                                                  s, t);
                                                        },
                                                        text: t))
                                                    .toList(),
                                              ),
                                            ],
                                          );
                                        }).toList())),
                          ),
                        ),
                    ],
                  ),
                // CUSTOM DURATION SETTING
                if (isCustom)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomExamDuration(examCubit:examCubit),
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
