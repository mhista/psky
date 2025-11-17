import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class AverageMeanWidget extends StatelessWidget {
  const AverageMeanWidget({
    super.key,
    required this.isLoading,
    required this.hasError,
    required this.hasData,
  });

  final bool isLoading;
  final bool hasError;
  final bool hasData;

  @override
  Widget build(BuildContext context) {
    final examCubit = getIt<ExamCubit>();

    return BlocBuilder<ExamCubit, ExamState>(
      bloc: examCubit,
      builder: (context, state) {
          // Extract state information
          
          final aggregate = examCubit.calculateAggregateResults();
          final correctScores = aggregate?.aggregateScore.correct;
          final totalQuestions = aggregate?.aggregateScore.totalQuestions;

          final grade = aggregate?.overallGrade.grade;
          final description = aggregate?.overallGrade.description;
          final globalMetrics = examCubit.getGlobalTimeMetrics();

          final remarks = aggregate?.overallGrade.remarks;
          final individualResults = aggregate?.individualResults ?? [];
          pskyLog(aggregate?.totalTimeSpent);
          pskyLog(
              " current: ${examCubit.getTotalTimeSpentAcrossAllSessions()}  total: ${examCubit.getTotalTimeLimitAcrossAllSessions()}");
          final recommendation = aggregate?.bestPerformance.recommendations;
          recommendation?.shuffle();

        return Row(
          spacing: 12,
          // runAlignment: WrapAlignment.center,
          children: [
            Expanded(
              child: ThreeToOneShimmer(
                isLoading: isLoading,
                hasError: hasError,
                hasData: hasData,
                loadedWidget: AnalyticsAverage(
                    hasData: hasData,
                    title: 'Average Score',
                    subtitle: 'Your mean score across all exams',
                    score: aggregate?.averageCompletionRate.toStringAsFixed(2) ?? '0.0',
                    symbol: '%',
                    info: 'Your mean score across all exams'),
              ),
            ),
            Expanded(
              child: ThreeToOneShimmer(
                isLoading: isLoading,
                hasError: hasError,
                hasData: hasData,
                loadedWidget: AnalyticsAverage(
                    hasData: hasData,
                    isUp: true,
                    title: 'Total Exams',
                    subtitle: 'Number of practice tests completed',
                    score: aggregate?.totalSessions.toString() ?? '0',
                    symbol: '',
                    info: '24% decrease from last month'),
              ),
            ),
            Expanded(
              child: ThreeToOneShimmer(
                isLoading: isLoading,
                hasError: hasError,
                hasData: hasData,
                loadedWidget: AnalyticsAverage(
                    hasData: hasData,
                    isUp: true,
                    title: 'Time Spent',
                    subtitle: "Total time you've taken to practice",
                    score: ((aggregate?.totalTimeSpent ?? 0) ~/ 60).toString() ?? '0',
                    symbol: 'hrs',
                    info: '20% decrease from last month'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AnalyticsAverage extends StatelessWidget {
  const AnalyticsAverage(
      {super.key,
      this.isUp = true,
      required this.title,
      required this.subtitle,
      required this.score,
      required this.symbol,
      required this.info,
      required this.hasData});
  final bool isUp, hasData;
  final String title, subtitle, score, info, symbol;
  @override
  Widget build(BuildContext context) {
    final color = isUp ? PColors.white : PColors.black;
    final avColor = isUp ? PColors.white : PColors.primary2;

    return TRoundedContainer(
      backgroundColor: !hasData
          ? PColors.grey
          : isUp
              ? PColors.primary
              : PColors.primary.withValues(alpha: 0.4),
      height: 150,
      child: hasData
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText(title).withSize(9).withColor(color).bold,
                    ResponsiveText(subtitle).withSize(6).withColor(color),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText('$score$symbol')
                        .withSize(32)
                        .withColor(avColor)
                        .bold,
                    Row(
                      spacing: 8,
                      children: [
                        if (isUp) const Icon(Iconsax.trend_up),
                        if (!isUp) const Icon(Iconsax.trend_down),
                        const ResponsiveText(
                                "Your mean score accross all exams")
                            .withSize(6)
                      ],
                    )
                  ],
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ResponsiveText('No data yet')
                        .withSize(9)
                        .withColor(PColors.darkGrey)
                        .bold,
                    const ResponsiveText(
                            'Take your first examination to see performance here')
                        .withSize(6)
                        .withColor(PColors.darkGrey),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText('00$symbol')
                        .withSize(32)
                        .withColor(PColors.darkGrey)
                        .bold,
                    Row(
                      spacing: 8,
                      children: [
                        if (isUp) const Icon(Iconsax.trend_up),
                        if (!isUp) const Icon(Iconsax.trend_down),
                        const ResponsiveText(
                                "Your mean score accross all exams")
                            .withSize(6)
                      ],
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
