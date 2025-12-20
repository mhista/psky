import 'package:ahiaa_web/core/cubits/cubit/initialization_cubit.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/auth_page_cubit/auth_page_controller_cubit.dart';
import 'package:ahiaa_web/features/authentication/blocs/signup/cubit/signup_cubit.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/cubit/auth_cubit.dart';
import 'package:ahiaa_web/features/help_and_support/presentation/cubits/help_and_support_cubit.dart';
import 'package:ahiaa_web/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:ahiaa_web/features/notifications/presentation/cubit/notification_page_cubit.dart';
import 'package:ahiaa_web/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/bloc/bloc/editor_bloc.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/ai_cubits/cubit/ai_exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_controller_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_session_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/sync_cubit.dart';
import 'package:ahiaa_web/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders {
  static List<BlocProvider> blocProviders = [
    BlocProvider<AuthCubit>(create: (_) => getIt<AuthCubit>()),
    BlocProvider(create: (_) => getIt<SyncCubit>()),
    BlocProvider(create: (_) => getIt<InitializationCubit>()),
    BlocProvider<AuthPageControllerCubit>(
        create: (_) => getIt<AuthPageControllerCubit>()),
    BlocProvider<SignupCubit>(create: (_) => getIt<SignupCubit>()),
    BlocProvider<OnBoardingCubit>(create: (_) => getIt<OnBoardingCubit>()),
    BlocProvider<ExamControllerCubit>(
        create: (_) => getIt<ExamControllerCubit>()),
    BlocProvider<EditorCubit>(create: (_) => getIt<EditorCubit>()),
    BlocProvider<NotificationPageCubit>(create: (_) => getIt<NotificationPageCubit>()),
    BlocProvider<NotificationCubit>(create: (_) => getIt<NotificationCubit>()),
    BlocProvider<HelpAndSupportCubit>(create: (_) => getIt<HelpAndSupportCubit>()),

    BlocProvider<SettingsCubit>(create: (_) => getIt<SettingsCubit>()),
    BlocProvider<UserCubit>(create: (_) => getIt<UserCubit>()),
    BlocProvider<ExamCubit>(create: (_) => getIt<ExamCubit>()),
    BlocProvider<ExamSessionCubit>(create: (_) => getIt<ExamSessionCubit>()),
    BlocProvider<AiExamCubit>(create: (_) => getIt<AiExamCubit>()),
  ];
}
