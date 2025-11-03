import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/features/authentication/auth_screens/auth_screen.dart';
import 'package:ahiaa_web/features/authentication/repository/auth_repo.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/dashboard.dart';
import 'package:ahiaa_web/features/help_and_support/presentation/screens/help_and_support.dart';
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
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

// Import your page files here!
// NOTE: I'm using placeholder names for the new pages. You must create these files.
// import '../features/auth/screen/login_page.dart';
// import '../features/auth/screen/register_page.dart';
// import '../features/auth/screen/forgot_password_page.dart';
// import '../features/main/screen/home_page.dart';
// import '../features/main/screen/my_tests_page.dart';
// import '../features/main/screen/practice_exam_page.dart';
// import '../features/main/screen/progress_analytics_page.dart';
// import '../features/main/screen/subscriptions_page.dart';
// import '../features/main/screen/notifications_page.dart';
// import '../features/main/screen/settings_page.dart';
// import '../features/main/screen/help_page.dart';

// ---------------------------------------------------------------------------------

@singleton
class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = _buildRouter();
  }

  GoRouter _buildRouter() {
    return GoRouter(
      // The initial location is set to the Landing Page.
      initialLocation: '/',
      routes: [
        // 1. Landing Page (The initial route)
        GoRoute(
          path: '/',
          name: KRoutes.landing,
          builder: (context, state) => const LandingPage(),
        ),

        // 2. Authentication Routes
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

        // GoRoute(
        //   path: '/register',
        //   name: 'register',
        //   builder: (context, state) => const RegisterPage(),
        // ),
        // GoRoute(
        //   path: '/forgot-password',
        //   name: 'forgot_password',
        //   builder: (context, state) => const ForgotPasswordPage(),
        // ),

        // 3. Main App Routes (Sidebar Items)
        // I've kept them as simple GoRoutes for now. For a real app,
        // you might use a ShellRoute if the sidebar is persistent.
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
        // GoRoute(
        //   path: '/analytics',
        //   name: 'analytics',
        //   builder: (context, state) => const ProgressAnalyticsPage(),
        // ),
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

        // The /loading route from your original code
        GoRoute(
          path: '/loading',
          name: 'loading',
          builder: (context, state) => const Placeholder(),
        ),
      ],
      // Error Page Builder (remains the same)
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Page not found: ${state.matchedLocation}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
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
