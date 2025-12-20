// ============================================================================
// APP INITIALIZATION SERVICE - FIXED WITH COMPLETE NOTIFICATION INTEGRATION
// ============================================================================

import 'dart:async';
import 'package:ahiaa_web/core/entities/init_entities.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/exam_notification_service.dart';
import 'package:ahiaa_web/core/services/subject_helper.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/local_storage/storage_utility.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/data/datasources/firebase_exam_satasource.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:ahiaa_web/features/practice_exam/domain/repository/exam_repository.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/sync_cubit.dart';
import 'package:injectable/injectable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Orchestrates app initialization and data synchronization
@lazySingleton
class AppInitializationService {
  final ExamRepository _examRepository;
  final ExamNotificationService _notificationService;
  final FirebaseExamDataSource _dataSource;
  final ExamCubit _examCubit;
  final SyncCubit _syncCubit;
  final Connectivity _connectivity;
  final LocalStorageService _storage;
  final SharedPreferences _prefs;

  // Track initialization state
  bool _isInitialized = false;
  Timer? _backgroundSyncTimer;

  AppInitializationService(
    this._examRepository,
    this._notificationService,
    this._dataSource,
    this._examCubit,
    this._syncCubit,
    this._connectivity,
    this._storage,
    this._prefs,
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

      // STEP 0: Initialize user-specific storage
      final storageInitStep = await _initializeUserStorage(userId);
      steps.add(storageInitStep);
      _logStep(storageInitStep);

      // CRITICAL PATH (Blocking) - Only essential items
      pskyLog('⏳ Loading critical resources...');

      final localDataStep = await _loadLocalData(userId);
      steps.add(localDataStep);
      _logStep(localDataStep);

      final notificationStep = await _initializeNotifications(userId);
      steps.add(notificationStep);
      _logStep(notificationStep);

      final criticalDuration = DateTime.now().difference(startTime);
      pskyLog('✅ Critical path completed in ${criticalDuration.inMilliseconds}ms');

      // Mark as initialized
      _isInitialized = true;

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

  // ============================================================================
  // USER STORAGE INITIALIZATION
  // ============================================================================

  Future<InitializationStep> _initializeUserStorage(String userId) async {
    try {
      pskyLog('💾 Initializing user storage for: $userId');

      // Set user in storage service
      await _storage.setUser(userId);

      // Check if migration is needed
      final needsMigration = await _checkMigrationNeeded(userId);

      if (needsMigration) {
        pskyLog('🔄 Migration needed, starting...');
        await _migrateUserData(userId);
        pskyLog('✅ Migration completed');
      }

      return InitializationStep(
        name: 'User Storage',
        success: true,
        message: needsMigration
            ? 'Storage initialized (migrated from SharedPrefs)'
            : 'Storage initialized',
        metadata: {'migrated': needsMigration},
      );
    } catch (e) {
      return InitializationStep(
        name: 'User Storage',
        success: false,
        message: 'Failed: $e',
      );
    }
  }

  /// Check if migration from SharedPreferences to Hive is needed
  Future<bool> _checkMigrationNeeded(String userId) async {
    try {
      // Check if old SharedPreferences data exists
      final hasOldData = _prefs.containsKey('exam_sessions');

      // Check if new Hive data exists
      final hasNewData = _storage.hasUserData(StorageKeys.examSessions);

      // Migration needed if old data exists but new data doesn't
      return hasOldData && !hasNewData;
    } catch (e) {
      pskyLog('⚠️  Error checking migration: $e');
      return false;
    }
  }

  /// Migrate data from SharedPreferences to Hive
  Future<void> _migrateUserData(String userId) async {
    try {
      pskyLog('📦 Migrating user data...');

      // Migrate exam sessions
      final oldSessionsJson = _prefs.getString('exam_sessions');
      if (oldSessionsJson != null) {
        await _storage.saveUserData(
          StorageKeys.examSessions,
          oldSessionsJson,
        );
        pskyLog('✅ Migrated exam sessions');
      }

      // Migrate streak data
      final oldStreakData = _prefs.getString('user_streak_data');
      if (oldStreakData != null) {
        await _storage.saveUserData(
          StorageKeys.streakData,
          oldStreakData,
        );
        pskyLog('✅ Migrated streak data');
      }

      // Migrate last sync time
      final oldLastSync = _prefs.getInt('last_firebase_sync');
      if (oldLastSync != null) {
        await _storage.saveUserData(
          StorageKeys.lastSync,
          oldLastSync,
        );
        pskyLog('✅ Migrated sync timestamp');
      }

      // Clear old data from SharedPreferences
      await _prefs.remove('exam_sessions');
      await _prefs.remove('user_streak_data');
      await _prefs.remove('last_firebase_sync');

      pskyLog('✅ Migration completed, old data cleared');
    } catch (e) {
      pskyLog('❌ Migration failed: $e');
      rethrow;
    }
  }

  // ============================================================================
  // BACKGROUND INITIALIZATION
  // ============================================================================

  /// Background initialization - runs after UI is ready
  Future<void> _backgroundInitialization(
    String userId,
    List<InitializationStep> steps,
    bool forceSync,
  ) async {
    try {
      pskyLog('🔄 Background initialization started');

      // Step 1: Check connectivity
      final connectivityStep = await checkConnectivity();
      steps.add(connectivityStep);
      _logStep(connectivityStep);

      final isConnected = connectivityStep.metadata?['connected'] == true;

      // Step 2: Sync with Firebase (if needed)
      if (isConnected && (forceSync || await _shouldSync())) {
        pskyLog('🔄 Firebase sync needed, starting...');
        final syncStep = await _syncWithFirebase(userId);
        steps.add(syncStep);
        _logStep(syncStep);
      } else {
        pskyLog('⏭️  Firebase sync skipped (offline or not needed)');
      }

      // Step 3: Initialize leaderboard
      if (isConnected) {
        final leaderboardStep = await _initializeLeaderboard(userId);
        steps.add(leaderboardStep);
        _logStep(leaderboardStep);
      }

      // Step 4: Schedule notifications
      final notificationsStep = await _scheduleNotifications(userId);
      steps.add(notificationsStep);
      _logStep(notificationsStep);

      // Step 5: Update user activity
      if (isConnected) {
        final activityStep = await _updateUserActivity(userId);
        steps.add(activityStep);
        _logStep(activityStep);
      }

      // Step 6: Fetch AI insights
      if (isConnected) {
        final insightsStep = await _fetchAIInsights(userId);
        steps.add(insightsStep);
        _logStep(insightsStep);
      }

      // Step 7: Check for app updates
      if (isConnected) {
        final updatesStep = await _checkAppUpdates(userId);
        steps.add(updatesStep);
        _logStep(updatesStep);
      }

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

  Future<InitializationStep> checkConnectivity() async {
    try {
      pskyLog('📡 Checking connectivity...');
      final results = await _connectivity.checkConnectivity();
      final isConnected = !results.contains(ConnectivityResult.none);

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

  Future<InitializationStep> _initializeNotifications(String userId) async {
    try {
      pskyLog('🔔 Initializing notifications...');
      
      // Initialize notification service
      await _notificationService.initialize();
      getIt<NotificationCubit>().initialize(userId);

      // Subscribe to user-specific topics
      await _notificationService.subscribeToTopic('user_$userId');
      await _notificationService.subscribeToTopic('all_users');

      // On web, request permission explicitly
      if (kIsWeb) {
        final hasPermission = await _notificationService.getFCMToken() != null;
        pskyLog(hasPermission 
            ? '✅ Web notification permission granted'
            : '⚠️  Web notification permission denied');
      }

      return const InitializationStep(
        name: 'Notifications',
        success: true,
        message: 'Notifications initialized',
      );
    } catch (e) {
      pskyLog('⚠️  Notification initialization failed: $e');
      return InitializationStep(
        name: 'Notifications',
        success: false,
        message: 'Failed: $e',
      );
    }
  }

  Future<InitializationStep> _loadLocalData(String userId) async {
    try {
      pskyLog('💾 Loading local data for user: $userId');

      // Load subjects (global data)
      getIt<SubjectDataHelper>().loadSubjectsForExamBody(ExamBody.waec);

      // Initialize ExamCubit for this user
      await _examCubit.initializeForUser(userId);

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

      // Get local sessions count
      final currentState = _examCubit.state;
      int localCount = 0;

      currentState.maybeWhen(
        orElse: () {},
        hasData: (examMode, selectedSubjects, examSessions, currentSession) {
          localCount = examSessions.length;
        },
      );

      pskyLog('📦 Local sessions count: $localCount');

      // Smart sync: Only pull if needed
      final shouldPull = await _shouldPullFromFirebase(userId);

      if (shouldPull) {
        pskyLog('🔽 Pulling from Firebase...');
        await _examCubit.syncFromDb(userId, forcePull: true);
      } else {
        pskyLog('⏭️  Skipping Firebase pull (not needed)');
      }

      // Get updated state
      final updatedState = _examCubit.state;
      int finalCount = 0;

      updatedState.maybeWhen(
        orElse: () {},
        hasData: (examMode, selectedSubjects, examSessions, currentSession) {
          finalCount = examSessions.length;
        },
      );

      final syncDuration = DateTime.now().difference(syncStartTime);
      pskyLog('☁️  Final sessions count: $finalCount');

      // Update last sync timestamp
      await _storage.saveUserData(
        StorageKeys.lastSync,
        DateTime.now().millisecondsSinceEpoch,
      );

      return InitializationStep(
        name: 'Firebase Sync',
        success: true,
        message: shouldPull
            ? 'Synced $finalCount sessions in ${syncDuration.inMilliseconds}ms'
            : 'Skipped (not needed)',
        metadata: {
          'local': localCount,
          'final': finalCount,
          'duration': syncDuration.inMilliseconds,
          'pulled': shouldPull,
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

  /// Smart check: Should we pull from Firebase?
  Future<bool> _shouldPullFromFirebase(String userId) async {
    try {
      // Check last sync time
      final lastSync = _storage.getUserData<int>(StorageKeys.lastSync);

      if (lastSync == null) {
        pskyLog('🔍 No last sync time, pulling from Firebase');
        return true;
      }

      final lastSyncTime = DateTime.fromMillisecondsSinceEpoch(lastSync);
      final timeSinceSync = DateTime.now().difference(lastSyncTime);

      // Pull if last sync was more than 1 hour ago
      if (timeSinceSync.inHours >= 1) {
        pskyLog('🔍 Last sync was ${timeSinceSync.inHours} hours ago, pulling');
        return true;
      }

      // Check if there are incomplete sessions that might have been updated elsewhere
      final incompleteSessions =
          await _examRepository.getIncompleteSessions(userId);
      if (incompleteSessions.isNotEmpty) {
        pskyLog(
            '🔍 Found ${incompleteSessions.length} incomplete sessions, pulling to check for updates');
        return true;
      }

      pskyLog(
          '🔍 Last sync was ${timeSinceSync.inMinutes} minutes ago, skipping pull');
      return false;
    } catch (e) {
      pskyLog('⚠️  Error checking sync status: $e');
      return true; // Default to pulling if check fails
    }
  }

  Future<InitializationStep> _initializeLeaderboard(String userId) async {
    try {
      pskyLog('🏆 Initializing leaderboard...');
      
      // Check if should show leaderboard (multiple users)
      final shouldShow = await _examRepository.hasMultipleLeaderboardUsers();
      
      if (!shouldShow) {
        pskyLog('⏭️  Only one user on leaderboard, skipping');
        return const InitializationStep(
          name: 'Leaderboard',
          success: true,
          message: 'Skipped (insufficient users)',
          skipped: true,
        );
      }
      
      // Get user's rank
      final rank = await _examRepository.getUserRank(userId: userId);
      pskyLog('🏆 User rank: #${rank.rank} (${rank.percentile.toStringAsFixed(1)}%)');

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

          // Only schedule if expiry is in the future
          if (expiryTime.isAfter(DateTime.now())) {
            try {
              await _notificationService.scheduleSessionExpiryWarning(
                sessionId: session.examSessionId,
                subjectName: session.subjectId,
                expiryTime: expiryTime,
                userId: userId
              );
              scheduledCount++;
            } catch (e) {
              pskyLog('⚠️  Failed to schedule expiry for ${session.examSessionId}: $e');
            }
          }
        }
      }



      // 2. Schedule daily study reminder (9 AM next day)
      try {
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
      } catch (e) {
        pskyLog('⚠️  Failed to schedule daily reminder: $e');
      }

      // 3. Schedule weekly report (Every Sunday 8 PM)
      try {
        final nextSunday = _getNextWeekday(DateTime.sunday);
        await _notificationService.scheduleWeeklyReport(
          userId: userId,
          scheduledTime: nextSunday,
        );
        scheduledCount++;
      } catch (e) {
        pskyLog('⚠️  Failed to schedule weekly report: $e');
      }

      pskyLog('⏰ Scheduled $scheduledCount notifications');

      return InitializationStep(
        name: 'Notifications Scheduled',
        success: true,
        message: '$scheduledCount notifications scheduled',
        metadata: {'count': scheduledCount},
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

  Future<InitializationStep> _updateUserActivity(String userId) async {
    try {
      pskyLog('👤 Updating user activity...');
      
      // This should be called after leaderboard calculation
      // For now, just mark timestamp
      await _storage.saveUserData(
        'last_activity_$userId',
        DateTime.now().millisecondsSinceEpoch,
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

  DateTime _getNextWeekday(int weekday) {
    final now = DateTime.now();
    final daysUntil = (weekday - now.weekday + 7) % 7;
    final nextDate = now.add(Duration(days: daysUntil == 0 ? 7 : daysUntil));
    return nextDate.copyWith(hour: 20, minute: 0, second: 0, millisecond: 0);
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

  /// Setup periodic background sync (only when needed)
  void setupBackgroundSync({
    required String userId,
    Duration interval = const Duration(hours: 1),
  }) {
    // Cancel existing timer
    _backgroundSyncTimer?.cancel();

    pskyLog('🔄 Setting up background sync (every ${interval.inHours} hours)');

    _backgroundSyncTimer = Timer.periodic(interval, (_) async {
      try {
        pskyLog('🔄 Background sync triggered');

        // Check connectivity
        final connectivity = await _connectivity.checkConnectivity();
        if (connectivity.contains(ConnectivityResult.none)) {
          pskyLog('⚠️  Background sync skipped: No connection');
          return;
        }

        // Smart check: Only sync if needed
        final shouldSync = await _shouldPullFromFirebase(userId);
        if (!shouldSync) {
          pskyLog('⚠️  Background sync skipped: Not needed');
          return;
        }

        // Check if there are local changes to push
        final hasLocalChanges = _examCubit.hasUnsyncedChanges();

        if (hasLocalChanges) {
          pskyLog('🔼 Pushing local changes to Firebase...');
          await _examCubit.syncCurrentSessionNow();
        }

        // Pull from Firebase
        pskyLog('🔽 Pulling from Firebase...');
        await _examCubit.syncFromDb(userId, forcePull: false);

        pskyLog('✅ Background sync completed');
      } catch (e) {
        pskyLog('❌ Background sync failed: $e');
      }
    });
  }

  /// Cancel background sync
  void cancelBackgroundSync() {
    _backgroundSyncTimer?.cancel();
    _backgroundSyncTimer = null;
    pskyLog('🛑 Background sync cancelled');
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

      // STEP 0: Initialize user storage (MUST be synchronous)
      final storageInitStep = await _initializeUserStorage(userId);
      steps.add(storageInitStep);
      _logStep(storageInitStep);

      // CRITICAL PATH ONLY (Must complete before showing UI)
      // These are synchronous and fast (<100ms)
      final localDataStep = await _loadLocalData(userId);
      steps.add(localDataStep);
      _logStep(localDataStep);

      final notificationStep = await _initializeNotifications(userId);
      steps.add(notificationStep);
      _logStep(notificationStep);

      final duration = DateTime.now().difference(startTime);
      pskyLog('✅ UI ready in ${duration.inMilliseconds}ms');

      // Mark as initialized
      _isInitialized = true;

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

  // ============================================================================
  // PUBLIC GETTERS
  // ============================================================================

  /// Check if app is initialized
  bool get isInitialized => _isInitialized;

  /// Cleanup on app dispose
  void dispose() {
    _backgroundSyncTimer?.cancel();
    pskyLog('🧹 AppInitializationService disposed');
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