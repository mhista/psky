// ============================================================================
// APP INITIALIZATION SERVICE - WITH LOGGING
// ============================================================================

import 'dart:async';
import 'package:ahiaa_web/core/entities/init_entities.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/exam_notification_service.dart';
import 'package:ahiaa_web/core/services/subject_helper.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/practice_exam/data/datasources/firebase_exam_satasource.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:ahiaa_web/features/practice_exam/domain/repository/exam_repository.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/sync_cubit.dart';
import 'package:injectable/injectable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Orchestrates app initialization and data synchronization
@lazySingleton
class AppInitializationService {
  final ExamRepository _examRepository;
  final ExamNotificationService _notificationService;
  final FirebaseExamDataSource _dataSource;
  final ExamCubit _examCubit;
  final SyncCubit _syncCubit;
  final Connectivity _connectivity;

  AppInitializationService(
    this._examRepository,
    this._notificationService,
    this._dataSource,
    this._examCubit,
    this._syncCubit,
    this._connectivity,
  );

  // ============================================================================
  // INITIALIZATION
  // ============================================================================

  /// Initialize the app - NON-BLOCKING
  Future<InitializationResult> initialize({
    required String userId,
    bool forceSync = false,
  }) async {
    try {
      pskyLog('🚀 Starting app initialization...');

      final startTime = DateTime.now();
      final steps = <InitializationStep>[];

      // CRITICAL PATH (Blocking) - Only essential items
      pskyLog('⏳ Loading critical resources...');

      final localDataStep = await _loadLocalData();
      steps.add(localDataStep);
      _logStep(localDataStep);

      final notificationStep = await _initializeNotifications();
      steps.add(notificationStep);
      _logStep(notificationStep);

      final criticalDuration = DateTime.now().difference(startTime);
      pskyLog(
          '✅ Critical path completed in ${criticalDuration.inMilliseconds}ms');

      // NON-CRITICAL PATH (Background) - Fire and forget
      pskyLog('🔄 Starting background initialization...');
      unawaited(_backgroundInitialization(userId, steps, forceSync));

      final result = InitializationResult(
        success: true,
        duration: criticalDuration,
        steps: steps,
        timestamp: DateTime.now(),
      );

      pskyLog('✨ Initialization complete: ${result.toMap()}');

      return result;
    } catch (e) {
      pskyLog('❌ App initialization failed: $e');
      return InitializationResult(
        success: false,
        duration: Duration.zero,
        steps: [],
        timestamp: DateTime.now(),
        error: e.toString(),
      );
    }
  }

  /// Background initialization - runs after UI is ready
  Future<void> _backgroundInitialization(
    String userId,
    List<InitializationStep> steps,
    bool forceSync,
  ) async {
    try {
      pskyLog('🔄 Background initialization started');

      // Step 1: Check connectivity
      final connectivityStep = await _checkConnectivity();
      steps.add(connectivityStep);
      _logStep(connectivityStep);

      // Step 2: Sync with Firebase (if needed)
      if (connectivityStep.success &&
          connectivityStep.metadata?['connected'] == true &&
          (forceSync || await _shouldSync())) {
        pskyLog('🔄 Firebase sync needed, starting...');
        final syncStep = await _syncWithFirebase(userId);
        steps.add(syncStep);
        _logStep(syncStep);
      } else {
        pskyLog('⏭️  Firebase sync skipped (offline or not needed)');
      }

      // Step 3: Initialize leaderboard
      if (connectivityStep.success) {
        final leaderboardStep = await _initializeLeaderboard(userId);
        steps.add(leaderboardStep);
        _logStep(leaderboardStep);
      }

      // Step 4: Schedule notifications
      final notificationsStep = await _scheduleNotifications(userId);
      steps.add(notificationsStep);
      _logStep(notificationsStep);

      // Step 5: Update user activity
      final activityStep = await _updateUserActivity(userId);
      steps.add(activityStep);
      _logStep(activityStep);

      // Step 6: Fetch AI insights
      final insightsStep = await _fetchAIInsights(userId);
      steps.add(insightsStep);
      _logStep(insightsStep);

      // Step 7: Check for app updates
      final updatesStep = await _checkAppUpdates(userId);
      steps.add(updatesStep);
      _logStep(updatesStep);

      pskyLog('✅ Background initialization completed successfully');
      pskyLog('📊 Total steps completed: ${steps.length}');
      _logSummary(steps);
    } catch (e) {
      pskyLog('❌ Background initialization failed: $e');
    }
  }

