import 'package:ahiaa_web/core/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/cubits/cubit/initialization_cubit.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/desktop/dashboard_desktop.dart';
import 'package:ahiaa_web/features/onboarding/presentation/screens/desktop/desktop_screen.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getIt<UserCubit>().user ?? UserEntity.empty();
    final hasData = user != UserEntity.empty();
    return BlocBuilder<InitializationCubit, InitializationState>(
      bloc: getIt<InitializationCubit>(),
      builder: (context, state) {
        final stateData = state.maybeWhen(
          orElse: () => (loaderState: LoaderState.error,),
          initialized: (_) => (loaderState: LoaderState.done,),
          initial: () => (loaderState: LoaderState.loading,),
          initializing: () => (loaderState: LoaderState.loading,),
        );

        // Derive shimmer states from BLoC state
        final isLoading = stateData.loaderState == LoaderState.loading;
        final hasError = stateData.loaderState == LoaderState.error;
        final hasData = stateData.loaderState == LoaderState.done;
        return SiteTemplate2(
          useLayout: true,
          desktop: DashboardDesktop(
            hasData: hasData,
            isLoading: isLoading,
            hasError: hasError,
          ),
        );
      },
    );
  }
}
