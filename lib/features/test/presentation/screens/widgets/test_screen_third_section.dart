import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/progress/animated_linear_progress.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/helpers/date_helper.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TestScreenThirdSection extends StatelessWidget {
  const TestScreenThirdSection({
    super.key,
    required this.isLoading,
    required this.hasData,
    required this.hasError,
    required this.isFirstTime,
  });

  final bool isLoading;
  final bool hasData;
  final bool hasError;
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    final examCubit = getIt<ExamCubit>();

    return BlocBuilder<ExamCubit, ExamState>(
      bloc: examCubit,
      builder: (context, state) {
        final aggregate = examCubit.calculateAggregateResults();
        final tests = aggregate?.individualResults;
        // final correctScores = aggregate?.aggregateScore.correct;
        // final totalQuestions = aggregate?.aggregateScore.totalQuestions;

        // final grade = aggregate?.overallGrade.grade;
        // final description = aggregate?.overallGrade.description;
        // final globalMetrics = examCubit.getGlobalTimeMetrics();

        // final remarks = aggregate?.overallGrade.remarks;
        // final individualResults = aggregate?.individualResults ?? [];
        pskyLog(aggregate?.totalTimeSpent);
        pskyLog(
            " current: ${examCubit.getTotalTimeSpentAcrossAllSessions()}  total: ${examCubit.getTotalTimeLimitAcrossAllSessions()}");
        final recommendation = aggregate?.bestPerformance.recommendations;
        recommendation?.shuffle();
        return ThreeToOneShimmer(
            isLoading: isLoading,
            hasData: (hasData && (tests ?? []).isNotEmpty),
            hasError: hasError,
            width: double.infinity,
            radius: 16,
            height: 220,
            useFunction: true,
            errorText: "The Report can't be displayed due to incomplete data",
            errorButtonText: 'Contact Support',
            errorColor: PColors.tertiary.withValues(alpha: 0.5),
            loadedWidget: TRoundedContainer(
              height: 487,
              showBorder: hasData,
              width: double.infinity,
              backgroundColor:
                  isFirstTime ? PColors.primary.withValues(alpha: 0.4) : null,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ResponsiveText('Completed Tests')
                              .withSize(26)
                              .bold,
                          const ResponsiveText(
                                  'Review and track your past test attempts')
                              .withSize(12),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   spacing: 12,
                      //   children: [
                      //     KDropDownButton(
                      //       text: 'Date',
                      //       showBorder: true,
                      //       isActive: hasData,
                      //       size: 7,
                      //     ),
                      //     KDropDownButton(
                      //       text: 'Subjects',
                      //       showBorder: true,
                      //       isActive: hasData,
                      //       size: 7,
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                  const Gap(20),
                  TRoundedContainer(
                    height: 52,
                    radius: 16,
                    backgroundColor: PColors.light.withValues(alpha: 0.6),
                    child: Row(
                      spacing: 120,
                      children: [
                        const ResponsiveText('Subject')
                            .withSize(10)
                            .withWeight(FontWeight.w500)
                            .withOpacity(0.6),
                        const ResponsiveText('Date Taken')
                            .withSize(10)
                            .withWeight(FontWeight.w500)
                            .withOpacity(0.6),
                        const ResponsiveText('Score')
                            .withSize(10)
                            .withWeight(FontWeight.w500)
                            .withOpacity(0.6),
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: const ResponsiveText('Status')
                              .withSize(10)
                              .withWeight(FontWeight.w500)
                              .withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                  if (hasData)
                    Expanded(
                      child: ListView.separated(
                          padding: const EdgeInsets.only(
                              top: 20, left: 16, right: 16),
                          itemBuilder: (context, index) {
                            final test = tests[index];
                            final session = test.examSession;
                            final date = test.completedAt;
                            final subjects = getIt<SubjectRepository>()
                                .getSubjectById(session.subjectId);

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child:
                                          ResponsiveText(subjects?.name ?? '')
                                              .withSize(9)
                                              .bold,
                                    ),
                                    const Gap(60),

                                    ResponsiveText(date.toMMDDYYYY).withSize(9),
                                    // Multi-segment (like your image)
                                    const Gap(100),
                                    LinearGradeProgress(
                                      currentGrade:
                                          test.score.obtainedMarks.toDouble(),
                                      totalGrade:
                                          test.score.totalMarks.toDouble(),
                                      height: 4,
                                      width: 139,
                                      segments: [
                                        GradeSegment(
                                            value: 8, color: PColors.primary),
                                      ],
                                    ),
                                    const Gap(80),

                                    SizedBox(width: 100,
                                      child: TRoundedContainer(
                                        height: 28,
                                        width: 50,
                                        radius: 1000,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 7),
                                        backgroundColor: PColors.secondary1
                                            .withValues(alpha: 0.28),
                                        child:
                                            Center(
                                              child: ResponsiveText(test.grade.description)
                                                  .withSize(9)
                                                  .withColor(PColors.secondary1),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                TElevatedButton(
                                  text: 'View Report',
                                  color: PColors.white,
                                  bgColor: PColors.primary,
                                  onTap: () {
                                    getIt<AppRouter>()
                                        .router
                                        .goNamed(KRoutes.result);
                                  },
                                ),
                                const Gap(15)
                              ],
                            );
                          },
                          separatorBuilder: (context, _) =>
                              const TRoundedContainer(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                width: double.infinity,
                                height: 0.5,
                                backgroundColor: PColors.darkGrey,
                              ),
                          itemCount: tests!.length),
                    ),
                  if (isFirstTime)
                    Column(
                      children: [
                        const Gap(10),
                        TRoundedContainer(
                          height: 307,
                          radius: 16,
                          backgroundColor: PColors.light.withValues(alpha: 0.6),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ResponsiveText(
                                        'Your subject performance will appear here ')
                                    .withSize(14)
                                    .withWeight(FontWeight.w600)
                                    .withOpacity(0.6),
                                const ResponsiveText(
                                        'after you complete a few tests.')
                                    .withSize(14)
                                    .withWeight(FontWeight.w600)
                                    .withOpacity(0.6),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ));
      },
    );
  }
}
