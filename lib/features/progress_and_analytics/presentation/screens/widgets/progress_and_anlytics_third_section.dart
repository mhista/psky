import 'package:ahiaa_web/core/common/widgets/buttons/dropdown_buttons.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/progress/animated_linear_progress.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/exam_result_calculator.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ProgressAndAnlyticsThirdSection extends StatefulWidget {
  const ProgressAndAnlyticsThirdSection({
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
  State<ProgressAndAnlyticsThirdSection> createState() =>
      _ProgressAndAnlyticsThirdSectionState();
}

class _ProgressAndAnlyticsThirdSectionState
    extends State<ProgressAndAnlyticsThirdSection> {
  List<SubjectAverageData>? mergedSubjects;

  @override
  void initState() {
    super.initState();
    _calculateMergedAverages();
  }

  /// ✅ Calculate merged averages for subjects
  void _calculateMergedAverages() {
    final examCubit = getIt<ExamCubit>();
    final repo = getIt<SubjectRepository>();

    final aggregate = examCubit.calculateAggregateResults();

    if (aggregate == null) {
      setState(() {
        mergedSubjects = [];
      });
      return;
    }

    // ✅ Group results by subject name
    final Map<String, List<ExamResult>> subjectGroups = {};

    for (final result in aggregate.individualResults) {
      final subjectId = result.examSession.subjectId;
      final subjectName = repo.getSubjectById(subjectId)?.name ?? '';

      if (subjectName.isEmpty) continue;

      if (!subjectGroups.containsKey(subjectName)) {
        subjectGroups[subjectName] = [];
      }
      subjectGroups[subjectName]!.add(result);
    }

    // ✅ Calculate average for each subject group
    final List<SubjectAverageData> subjectAverages = [];

    for (final entry in subjectGroups.entries) {
      final subjectName = entry.key;
      final results = entry.value;

      // Calculate average score
      final totalScore = results.fold<double>(
        0.0,
        (sum, result) => sum + result.score.percentage,
      );
      final averageScore = totalScore / results.length;

      // Calculate average accuracy
      final totalAccuracy = results.fold<double>(
        0.0,
        (sum, result) => sum + result.performanceMetrics.accuracy,
      );
      final averageAccuracy = totalAccuracy / results.length;

      // Count attempts
      final attempts = results.length;

      // Determine status based on average score
      final status = _getStatusFromScore(averageScore);

      subjectAverages.add(SubjectAverageData(
        subjectName: subjectName,
        averageScore: averageScore,
        averageAccuracy: averageAccuracy,
        attempts: attempts,
        status: status,
        results: results,
      ));
    }

    // Sort by average score descending
    subjectAverages.sort((a, b) => b.averageScore.compareTo(a.averageScore));

    setState(() {
      mergedSubjects = subjectAverages;
    });
  }

  /// ✅ Get status label from score
  SubjectStatus _getStatusFromScore(double score) {
    if (score >= 80) {
      return SubjectStatus.excellent;
    } else if (score >= 70) {
      return SubjectStatus.good;
    } else if (score >= 60) {
      return SubjectStatus.average;
    } else if (score >= 50) {
      return SubjectStatus.needsImprovement;
    } else {
      return SubjectStatus.poor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final examCubit = getIt<ExamCubit>();
    final responsive = ResponsiveBreakpoints.of(context);

    return BlocListener<ExamCubit, ExamState>(
      bloc: examCubit,
      listener: (context, state) {
        // Refresh when exam state changes
        state.maybeWhen(
          hasData: (_, __, ___, ____) => _calculateMergedAverages(),
          completed: (_, __) => _calculateMergedAverages(),
          orElse: () {},
        );
      },
      child: ThreeToOneShimmer(
        isLoading: widget.isLoading,
        hasData: widget.hasData,
        hasError: widget.hasError,
        width: double.infinity,
        radius: 16,
        height: 220,
        useFunction: true,
        errorText: "The Report can't be displayed due to incomplete data",
        errorButtonText: 'Contact Support',
        errorColor: PColors.tertiary.withValues(alpha: 0.5),
        loadedWidget: TRoundedContainer(
          height: 487,
          showBorder: widget.hasData,
          width: double.infinity,
          backgroundColor: widget.isFirstTime ? PColors.grey : null,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (responsive.isMobile)
                Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ResponsiveText('Subject Breakdown')
                            .withSize(20)
                            .bold,
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 269),
                          child: const ResponsiveText(
                            'See how your perform across different subjects',
                          ).withSize(10),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 12,
                      children: [
                        KDropDownButton(
                          text: 'This month',
                          showBorder: true,
                          isActive: widget.hasData,
                          size: 7,
                        ),
                      ],
                    )
                  ],
                ),
              if (!responsive.isMobile)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ResponsiveText('Subject Breakdown')
                            .withSize(20)
                            .bold,
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 269),
                          child: const ResponsiveText(
                            'See how your perform across different subjects',
                          ).withSize(10),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 12,
                      children: [
                        KDropDownButton(
                          text: 'This month',
                          showBorder: true,
                          isActive: widget.hasData,
                          size: 7,
                        ),
                      ],
                    )
                  ],
                ),
              const Gap(20),
              if (!responsive.isMobile)
                TRoundedContainer(
                  height: 52,
                  radius: 16,
                  backgroundColor: PColors.grey,
                  child: Row(
                    spacing: 125,
                    children: [
                      const ResponsiveText('Subject')
                          .withSize(10)
                          .withOpacity(0.9)
                          .bold,
                      const ResponsiveText('Average Score')
                          .withSize(10)
                          .withOpacity(0.9)
                          .bold,
                      const ResponsiveText('Attempts')
                          .withSize(10)
                          .withOpacity(0.9)
                          .bold,
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const ResponsiveText('Status')
                            .withSize(10)
                            .withOpacity(0.9)
                            .bold,
                      ),
                    ],
                  ),
                ),
              if (widget.hasData &&
                  mergedSubjects != null &&
                  mergedSubjects!.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                      padding: responsive.isMobile
                              ? const EdgeInsets.only(top: 20)
                              : const EdgeInsets.only(
                                  top: 20, left: 16, right: 16),
                    itemBuilder: (context, index) {
                      final subject = mergedSubjects![index];
                      return _buildSubjectRow(subject);
                    },
                    separatorBuilder: (context, _) => const TRoundedContainer(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      height: 0.5,
                      backgroundColor: PColors.darkGrey,
                    ),
                    itemCount: mergedSubjects!.length,
                  ),
                ),
              if (widget.isFirstTime)
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
                              'Your subject performance will appear here ',
                            )
                                .withSize(14)
                                .withWeight(FontWeight.w600)
                                .withOpacity(0.6),
                            const ResponsiveText(
                              'after you complete a few tests.',
                            )
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
        ),
      ),
    );
  }

  /// ✅ Build a single subject row
  Widget _buildSubjectRow(SubjectAverageData subject) {
    final responsive = ResponsiveBreakpoints.of(context);

    return responsive.isMobile
        ? Container(
            constraints: const BoxConstraints(maxWidth: 285),
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: PColors.light,
              borderRadius: BorderRadius.circular(12),
            ),
            // height: 144,
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResponsiveText(subject.subjectName ?? '')
                            .withSize(11)
                            .bold,
                        ResponsiveText('${subject.attempts}').withSize(5),
                      ],
                    ),
                    // Different colors
                    TRoundedContainer(
                      height: 20,
                      radius: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      backgroundColor:
                          subject.status.color.withValues(alpha: 0.28),
                      child: Center(
                        child: ResponsiveText(subject.status.label)
                            .withSize(7)
                            .withColor(subject.status.color),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    Expanded(
                      child: LinearGradeProgress(
                        currentGrade: subject.averageScore.toDouble(),
                        totalGrade: 100,
                        height: 4,
                        segments: [
                          GradeSegment(value: 8, color: PColors.primary),
                        ],
                      ),
                    ),
                    ResponsiveText(
                            '${subject.averageScore.toStringAsFixed(1)}%')
                        .withSize(9)
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: TElevatedButton(
                    text: 'View Report',
                    color: PColors.white,
                    bgColor: PColors.primary,
                    onTap: () {
                      // getIt<AppRouter>()
                      //     .router
                      //     .goNamed(KRoutes.result);
                    },
                  ),
                ),
              ],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Subject Name
                  SizedBox(
                    width: 100,
                    child: ResponsiveText(subject.subjectName).withSize(9).bold,
                  ),
                  const Gap(45),

                  // Average Score
                  SizedBox(
                    width: 90,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: ResponsiveText(
                              '${subject.averageScore.toStringAsFixed(1)}%')
                          .withSize(9),
                    ),
                  ),
                  const Gap(90),

                  // Attempts
                  SizedBox(
                    width: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: ResponsiveText('${subject.attempts}').withSize(9),
                    ),
                  ),
                  const Gap(100),

                  // Status Badge
                  Center(
                    child: TRoundedContainer(
                      height: 28,
                      margin: const EdgeInsets.only(left: 40),
                      radius: 1000,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 7),
                      backgroundColor:
                          subject.status.color.withValues(alpha: 0.28),
                      child: ResponsiveText(subject.status.label)
                          .withSize(9)
                          .withColor(subject.status.color),
                    ),
                  ),
                  const Gap(20),
                ],
              ),
              TElevatedButton(
                text: 'Practice weak areas',
                color: PColors.white,
                bgColor: PColors.primary,
                onTap: () {
                  // TODO: Navigate to practice for this subject
                },
              ),
              const Gap(15)
            ],
          );
  }
}

