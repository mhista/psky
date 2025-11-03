// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/routes/app_router2.dart' as _i377;
import 'core/services/subject_helper.dart' as _i160;
import 'core/services/subject_service.dart' as _i874;
import 'core/utils/helpers/responsive_utils.dart' as _i731;
import 'features/authentication/auth_screens/cubit/auth_page_controller_cubit.dart'
    as _i91;
import 'features/authentication/blocs/login/cubit/login_cubit.dart' as _i118;
import 'features/authentication/blocs/signup/cubit/signup_cubit.dart' as _i816;
import 'features/notifications/presentation/cubit/notification_cubit.dart'
    as _i76;
import 'features/onboarding/presentation/cubit/onboarding_cubit.dart' as _i133;
import 'features/practice_exam/presentation/bloc/bloc/editor_bloc.dart'
    as _i473;
import 'features/practice_exam/presentation/cubits/cubit/exam_cubit.dart'
    as _i222;
import 'features/settings/presentation/cubit/settings_cubit.dart' as _i837;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i874.SubjectRepository>(() => _i874.SubjectRepository());
    gh.factory<_i91.AuthPageControllerCubit>(
        () => _i91.AuthPageControllerCubit());
    gh.factory<_i118.LoginCubit>(() => _i118.LoginCubit());
    gh.factory<_i816.SignupCubit>(() => _i816.SignupCubit());
    gh.factory<_i133.OnBoardingCubit>(() => _i133.OnBoardingCubit());
    gh.factory<_i473.EditorCubit>(() => _i473.EditorCubit());
    gh.factory<_i222.ExamCubit>(() => _i222.ExamCubit());
    gh.factory<_i837.SettingsCubit>(() => _i837.SettingsCubit());
    gh.singleton<_i377.AppRouter>(() => _i377.AppRouter());
    gh.singleton<_i731.ResponsiveUtils>(() => _i731.ResponsiveUtils());
    gh.singleton<_i76.NotificationCubit>(() => _i76.NotificationCubit());
    gh.lazySingleton<_i160.SubjectDataHelper>(() => _i160.SubjectDataHelper());
    return this;
  }
}
