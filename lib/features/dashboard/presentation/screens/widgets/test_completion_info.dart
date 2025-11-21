import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/exam_result_calculator.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide CircularProgressIndicator;

class TestTracker extends StatefulWidget {
  const TestTracker({super.key, this.isExpanded = false});
  final bool isExpanded;

  @override
  State<TestTracker> createState() => _TestTrackerState();
}

class _TestTrackerState extends State<TestTracker> {
  final examCubit = getIt<ExamCubit>();
  bool _isLoading = true;
  AggregateExamResult? aggregate;

  @override
  void initState() {
    super.initState();
    _loadCompletionRate();
  }

  Future<void> _loadCompletionRate() async {
    final repo = getIt<SubjectRepository>();

    aggregate = examCubit.calculateAggregateResults();

    setState(() {
      _isLoading = false;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return BlocListener<ExamCubit, ExamState>(
      bloc: examCubit,
      listener: (context, state) {
        state.maybeWhen(
          hasData: (_, __, ___, ____) => _loadCompletionRate(),
          completed: (_, __) => _loadCompletionRate(),
          orElse: () {},
        );
      },
      child: TRoundedContainer(
        backgroundColor:responsive.isMobile?PColors.light:PColors.white ,
        padding: const EdgeInsets.all(8),
        height: 128,
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: _isLoading == true
                ? const SizedBox(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(PColors.darkGrey),
                    ),
                  )
                : ResponsiveText(_isLoading == true || aggregate == null || aggregate?.averageCompletionRate == null
                        ? '0%'
                        : '${aggregate?.averageCompletionRate.toStringAsFixed(2)}%')
                    .withSize(28)
                    .bold
                    .withColor(PColors.primary5),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: SizedBox(
                width: 80,
                child: const ResponsiveText('Test Completion Rate')
                    .withSize(8)
                    .withColor(PColors.primary5)),
          ),
          const Gap(1),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Calculate element width and spacing
                final elementWidth = responsive.isMobile? 15.0: widget.isExpanded ? 10.0 : 6.0;
                final spacing = 2.0;
                
                // Calculate how many elements can fit
                final availableWidth = constraints.maxWidth;
                final totalElementCount = ((availableWidth + spacing) / (elementWidth + spacing)).floor();
                
                // Calculate completion rate (0-100)
                final completionRate = _isLoading == true ? 0.0 : (aggregate?.averageCompletionRate ?? 0.0);
                
                // Calculate how many elements should be colored
                final coloredCount = (totalElementCount * (completionRate / 100)).round();
                
                return Row(
                  spacing: spacing,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    totalElementCount,
                    (index) => TRoundedContainer(
                      width: elementWidth,
                      height: 35,
                      radius: 1000,
                      backgroundColor: index < coloredCount
                          ? PColors.primary
                          : responsive.isMobile?PColors.white: PColors.light,
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}