// ============================================================================
// DATA MODELS
// ============================================================================

/// Data for a subject with merged averages
class SubjectAverageData {
  final String subjectName;
  final double averageScore;
  final double averageAccuracy;
  final int attempts;
  final SubjectStatus status;
  final List<ExamResult> results;

  SubjectAverageData({
    required this.subjectName,
    required this.averageScore,
    required this.averageAccuracy,
    required this.attempts,
    required this.status,
    required this.results,
  });
}

/// Status enum with colors and labels
enum SubjectStatus {
  excellent,
  good,
  average,
  needsImprovement,
  poor;

  String get label {
    switch (this) {
      case SubjectStatus.excellent:
        return 'Excellent';
      case SubjectStatus.good:
        return 'Good';
      case SubjectStatus.average:
        return 'Average';
      case SubjectStatus.needsImprovement:
        return 'Needs Improvement';
      case SubjectStatus.poor:
        return 'Poor';
    }
  }

  Color get color {
    switch (this) {
      case SubjectStatus.excellent:
        return PColors.secondary1;
      case SubjectStatus.good:
        return const Color(0xFF4CAF50); // Green
      case SubjectStatus.average:
        return const Color(0xFFFF9800); // Orange
      case SubjectStatus.needsImprovement:
        return const Color(0xFFFF5722); // Deep Orange
      case SubjectStatus.poor:
        return const Color(0xFFF44336); // Red
    }
  }
}
