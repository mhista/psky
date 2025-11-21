
// ============================================================================
// 2. UPDATED APP_ROUTER.DART - With First-Timer Logic
// ============================================================================

import 'dart:async';
import 'package:ahiaa_web/core/cubits/cubit/initialization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

@lazySingleton
class AppRouter {
  late final GoRouter router;
  
  // Storage key for first-timer tracking
  static const String _firstTimerKey = 'is_first_timer';
  static const String _hasSeenLandingKey = 'has_seen_landing';

  AppRouter() {
    router = _buildRouter();
  }

  GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        // Landing - Only for first-timers
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
      redirect: (context, state) async {
        // Check if AuthCubit is registered before trying to access it
        if (!getIt.isRegistered<AuthCubit>()) {
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

        // ✅ NEW: Check if user is first-timer
        final isFirstTimer = await _isFirstTimer();
        final hasSeenLanding = await _hasSeenLanding();

        // ✅ LOGIC: First-timer flow
        if (isGoingToLanding) {
          if (isAuthenticated) {
            // Already authenticated - skip landing
            await _markLandingSeen();
            return '/${KRoutes.dashboard}';
          } else if (!isFirstTimer || hasSeenLanding) {
            // Not a first-timer or already seen landing - go to auth
            return '/${KRoutes.auth}';
          }
          // First-timer who hasn't seen landing - show landing page
          return null;
        }

        // Allow onboarding route
        if (isGoingToOnboarding) {
          if (isAuthenticated) {
            return '/${KRoutes.dashboard}';
          }
          return null;
        }

        // Allow auth route
        if (isGoingToAuth) {
          if (isAuthenticated) {
            return '/${KRoutes.dashboard}';
          }
          return null;
        }

        // Protect private routes
        if (!isAuthenticated) {
          // Not authenticated - check if should show landing or auth
          if (isFirstTimer && !hasSeenLanding) {
            return '/';
          }
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

  // ✅ NEW: Helper methods for first-timer tracking
  Future<bool> _isFirstTimer() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTimer = prefs.getBool(_firstTimerKey) ?? true;
    return isFirstTimer;
  }

  Future<bool> _hasSeenLanding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSeenLandingKey) ?? false;
  }

  Future<void> _markLandingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenLandingKey, true);
    await prefs.setBool(_firstTimerKey, false);
  }

  // ✅ NEW: Call this when user completes landing page actions
  static Future<void> markLandingPageCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenLandingKey, true);
    await prefs.setBool(_firstTimerKey, false);
  }

  // ✅ NEW: Reset first-timer status (useful for testing)
  static Future<void> resetFirstTimerStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_hasSeenLandingKey);
    await prefs.remove(_firstTimerKey);
  }
}

// Safe refresh notifier that only listens if AuthCubit is registered
class _AuthRefreshNotifier extends ChangeNotifier {
  StreamSubscription? _sub;
  
  _AuthRefreshNotifier() {
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
