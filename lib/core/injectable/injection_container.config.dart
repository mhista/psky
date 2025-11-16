// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i163;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/authentication/blocs/signup/cubit/signup_cubit.dart'
    as _i310;
import '../../features/authentication/data/datasource/auth_remote_datasource.dart'
    as _i739;
import '../../features/authentication/data/repository/auth_repository_impl.dart'
    as _i233;
import '../../features/authentication/domain/repository/auth_repositorey.dart'
    as _i80;
import '../../features/authentication/domain/usecases/get_current_user_usecase.dart'
    as _i455;
import '../../features/authentication/domain/usecases/login_usecase.dart'
    as _i995;
import '../../features/authentication/domain/usecases/logout_usecase.dart'
    as _i1067;
import '../../features/authentication/domain/usecases/send_password_reset_email_usecase.dart'
    as _i416;
import '../../features/authentication/domain/usecases/sign_in_with_google.dart'
    as _i185;
import '../../features/authentication/domain/usecases/signup_usecase.dart'
    as _i712;
import '../../features/authentication/presentation/business/auth_page_cubit/auth_page_controller_cubit.dart'
    as _i639;
import '../../features/authentication/presentation/business/cubit/auth_cubit.dart'
    as _i959;
import '../../features/coach_kai/presentation/business/cubits/chat_cubit.dart'
    as _i218;
import '../../features/notifications/presentation/cubit/notification_cubit.dart'
    as _i459;
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart'
    as _i807;
import '../../features/personalization/presentation/cubit/cubit/user_cubit.dart'
    as _i564;
import '../../features/practice_exam/data/datasources/firebase_exam_satasource.dart'
    as _i116;
import '../../features/practice_exam/domain/repository/exam_repository.dart'
    as _i413;
import '../../features/practice_exam/presentation/bloc/bloc/editor_bloc.dart'
    as _i604;
import '../../features/practice_exam/presentation/cubits/ai_cubits/cubit/ai_exam_cubit.dart'
    as _i293;
import '../../features/practice_exam/presentation/cubits/cubit/exam_controller_cubit.dart'
    as _i626;
import '../../features/practice_exam/presentation/cubits/cubit/exam_cubit.dart'
    as _i926;
import '../../features/practice_exam/presentation/cubits/cubit/exam_session_cubit.dart'
    as _i1065;
import '../../features/practice_exam/presentation/cubits/cubit/sync_cubit.dart'
    as _i367;
import '../../features/settings/presentation/cubit/settings_cubit.dart'
    as _i792;
