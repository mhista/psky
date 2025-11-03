import 'package:ahiaa_web/injection_container.config.dart';
import 'package:get_it/get_it.dart';

// ============================================================================
// FILE: lib/core/di/injection.dart
// ============================================================================
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
// import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();

// ============================================================================
// OLD IMPLEMENTATION (Keep for reference/fallback)
// ============================================================================
// void registerDependenciesOld() {
  // // SINGLETON REGISTRATION
  // getIt
  //   ..registerSingleton<ResponsiveUtils>(ResponsiveUtils())
  //   ..registerSingleton<AppRouter>(AppRouter());

  // // FACTORY REGISTRATION
  // getIt
  //   ..registerFactory<AuthPageControllerCubit>(() => AuthPageControllerCubit())
  //   ..registerFactory<LoginCubit>(() => LoginCubit())
  //   ..registerFactory<SignupCubit>(() => SignupCubit())
  //   ..registerFactory<OnBoardingCubit>(() => OnBoardingCubit());
// }
