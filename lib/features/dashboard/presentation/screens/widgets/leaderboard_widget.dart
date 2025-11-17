import 'package:ahiaa_web/core/common/widgets/buttons/dropdown_buttons.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/progress/animated_linear_progress.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
  List<LeaderboardEntry>? _leaderBoard;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _getLeaderBoardData();
  }

  Future<void> _getLeaderBoardData() async {
    _leaderBoard = await examCubit.getLeaderboardEntries();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return BlocListener<ExamCubit, ExamState>(
      bloc: examCubit,
      listener: (context, state) {
        (context, state) {
          // Refresh streak data when exam is completed
          state.maybeWhen(
            hasData: (_, __, ___, ____) => _getLeaderBoardData(),
            completed: (_, __) => _getLeaderBoardData(),
            orElse: () {},
          );
        };
      },
      child: ThreeToOneShimmer(
        isLoading: _isLoading,
        hasError: widget.hasError,
        hasData: (_leaderBoard ?? []).isNotEmpty,
        radius: 16,
        height: 478,
        errorColor: PColors.tertiary.withValues(alpha: 0.4),
        errorText: 'Leaderboard unavailable, Please check back soon',
        width:!responsive.isDesktop?double.infinity: widget.expand ? 366 : 280,
        loadedWidget: TRoundedContainer(
          backgroundColor: PColors.light,
          width:!responsive.isDesktop?double.infinity: widget.expand ? 366 : 280,
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
              if ((_leaderBoard ?? []).isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: const ResponsiveText('No leaderboard data yet')
                        .withSize(10),
                  ),
                ),
              if ((_leaderBoard ?? []).isNotEmpty)
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final leader = _leaderBoard![index];
                        final sessions = (leader.metadata?['session'] as List)
                            .map((q) =>
                                ExamSession.fromJson(q as Map<String, dynamic>))
                            .toList();
                        final aggregates =
                            examCubit.calculateAggregateWithParams(sessions);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          spacing: 12,
                          children: [
                            const UserAvater(
                              size: 24,
                              useAddButton: false,
                              isExtended: false,
                            ),
                            ResponsiveText(leader.displayName).withSize(9),
                            LinearGradeProgress(
                              currentGrade:
                                  leader.totalCorrectAnswers.toDouble(),
                              totalGrade:
                                  leader.totalQuestionsAnswered.toDouble(),
                              height: 4,
                              width: 101,
                              segments: [
                                GradeSegment(value: 8, color: PColors.primary),
                              ],
                            ),
                            ResponsiveText(
                                    "${aggregates?.averageCompletionRate}%")
                                .withSize(9),
                          ],
                        );
                      },
                      separatorBuilder: (context, _) => const TRoundedContainer(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            width: double.infinity,
                            height: 0.5,
                            backgroundColor: PColors.darkGrey,
                          ),
                      itemCount: _leaderBoard!.length),
                )
            ],
          ),
        ),
      ),
    );
  }
}
