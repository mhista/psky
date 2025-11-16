// core/routes/app_router.dart
import 'dart:async';
import 'package:ahiaa_web/core/cubits/cubit/initialization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/cubit/auth_cubit.dart';
import 'package:ahiaa_web/features/authentication/presentation/auth_screens/auth_screen.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/dashboard.dart';
import 'package:ahiaa_web/features/landing/screen/landing_page.dart';
import 'package:ahiaa_web/features/notifications/presentation/screens/notifications.dart';
import 'package:ahiaa_web/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/desktop/screens/exam_instructions.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/desktop/screens/main_exam_page.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/desktop/screens/results_screen.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/main_exam_screen.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/practice_exams.dart';
import 'package:ahiaa_web/features/progress_and_analytics/presentation/screens/progress_and_analytics.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/settings.dart';
import 'package:ahiaa_web/features/subscriptions/presentation/screens/subscriptions.dart';
import 'package:ahiaa_web/features/test/presentation/screens/test_screen.dart';
import 'package:ahiaa_web/features/help_and_support/presentation/screens/help_and_support.dart';

@lazySingleton  // Changed from @singleton to @lazySingleton
class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = _buildRouter();
  }

  GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        // Landing
        GoRoute(
          path: '/',
          name: KRoutes.landing,
          builder: (context, state) => const LandingPage(),
        ),
        GoRoute(
          path: '/${KRoutes.onboarding}',
          name: KRoutes.onboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/${KRoutes.auth}',
          name: KRoutes.auth,
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: '/${KRoutes.result}',
          name: KRoutes.result,
          builder: (context, state) => const ResultScreen(),
        ),
        GoRoute(
          path: '/${KRoutes.analytics}',
          name: KRoutes.analytics,
          builder: (context, state) => const ProgressAnalyticsPage(),
        ),
        GoRoute(
          path: '/${KRoutes.dashboard}',
          name: KRoutes.dashboard,
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/${KRoutes.myTests}',
          name: KRoutes.myTests,
          builder: (context, state) => const TestScreenScreen(),
        ),
        GoRoute(
          path: '/${KRoutes.practiceExam}',
          name: KRoutes.practiceExam,
          builder: (context, state) => const PracticeScreen(),
        ),
        GoRoute(
          path: '/${KRoutes.examInstruct}',
          name: KRoutes.examInstruct,
          builder: (context, state) => const ExamInstructionsScreen(),
        ),
        GoRoute(
          path: '/${KRoutes.mainExamScreen}',
          name: KRoutes.mainExamScreen,
          builder: (context, state) => const MainExamScreen(),
        ),
        GoRoute(
          path: '/${KRoutes.subscriptions}',
          name: KRoutes.subscriptions,
          builder: (context, state) => const SubscriptionPage(),
        ),
        GoRoute(
          path: '/${KRoutes.notifications}',
          name: KRoutes.notifications,
          builder: (context, state) => const NotificationPage(),
        ),
        GoRoute(
          path: '/${KRoutes.settings}',
          name: KRoutes.settings,
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: '/${KRoutes.help}',
          name: KRoutes.help,
          builder: (context, state) => const HelpAndSupport(),
        ),
        GoRoute(
          path: '/loading',
          name: 'loading',
          builder: (context, state) => const Center(child: CircularProgressIndicator()),
        ),
      ],
      redirect: (context, state) {
        // Check if AuthCubit is registered before trying to access it
        if (!getIt.isRegistered<AuthCubit>()) {
          // Allow navigation during initialization
          return null;
        }

        final authCubit = getIt<AuthCubit>();
        final authState = authCubit.state;

        final isAuthenticated = authState.maybeWhen(
          authenticated: (_) => true,
          orElse: () => false,
        );

        final isGoingToAuth = state.matchedLocation == '/${KRoutes.auth}';
        final isGoingToOnboarding = state.matchedLocation == '/${KRoutes.onboarding}';
        final isGoingToLanding = state.matchedLocation == '/';

        // Allow public routes
        if (isGoingToLanding || isGoingToOnboarding || isGoingToAuth) {
          if (isAuthenticated && !isGoingToAuth) {
            
            return '/${KRoutes.dashboard}';
          }
          return null;
        }

        // Protect private routes
        if (!isAuthenticated && !isGoingToAuth) {
          return '/${KRoutes.auth}';
        }

        return null;
      },
      refreshListenable: _AuthRefreshNotifier(),
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Page not found: ${state.uri}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Safe refresh notifier that only listens if AuthCubit is registered
class _AuthRefreshNotifier extends ChangeNotifier {
  StreamSubscription? _sub;
  
  _AuthRefreshNotifier() {
    // Delay the subscription to ensure AuthCubit is registered
    Future.microtask(() {
      if (getIt.isRegistered<AuthCubit>()) {
        _sub = getIt<AuthCubit>().stream.listen((_) => notifyListeners());
      }
    });
  }
  
  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

// Keep this class for backward compatibility if needed elsewhere
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _sub;
  GoRouterRefreshStream(Stream stream) {
    _sub = stream.listen((_) => notifyListeners());
  }
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}