  // ============================================================================
  // INITIALIZATION STEPS
  // ============================================================================

  Future<InitializationStep> _checkConnectivity() async {
    try {
      pskyLog('📡 Checking connectivity...');
      final result = await _connectivity.checkConnectivity();
      final isConnected = result != ConnectivityResult.none;

      return InitializationStep(
        name: 'Connectivity Check',
        success: true,
        message: isConnected ? 'Connected' : 'Offline mode',
        metadata: {'connected': isConnected},
      );
    } catch (e) {
      return InitializationStep(
        name: 'Connectivity Check',
        success: false,
        message: 'Failed: $e',
      );
    }
  }

  Future<InitializationStep> _initializeNotifications() async {
    try {
      pskyLog('🔔 Initializing notifications...');
      await _notificationService.initialize();

      return const InitializationStep(
        name: 'Notifications',
        success: true,
        message: 'Notifications initialized',
      );
    } catch (e) {
      return InitializationStep(
        name: 'Notifications',
        success: false,
        message: 'Failed: $e',
      );
    }
  }

  Future<InitializationStep> _loadLocalData() async {
    try {
      pskyLog('💾 Loading local data...');
      getIt<SubjectDataHelper>().loadSubjectsForExamBody(ExamBody.waec);

      await _examCubit.loadFromStorage();

      return const InitializationStep(
        name: 'Local Data',
        success: true,
        message: 'Local data loaded',
      );
    } catch (e) {
      return InitializationStep(
        name: 'Local Data',
        success: false,
        message: 'Failed: $e',
      );
    }
  }

  Future<InitializationStep> _syncWithFirebase(String userId) async {
    try {
      pskyLog('☁️  Syncing with Firebase...');
      final syncStartTime = DateTime.now();

      // Get local sessions
      final currentState = _examCubit.state;
      List<ExamSession> localSessions = [];

      currentState.maybeWhen(
        orElse: () {},
        hasData: (examMode, selectedSubjects, examSessions, currentSession) {
          localSessions = examSessions;
        },
      );

      pskyLog('📦 Local sessions count: ${localSessions.length}');

      // Sync from Firebase
      await _examCubit.syncFromDb(userId);

      // Get updated state
      final updatedState = _examCubit.state;
      int remoteSessions = 0;
      updatedState.maybeWhen(
        orElse: () {},
        hasData: (examMode, selectedSubjects, examSessions, currentSession) {
          remoteSessions = examSessions.length;
        },
      );

      final syncDuration = DateTime.now().difference(syncStartTime);
      pskyLog('☁️  Remote sessions count: $remoteSessions');

      return InitializationStep(
        name: 'Firebase Sync',
        success: true,
        message:
            'Synced $remoteSessions sessions in ${syncDuration.inMilliseconds}ms',
        metadata: {
          'local': localSessions.length,
          'remote': remoteSessions,
          'duration': syncDuration.inMilliseconds,
        },
      );
    } catch (e) {
      return InitializationStep(
        name: 'Firebase Sync',
        success: false,
        message: 'Failed: $e',
      );
    }
  }

  Future<InitializationStep> _initializeLeaderboard(String userId) async {
    try {
      pskyLog('🏆 Initializing leaderboard...');
      // Get user's rank
      final rank = await _examRepository.getUserRank(userId: userId);
      pskyLog(
          '🏆 User rank: #${rank.rank} (${rank.percentile.toStringAsFixed(1)}%)');

      return InitializationStep(
        name: 'Leaderboard',
        success: true,
        message: 'Rank: #${rank.rank}',
        metadata: {
          'rank': rank.rank,
          'percentile': rank.percentile,
        },
      );
    } catch (e) {
      return InitializationStep(
        name: 'Leaderboard',
        success: false,
        message: 'Failed: $e',
      );
    }
  }

