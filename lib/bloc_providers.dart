import 'package:ahiaa_web/features/authentication/auth_screens/cubit/auth_page_controller_cubit.dart';
import 'package:ahiaa_web/features/authentication/blocs/login/cubit/login_cubit.dart';
import 'package:ahiaa_web/features/authentication/blocs/signup/cubit/signup_cubit.dart';
import 'package:ahiaa_web/features/notifications/presentation/cubit/Notification_cubit.dart';
import 'package:ahiaa_web/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/bloc/bloc/editor_bloc.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ahiaa_web/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders {
  static List<BlocProvider> blocProviders = [
    BlocProvider<AuthPageControllerCubit>(create: (_) => getIt<AuthPageControllerCubit>()),

    BlocProvider<LoginCubit>(create: (_) => getIt<LoginCubit>()),
    BlocProvider<SignupCubit>(create: (_) => getIt<SignupCubit>()),
    BlocProvider<OnBoardingCubit>(create: (_) => getIt<OnBoardingCubit>()),
    BlocProvider<ExamCubit>(create: (_) => getIt<ExamCubit>()),
    BlocProvider<EditorCubit>(create: (_) => getIt<EditorCubit>()),
    BlocProvider<NotificationCubit>(create: (_) => getIt<NotificationCubit>()),
    BlocProvider<SettingsCubit>(create: (_) => getIt<SettingsCubit>()),






  ];}