import '../cubits/cubit/initialization_cubit.dart' as _i653;
import '../routes/app_router2.dart' as _i769;
import '../services/achievement_score.dart' as _i478;
import '../services/app_init.dart' as _i464;
import '../services/cache_manager.dart' as _i802;
import '../services/exam_notification_service.dart' as _i696;
import '../services/gemini_chat_service.dart' as _i239;
import '../services/leaderboard_calculator.dart' as _i458;
import '../services/offline_queue.dart' as _i403;
import '../services/streak_service.dart' as _i519;
import '../services/subject_helper.dart' as _i172;
import '../services/subject_service.dart' as _i477;
import '../utils/helpers/responsive_utils.dart' as _i730;
import 'firebase_injection_module.dart' as _i786;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseInjectableModuleSimple = _$FirebaseInjectableModuleSimple();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => firebaseInjectableModuleSimple.prefs,
      preResolve: true,
    );
    gh.factory<_i310.SignupCubit>(() => _i310.SignupCubit());
    gh.factory<_i639.AuthPageControllerCubit>(
        () => _i639.AuthPageControllerCubit());
    gh.factory<_i807.OnBoardingCubit>(() => _i807.OnBoardingCubit());
    gh.factory<_i604.EditorCubit>(() => _i604.EditorCubit());
    gh.factory<_i792.SettingsCubit>(() => _i792.SettingsCubit());
    gh.singleton<_i730.ResponsiveUtils>(() => _i730.ResponsiveUtils());
    gh.singleton<_i459.NotificationCubit>(() => _i459.NotificationCubit());
    gh.lazySingleton<_i59.FirebaseAuth>(
        () => firebaseInjectableModuleSimple.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => firebaseInjectableModuleSimple.firestore);
    gh.lazySingleton<_i116.GoogleSignIn>(
        () => firebaseInjectableModuleSimple.googleSignIn);
    gh.lazySingleton<_i892.FirebaseMessaging>(
        () => firebaseInjectableModuleSimple.messaging);
    gh.lazySingleton<_i163.FlutterLocalNotificationsPlugin>(
        () => firebaseInjectableModuleSimple.localNotifications);
    gh.lazySingleton<_i895.Connectivity>(
        () => firebaseInjectableModuleSimple.connectivity);
    gh.lazySingleton<_i769.AppRouter>(() => _i769.AppRouter());
    gh.lazySingleton<_i802.ExamCacheManager>(() => _i802.ExamCacheManager());
    gh.lazySingleton<_i239.GeminiChatService>(() => _i239.GeminiChatService());
    gh.lazySingleton<_i172.SubjectDataHelper>(() => _i172.SubjectDataHelper());
    gh.lazySingleton<_i477.SubjectRepository>(() => _i477.SubjectRepository());
    gh.lazySingleton<_i218.ChatCubit>(() => _i218.ChatCubit());
    gh.lazySingleton<_i564.UserCubit>(() => _i564.UserCubit());
    gh.lazySingleton<_i626.ExamControllerCubit>(
        () => _i626.ExamControllerCubit());
    gh.lazySingleton<_i926.ExamCubit>(() => _i926.ExamCubit(
          gh<_i974.FirebaseFirestore>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.lazySingleton<_i519.StreakService>(() => _i519.StreakService(
          gh<_i974.FirebaseFirestore>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.lazySingleton<_i696.ExamNotificationService>(
        () => _i696.ExamNotificationService(
              gh<_i974.FirebaseFirestore>(),
              gh<_i892.FirebaseMessaging>(),
              gh<_i163.FlutterLocalNotificationsPlugin>(),
              gh<_i460.SharedPreferences>(),
            ));
    gh.lazySingleton<_i478.AchievementService>(() => _i478.AchievementService(
          gh<_i974.FirebaseFirestore>(),
          gh<_i696.ExamNotificationService>(),
        ));
    gh.lazySingleton<_i116.FirebaseExamDataSource>(
        () => _i116.FirebaseExamDataSource(
              gh<_i974.FirebaseFirestore>(),
              gh<_i460.SharedPreferences>(),
              gh<_i802.ExamCacheManager>(),
            ));
    gh.lazySingleton<_i403.OfflineQueueManager>(() => _i403.OfflineQueueManager(
          gh<_i460.SharedPreferences>(),
          gh<_i116.FirebaseExamDataSource>(),
          gh<_i895.Connectivity>(),
        ));
    gh.lazySingleton<_i413.ExamRepository>(() => _i413.ExamRepository(
          gh<_i116.FirebaseExamDataSource>(),
          gh<_i802.ExamCacheManager>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.lazySingleton<_i739.AuthRemoteDataSource>(
        () => _i739.AuthRemoteDataSourceFirebaseImp(
              firebaseAuth: gh<_i59.FirebaseAuth>(),
              firestore: gh<_i974.FirebaseFirestore>(),
            ));
    gh.lazySingleton<_i80.AuthRepository>(() => _i233.AuthRepositoryImpl(
        remoteDataSource: gh<_i739.AuthRemoteDataSource>()));
    gh.lazySingleton<_i1065.ExamSessionCubit>(
        () => _i1065.ExamSessionCubit(gh<_i926.ExamCubit>()));
    gh.lazySingleton<_i367.SyncCubit>(() => _i367.SyncCubit(
          gh<_i413.ExamRepository>(),
          gh<_i116.FirebaseExamDataSource>(),
        ));
    gh.lazySingleton<_i455.GetCurrentUserUseCase>(() =>
        _i455.GetCurrentUserUseCase(repository: gh<_i80.AuthRepository>()));
    gh.lazySingleton<_i995.LoginUseCase>(
        () => _i995.LoginUseCase(repository: gh<_i80.AuthRepository>()));
    gh.lazySingleton<_i1067.LogoutUseCase>(
        () => _i1067.LogoutUseCase(repository: gh<_i80.AuthRepository>()));
    gh.lazySingleton<_i416.SendPasswordResetEmailUseCase>(() =>
        _i416.SendPasswordResetEmailUseCase(
            repository: gh<_i80.AuthRepository>()));
    gh.lazySingleton<_i712.SignUpUseCase>(
        () => _i712.SignUpUseCase(repository: gh<_i80.AuthRepository>()));
    gh.lazySingleton<_i185.SignInWithGoogleUseCase>(() =>
        _i185.SignInWithGoogleUseCase(repository: gh<_i80.AuthRepository>()));
    gh.lazySingleton<_i458.LeaderboardCalculator>(
        () => _i458.LeaderboardCalculator(
              gh<_i116.FirebaseExamDataSource>(),
              gh<_i413.ExamRepository>(),
            ));
    gh.lazySingleton<_i293.AiExamCubit>(() => _i293.AiExamCubit(
          gh<_i926.ExamCubit>(),
          gh<_i1065.ExamSessionCubit>(),
        ));
    gh.lazySingleton<_i403.AnalyticsExportService>(
        () => _i403.AnalyticsExportService(gh<_i413.ExamRepository>()));
    gh.lazySingleton<_i464.AppInitializationService>(
        () => _i464.AppInitializationService(
              gh<_i413.ExamRepository>(),
              gh<_i696.ExamNotificationService>(),
              gh<_i116.FirebaseExamDataSource>(),
              gh<_i926.ExamCubit>(),
              gh<_i367.SyncCubit>(),
              gh<_i895.Connectivity>(),
            ));
    gh.lazySingleton<_i959.AuthCubit>(() => _i959.AuthCubit(
          signUpUseCase: gh<_i712.SignUpUseCase>(),
          loginUseCase: gh<_i995.LoginUseCase>(),
          getCurrentUserUseCase: gh<_i455.GetCurrentUserUseCase>(),
          signInWithGoogleUseCase: gh<_i185.SignInWithGoogleUseCase>(),
          logoutUseCase: gh<_i1067.LogoutUseCase>(),
          sendPasswordResetEmailUseCase:
              gh<_i416.SendPasswordResetEmailUseCase>(),
          firebaseAuth: gh<_i59.FirebaseAuth>(),
        ));
    gh.lazySingleton<_i653.InitializationCubit>(
        () => _i653.InitializationCubit(gh<_i464.AppInitializationService>()));
    return this;
  }
}

class _$FirebaseInjectableModuleSimple
    extends _i786.FirebaseInjectableModuleSimple {}