  Future<InitializationStep> _scheduleNotifications(String userId) async {
    try {
      pskyLog('⏰ Scheduling notifications...');
      int scheduledCount = 0;

      // 1. Schedule exam session expiry notifications
      final incompleteSessions =
          await _examRepository.getIncompleteSessions(userId);
      pskyLog('📋 Incomplete sessions: ${incompleteSessions.length}');

      for (final session in incompleteSessions) {
        if (session.startedAt != null) {
          final expiryTime = session.startedAt!.add(
            Duration(minutes: session.timeLimitMinutes),
          );

          await _notificationService.scheduleSessionExpiryWarning(
            sessionId: session.examSessionId,
            subjectName: session.subjectId,
            expiryTime: expiryTime,
          );
          scheduledCount++;
        }
      }

      // 2. Schedule daily study reminder (9 AM)
      final tomorrow9AM = DateTime.now().add(const Duration(days: 1)).copyWith(
            hour: 9,
            minute: 0,
            second: 0,
            millisecond: 0,
          );
      await _notificationService.scheduleDailyStudyReminder(
        userId: userId,
        scheduledTime: tomorrow9AM,
      );
      scheduledCount++;

      // 3. Schedule weekly report (Every Sunday 8 PM)
      final nextSunday = _getNextWeekday(DateTime.sunday);
      await _notificationService.scheduleWeeklyReport(
        userId: userId,
        scheduledTime: nextSunday,
      );
      scheduledCount++;

      pskyLog('⏰ Scheduled $scheduledCount notifications');

      return InitializationStep(
        name: 'Notifications Scheduled',
        success: true,
        message: '$scheduledCount notifications scheduled',
      );
    } catch (e) {
      return InitializationStep(
        name: 'Notifications Scheduled',
        success: false,
        message: 'Failed: $e',
      );
    }
  }

  Future<InitializationStep> _fetchAIInsights(String userId) async {
    try {
      pskyLog('🤖 Fetching AI insights...');
      // Fetch AI-generated insights
      final insights = await _notificationService.fetchAndNotifyAIInsights(
        userId: userId,
      );

      pskyLog('🤖 Fetched ${insights.length} AI insights');

      return InitializationStep(
        name: 'AI Insights',
        success: true,
        message: '${insights.length} insights fetched',
        metadata: {'count': insights.length},
      );
    } catch (e) {
      return InitializationStep(
        name: 'AI Insights',
        success: false,
        message: 'Failed: $e',
      );
    }
  }

  Future<InitializationStep> _checkAppUpdates(String userId) async {
    try {
      pskyLog('🔄 Checking for app updates...');
      // Check for app updates and notify if available
      final hasUpdate = await _notificationService.checkAndNotifyAppUpdate(
        userId: userId,
      );

      pskyLog(hasUpdate ? '🆕 Update available!' : '✅ App is up to date');

      return InitializationStep(
        name: 'App Updates',
        success: true,
        message: hasUpdate ? 'Update available' : 'Up to date',
        metadata: {'hasUpdate': hasUpdate},
      );
    } catch (e) {
      return InitializationStep(
        name: 'App Updates',
        success: false,
        message: 'Failed: $e',
      );
    }
  }

  DateTime _getNextWeekday(int weekday) {
    final now = DateTime.now();
    final daysUntil = (weekday - now.weekday + 7) % 7;
    final nextDate = now.add(Duration(days: daysUntil == 0 ? 7 : daysUntil));
    return nextDate.copyWith(hour: 20, minute: 0, second: 0, millisecond: 0);
  }

  Future<InitializationStep> _updateUserActivity(String userId) async {
    try {
      pskyLog('👤 Updating user activity...');
      // Update last active timestamp
      await _dataSource.updateLeaderboardEntry(
        userId: userId,
        entry: LeaderboardEntry(
          userId: userId,
          displayName: '', // This should come from user profile
          overallScore: 0, // This should be calculated
          subjectScores: {},
          totalExamsCompleted: 0,
          totalQuestionsAnswered: 0,
          totalCorrectAnswers: 0,
          lastUpdated: DateTime.now(),
        ),
      );

      return const InitializationStep(
        name: 'User Activity',
        success: true,
        message: 'Activity updated',
      );
    } catch (e) {
      return InitializationStep(
        name: 'User Activity',
        success: false,
        message: 'Failed: $e',
      );
    }
  }

  // ============================================================================
  // HELPERS
  // ============================================================================

  Future<bool> _shouldSync() async {
    try {
      return await _examRepository.needsSync();
    } catch (e) {
      pskyLog('⚠️  Error checking sync status: $e');
      return false;
    }
  }

