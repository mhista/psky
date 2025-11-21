import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown_implementation.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown_with_search.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/desktop/practice_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PracticeAreaFourthSection extends StatelessWidget {
  const PracticeAreaFourthSection({
    super.key,
    required this.examCubit,
    required this.runtimeType,
    required this.hashCode,
    required this.isCustom,
    required this.isFirstTime,
  });

  final ExamCubit examCubit;
  final Type runtimeType;
  final int hashCode;
  final bool isCustom;
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return Column(
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
              if(responsive.isMobile)
               Column(
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
                            width: double.infinity,
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
                    Padding(
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
                    )
                  ],
                ),
              if(!responsive.isMobile)
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
    );
  }
}
