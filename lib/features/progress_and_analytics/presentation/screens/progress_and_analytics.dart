import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/progress_and_analytics/presentation/screens/desktop/progress_analytics_desktop.dart';
import 'package:ahiaa_web/features/progress_and_analytics/presentation/screens/mobile/progress_analytics_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressAnalyticsPage extends StatelessWidget {
  const ProgressAnalyticsPage({
    super.key,
    this.isLoading = false,
    this.hasError = false,
    this.expand = false,
    this.isFirstTime = false,
    this.hasData = false,
  });

  final bool isLoading, hasError, hasData, expand, isFirstTime;

  @override
  Widget build(BuildContext context) {
    final examCubit = getIt<ExamCubit>();

    return BlocBuilder<ExamCubit, ExamState>(
      bloc: examCubit,
      builder: (context, state) {
        final stateData = state.maybeWhen(
          orElse: () {
            examCubit.loadFromStorage().then((v) {
              // examCubit.syncFromDb(getIt<UserEntity>().id);
            });
            return (loaderState: LoaderState.loading,);
          },
          hasData: (_, __, ___, ____) => (loaderState: LoaderState.done,),
          initial: () => (loaderState: LoaderState.Initial,),
          loading: () => (loaderState: LoaderState.loading,),
        );

        // Derive shimmer states from BLoC state
        final isLoading = stateData.loaderState == LoaderState.loading;
        final hasError = stateData.loaderState == LoaderState.error;
        final hasData = stateData.loaderState == LoaderState.done;
        final isFirstTime = stateData.loaderState == LoaderState.Initial;

        return SiteTemplate2(
          useLayout: true,
          desktop: ProgressAnalyticsDesktop(
              isLoading: isLoading,
              hasError: hasError,
              hasData: hasData,
              isFirstTime: isFirstTime),
          mobile: ProgressAnalyticsMobile(
              isLoading: isLoading,
              hasError: hasError,
              hasData: hasData,
              isFirstTime: isFirstTime),
        );
      },
    );
  }
}