  /// Log individual step result
  void _logStep(InitializationStep step) {
    final icon = step.success ? '✅' : '❌';
    final skipIcon = step.skipped ? '⏭️ ' : '';

    pskyLog('$skipIcon$icon ${step.name}: ${step.message}');

    if (step.metadata != null && step.metadata!.isNotEmpty) {
      pskyLog('   📊 Metadata: ${step.metadata}');
    }
  }

  /// Log summary of all steps
  void _logSummary(List<InitializationStep> steps) {
    final successful = steps.where((s) => s.success).length;
    final failed = steps.where((s) => !s.success).length;
    final skipped = steps.where((s) => s.skipped).length;

    pskyLog('═══════════════════════════════════════');
    pskyLog('📋 INITIALIZATION SUMMARY');
    pskyLog('═══════════════════════════════════════');
    pskyLog('Total Steps: ${steps.length}');
    pskyLog('✅ Successful: $successful');
    pskyLog('❌ Failed: $failed');
    pskyLog('⏭️  Skipped: $skipped');
    pskyLog('═══════════════════════════════════════');

    // List all steps with their status
    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      final icon = step.success
          ? '✅'
          : step.skipped
              ? '⏭️ '
              : '❌';
      pskyLog('${i + 1}. $icon ${step.name}');
    }
    pskyLog('═══════════════════════════════════════');
  }

  // ============================================================================
  // BACKGROUND SYNC
  // ============================================================================

  /// Setup periodic background sync
  void setupBackgroundSync({
    required String userId,
    Duration interval = const Duration(hours: 1),
  }) {
    pskyLog('🔄 Setting up background sync (every ${interval.inHours} hours)');

    Timer.periodic(interval, (_) async {
      try {
        pskyLog('🔄 Background sync triggered');

        // Check connectivity
        final connectivity = await _connectivity.checkConnectivity();
        if (connectivity.first == ConnectivityResult.none) {
          pskyLog('⚠️  Background sync skipped: No connection');
          return;
        }

        // Check if sync is needed
        if (!await _shouldSync()) {
          pskyLog('⚠️  Background sync skipped: Not needed');
          return;
        }

        // Perform sync
        final currentState = _examCubit.state;

        currentState.maybeWhen(
          orElse: () {},
          hasData:
              (examMode, selectedSubjects, examSessions, currentSession) async {
            pskyLog('🔄 Syncing ${examSessions.length} sessions...');
            await _syncCubit.sync(
              userId: userId,
              sessions: examSessions,
            );
            pskyLog('✅ Background sync completed');
          },
        );
      } catch (e) {
        pskyLog('❌ Background sync failed: $e');
      }
    });
  }

  // ============================================================================
  // OPTIMIZED APP START (NON-BLOCKING)
  // ============================================================================

  /// Quick start - Returns immediately after critical path
  /// All non-essential tasks run in background
  Future<InitializationResult> quickStart({
    required String userId,
  }) async {
    try {
      pskyLog('⚡ Quick start initiated - UI ready immediately...');

      final startTime = DateTime.now();
      final steps = <InitializationStep>[];

      // CRITICAL PATH ONLY (Must complete before showing UI)
      // These are synchronous and fast (<100ms)
      final localDataStep = await _loadLocalData();
      steps.add(localDataStep);
      _logStep(localDataStep);

      final notificationStep = await _initializeNotifications();
      steps.add(notificationStep);
      _logStep(notificationStep);

      final duration = DateTime.now().difference(startTime);
      pskyLog('✅ UI ready in ${duration.inMilliseconds}ms');

      // Start all background tasks WITHOUT awaiting
      pskyLog('🔄 Launching background tasks...');
      unawaited(_backgroundInitialization(userId, steps, false));

      final result = InitializationResult(
        success: true,
        duration: duration,
        steps: steps,
        timestamp: DateTime.now(),
      );

      pskyLog('✨ Quick start complete: ${result.toMap()}');

      return result;
    } catch (e) {
      pskyLog('❌ Quick start failed: $e');
      return InitializationResult(
        success: false,
        duration: Duration.zero,
        steps: [],
        timestamp: DateTime.now(),
        error: e.toString(),
      );
    }
  }
}

// ============================================================================
// EXTENSION FOR INITIALIZATIONRESULT LOGGING
// ============================================================================

extension InitializationResultLogging on InitializationResult {
  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'duration_ms': duration.inMilliseconds,
      'steps_count': steps.length,
      'timestamp': timestamp.toIso8601String(),
      if (error != null) 'error': error,
    };
  }
}
