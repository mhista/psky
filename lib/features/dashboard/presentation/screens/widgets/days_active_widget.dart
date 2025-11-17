import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/streak_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_cubit_helpers.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DaysActiveWidget extends StatefulWidget {
  const DaysActiveWidget(
      {super.key,
      this.isExpanded = true,
      this.isLoading = false,
      this.hasError = false,
      this.hasData = true});
  final bool isExpanded;
  final bool isLoading, hasError, hasData;

  @override
  State<DaysActiveWidget> createState() => _DaysActiveWidgetState();
}

class _DaysActiveWidgetState extends State<DaysActiveWidget> {
  MonthlyGridData? _cachedStreakData;
  bool _isLoading = true;
  final examCubit = getIt<ExamCubit>();

  @override
  void initState() {
    super.initState();
    _loadStreakData();
  }

  Future<void> _loadStreakData() async {
    try {
      final streakData = await examCubit.getMonthlyGridData();

      if (mounted) {
        setState(() {
          _cachedStreakData = streakData;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading streak data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final hasStreak = (_cachedStreakData?.currentStreak ?? 0) > 0;

    final data = List.generate(30, (index) => index);
    return BlocListener<ExamCubit, ExamState>(
      bloc: examCubit,
      listener: (context, state) {
        // Refresh streak data when exam is completed
        state.maybeWhen(
          completed: (_, __) => _loadStreakData(),
          orElse: () {},
        );
      },
      child: _buildDaysActivuty(data),
    );
  }

  ThreeToOneShimmer _buildDaysActivuty(List<int> data) {
    final responsive = ResponsiveBreakpoints.of(context);

    return ThreeToOneShimmer(
      isLoading: widget.isLoading,
      hasError: widget.hasError,
      hasData: widget.hasData,
      radius: 16,
      height: responsive.isMobile ? 300 : 240,
      width: double.infinity,
      errorColor: PColors.bg4.withValues(alpha: 0.3),
      errorText: "Couldn't load activity, Try again later",
      loadedWidget: TRoundedContainer(
        backgroundColor: PColors.white,
        height: responsive.isMobile ? 300 : 240,
        width: double.infinity,
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: responsive.isMobile
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: ResponsiveText(
                                    '${_cachedStreakData?.activeDays ?? 0}/')
                                .bold
                                .withColor(PColors.buttonSecondary),
                          ),
                          ResponsiveText('30')
                              .bold
                              .withSize(responsive.isMobile ? 48 : 58)
                              .withColor(PColors.primary5),
                        ],
                      ),
                      SizedBox(
                          width: 113,
                          child: const ResponsiveText(
                                  'Number of days you’ve shown up — start today')
                              .withSize(6)),
                    ],
                  ),
                  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: TRoundedContainer(
                        onTap: () {},
                        // width: 107,
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor:
                            PColors.primary2.withValues(alpha: 0.4),
                        radius: 100,
                        child: Row(
                          children: [
                            ResponsiveText(
                                    _cachedStreakData?.month ?? 'January')
                                .withSize(9),
                            // const Gap(5),
                            // const Icon(
                            //   Icons.arrow_drop_down_rounded,
                            //   size: 20,
                            // )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            // if(isExpanded)
            // const Gap(20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (_isLoading)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 9.0, right: 9, bottom: 10),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.start,
                          children: data.map((day) {
                            Color color;

                            return const TRoundedContainer(
                              width: 40,
                              height: 40,
                              radius: 8,
                              backgroundColor: PColors.light,
                            );
                          }).toList(),
                        ),
                      ),
                    if (!_isLoading)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 9.0, right: 9, bottom: 10),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.start,
                          children: _cachedStreakData!.days.reversed.map((day) {
                            Color color;

                            // Color based on intensity (0-4)
                            switch (day.intensity) {
                              case 0:
                                color = Colors.gray[200]; // No activity
                                break;
                              case 1:
                                color = PColors.primary5
                                    .withValues(alpha: 0.3); // Low
                                break;
                              case 2:
                                color = PColors.primary5
                                    .withValues(alpha: 0.5); // Medium
                                break;
                              case 3:
                                color = PColors.primary5
                                    .withValues(alpha: 0.7); // High
                                break;
                              case 4:
                                color = PColors.primary5
                                    .withValues(alpha: 0.9); // Very high
                                break;
                              default:
                                color = Colors.gray[200];
                            }
                            return TRoundedContainer(
                              width: 40,
                              height: 40,
                              radius: 8,
                              backgroundColor: color,
                            );
                          }).toList(),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
