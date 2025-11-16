import 'package:ahiaa_web/core/common/widgets/buttons/dropdown_buttons.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/progress/animated_linear_progress.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LeaderBoardWidget extends StatefulWidget {
  const LeaderBoardWidget(
      {super.key,
      this.isLoading = false,
      this.hasError = false,
      this.expand = false,
      this.hasData = true});

  final bool isLoading, hasError, hasData, expand;

  @override
  State<LeaderBoardWidget> createState() => _LeaderBoardWidgetState();
}

class _LeaderBoardWidgetState extends State<LeaderBoardWidget> {
    final examCubit = getIt<ExamCubit>();

    Future<void> _getLeaderBoardData()async {
      examCubit.getGlobalTimeMetrics();
    }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamCubit, ExamState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ThreeToOneShimmer(
          isLoading: widget.isLoading,
          hasError: widget.hasError,
          hasData: widget.hasData,
          radius: 16,
          height: 478,
          errorColor: PColors.tertiary.withValues(alpha: 0.4),
          errorText: 'Leaderboard unavailable, Please check back soon',
          width: widget.expand ? 366 : 280,
          loadedWidget: TRoundedContainer(
            backgroundColor: PColors.light,
            width: widget.expand ? 366 : 280,
            padding: const EdgeInsets.symmetric(vertical: 12),
            height: 475,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ResponsiveText('Leaderboard').withSize(12).bold,
                      const KDropDownButton(
                        text: 'All Subjects',
                      )
                    ],
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          spacing: 12,
                          children: [
                            const UserAvater(
                              size: 24,
                              useAddButton: false,
                              isExtended: false,
                            ),
                            const ResponsiveText('John Deo').withSize(9),
                            LinearGradeProgress(
                              currentGrade: 22,
                              totalGrade: 30,
                              height: 4,
                              width: 101,
                              segments: [
                                GradeSegment(value: 8, color: PColors.primary),
                              ],
                            ),
                            const ResponsiveText('90%').withSize(9),
                          ],
                        );
                      },
                      separatorBuilder: (context, _) => const TRoundedContainer(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            width: double.infinity,
                            height: 0.5,
                            backgroundColor: PColors.darkGrey,
                          ),
                      itemCount: 15),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
