import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown_implementation.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown_with_search.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/desktop/practice_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PracticeExamSecondSection extends StatelessWidget {
  const PracticeExamSecondSection({
    super.key,
    required this.examCubit,
    required this.stateData,
    required this.subjectRepo,
    required this.isCustom,
    required this.isFirstTime,
    required this.isSingle,
    required this.isQuick,
  });

  final ExamCubit examCubit;
  final (ExamMode, List<String>, List<ExamSession>, ExamSession)? stateData;
  final SubjectRepository subjectRepo;
  final bool isCustom, isSingle, isQuick;
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return Column(
      children: [
        Column(
          children: [
            if (responsive.isMobile)
              Column(
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
                          width: double.infinity,
                          backgroundColor: PColors.white,
                          // showBorder: true,
                          padding: const EdgeInsets.all(0.0),

                          radius: 28,
                          child: KCustomDropdown(
                            items: [
                              'Select exam mode to start',
                              ...ExamModeExtension.allDisplayNames
                            ],
                            onChanged: (v) {
                              debugPrint(v);
                              examCubit.selectMode(
                                  ExamModeExtension.fromDisplayName(v!) ??
                                      ExamMode.custom);
                              debugPrint(stateData?.$1.name);
                              subjectRepo.getAllSubjects();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  if (isCustom || isSingle)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          const ResponsiveText('Choose Subject')
                              .withSize(8)
                              .bold,
                          TRoundedContainer(
                            // width: 312,
                            backgroundColor: PColors.white,
                            // showBorder: true,
                            padding: const EdgeInsets.all(0.0),

                            radius: 28,
                            child: KCustomDropdownWithSearch(
                              items: [
                                'Select ${isSingle ? 'subject' : 'subjects'} to write',
                                ...subjectRepo
                                    .getAllSubjects()
                                    .map((s) => s.name)
                              ],
                              onChanged: (value) {
                                if (isSingle) {
                                  examCubit.clear();
                                  examCubit.selectMode(ExamMode.singleSubject);
                                }
                                examCubit.addSubject(value ?? '');
                                examCubit.selectSubject(value ?? '');
                                examCubit.getAllTopicsForSelected(value ?? '');
                              },
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            if (!responsive.isMobile)
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
                            items: [
                              'Select exam mode to start',
                              ...ExamModeExtension.allDisplayNames
                            ],
                            onChanged: (v) {
                              debugPrint(v);
                              examCubit.selectMode(
                                  ExamModeExtension.fromDisplayName(v ?? '') ??
                                      ExamMode.custom);
                              debugPrint(stateData?.$1.name);
                              subjectRepo.getAllSubjects();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  if (isCustom || isSingle)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            const ResponsiveText('Choose Subject')
                                .withSize(8)
                                .bold,
                            TRoundedContainer(
                              // width: 312,
                              backgroundColor: PColors.white,
                              // showBorder: true,
                              padding: const EdgeInsets.all(0.0),

                              radius: 28,
                              child: KCustomDropdownWithSearch(
                                items: [
                                  'Select ${isSingle ? 'subject' : 'subjects'} to write',
                                  ...subjectRepo
                                      .getAllSubjects()
                                      .map((s) => s.name)
                                ],
                                onChanged: (value) {
                                  pskyLog(stateData?.$1.name);
                                  if (isSingle) {
                                    examCubit.clear();
                                    examCubit
                                        .selectMode(ExamMode.singleSubject);
                                  }
                                  examCubit.addSubject(value ?? '');
                                  examCubit.selectSubject(value ?? '');
                                  examCubit
                                      .getAllTopicsForSelected(value ?? '');
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
                color: isFirstTime ? PColors.darkGrey : PColors.deepBlack,
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
    );
  }
}
