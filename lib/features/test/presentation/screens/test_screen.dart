import 'package:ahiaa_web/core/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/desktop/dashboard_desktop.dart';
import 'package:ahiaa_web/features/onboarding/presentation/screens/desktop/desktop_screen.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/test/presentation/screens/desktop/desktop_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreenScreen extends StatelessWidget {
  const TestScreenScreen({super.key});

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
          initial: () => (loaderState: LoaderState.loading,),
          loading: () => (loaderState: LoaderState.loading,),
        );


         // Derive shimmer states from BLoC state
        final isLoading = stateData.loaderState == LoaderState.loading;
        final hasError = stateData.loaderState == LoaderState.error;
        final hasData = stateData.loaderState == LoaderState.done;
        return  SiteTemplate2(
          useLayout: true,
          desktop: DesktopTestScreen(
            hasData: hasData,
            isLoading: isLoading,
            hasError: hasError,
          ),
        );
      },
    );
  }
}
