import 'dart:async';
import 'dart:convert';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/achievement_score.dart';
import 'package:ahiaa_web/core/services/exam_notification_service.dart';
import 'package:ahiaa_web/core/services/exam_result_calculator.dart';
import 'package:ahiaa_web/core/services/leaderboard_calculator.dart';
import 'package:ahiaa_web/core/services/streak_service.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/practice_exam/data/datasources/firebase_exam_satasource.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_cubit_helpers.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/exam_progress.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/exam_question.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:ahiaa_web/features/practice_exam/domain/repository/exam_repository.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/sync_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'exam_state.dart';
part 'exam_cubit.freezed.dart';

@lazySingleton
class ExamCubit extends Cubit<ExamState> {
  final FirebaseFirestore _firestore;
  final SharedPreferences _prefs;
  String? _lastSyncedDataHash; // Track data changes
  bool _isCurrentlySyncing = false; // Prevent duplicate syncs
  Timer? _autoSyncTimer; // Separate from _autoSaveTimer

  Timer? _autoSaveTimer;
  static const String _storageKey = 'exam_sessions';
  static const Duration _autoSaveInterval = Duration(minutes: 3);
  static const Duration _firebaseSyncInterval = Duration(minutes: 60);

  // Track changes to optimize Firebase writes
  bool _hasUnsyncedChanges = false;
  DateTime? _lastFirebaseSync;
  String? _lastSyncedSessionJson;

  ExamCubit(this._firestore, this._prefs) : super(const ExamState.initial()) {
    _startAutoSave();
  }

  // ============================================================================
  // MODE SELECTION
  // ============================================================================

  /// Select exam mode before starting
  void selectMode(ExamMode mode) {
    emit(ExamState.modeSelected(
        examMode: mode,
        selectedSubjectTopics: ['Selected subject has no topic']));
  }

  // Add a new subject to the map
  void addSubject(String subject) {
    final currentState = state;
    if (currentState is! _ModeSelected) return;

    // Get existing map or create new one
    final currentMap = currentState.selectedSubjectAndTopic ?? {};

    // Create updated map with new subject (empty topic list)
    final updatedMap = Map<String, List<String>>.from(currentMap);

    // Only add if subject doesn't already exist
    if (!updatedMap.containsKey(subject)) {
      updatedMap[subject] = [];
    }

    emit(ExamState.modeSelected(
        examMode: currentState.examMode,
        selectedSubjectAndTopic: updatedMap,
        selectedSubjectTopics: currentState.selectedSubjectTopics));
  }

// Add a topic to an existing subject
  void addTopicToSubject(String subject, String topic) {
    final currentState = state;
    if (currentState is! _ModeSelected) return;

    // Get existing map or create new one
    final currentMap = currentState.selectedSubjectAndTopic ?? {};
    final updatedMap = Map<String, List<String>>.from(currentMap);

    // If subject doesn't exist, create it with the topic
    if (!updatedMap.containsKey(subject)) {
      updatedMap[subject] = [topic];
    } else {
      // Subject exists, add topic if not already present
      final currentTopics = List<String>.from(updatedMap[subject]!);
      if (!currentTopics.contains(topic)) {
        currentTopics.add(topic);
        updatedMap[subject] = currentTopics;
      }
    }

    emit(ExamState.modeSelected(
        examMode: currentState.examMode,
        selectedSubjectAndTopic: updatedMap,
        selectedSubject: currentState.selectedSubject,
        selectedSubjectTopics: currentState.selectedSubjectTopics));
  }

// Remove a topic from a subject
  void removeTopicFromSubject(String subject, String topic) {
    final currentState = state;
    if (currentState is! _ModeSelected) return;

    final currentMap = currentState.selectedSubjectAndTopic ?? {};
    final updatedMap = Map<String, List<String>>.from(currentMap);

    if (updatedMap.containsKey(subject)) {
      final currentTopics = List<String>.from(updatedMap[subject]!);
      currentTopics.remove(topic);
      updatedMap[subject] = currentTopics;

      emit(ExamState.modeSelected(
          examMode: currentState.examMode,
          selectedSubjectAndTopic: updatedMap,
          selectedSubjectTopics: currentState.selectedSubjectTopics));
    }
  }

// Remove a subject entirely
  void removeSubject(String subject) {
    final currentState = state;
    if (currentState is! _ModeSelected) return;

    final currentMap = currentState.selectedSubjectAndTopic ?? {};
    final updatedMap = Map<String, List<String>>.from(currentMap);
    updatedMap.remove(subject);

    emit(ExamState.modeSelected(
        examMode: currentState.examMode,
        selectedSubjectAndTopic: updatedMap,
        selectedSubjectTopics: currentState.selectedSubjectTopics));
  }

// Get the currently selected subject (for tracking which subject to update)
  String? get selectedSubject {
    final currentState = state;
    if (currentState is! _ModeSelected) return null;

    // You might store this in your state, but here's a helper to get it
    return currentState.selectedSubject;
  }

// Select a subject (track which subject is currently being edited)
  void selectSubject(String? subject) {
    final currentState = state;
    if (currentState is! _ModeSelected) return;

    emit(ExamState.modeSelected(
        examMode: currentState.examMode,
        selectedSubjectAndTopic: currentState.selectedSubjectAndTopic,
        selectedSubject: subject,
        selectedSubjectTopics: currentState.selectedSubjectTopics));
  }

  void getAllTopicsForSelected(String subject) {
    final currentState = state;
    if (currentState is! _ModeSelected) return;
    final subjectRepo = getIt<SubjectRepository>();
    final list = subjectRepo
            .getSubjectByName(subject)
            ?.getAllTopics()
            .map((t) => t.name)
            .toList() ??
        ['No topics for this subject'];
    // return list ?? ['No topic for the subject'];

    emit(ExamState.modeSelected(
        examMode: currentState.examMode,
        selectedSubjectAndTopic: currentState.selectedSubjectAndTopic,
        selectedSubject: subject,
        selectedSubjectTopics: list));
  }

// Add topic to the currently selected subject
  void addTopicToSelectedSubject(String topic) {
    final currentState = state;
    if (currentState is! _ModeSelected) return;

    final selectedSub = currentState.selectedSubject;
    if (selectedSub == null) return; // No subject selected

    addTopicToSubject(selectedSub, topic);
  }

// Remove topic from the currently selected subject
  void removeTopicFromSelectedSubject(String topic) {
    final currentState = state;
    if (currentState is! _ModeSelected) return;

    final selectedSub = currentState.selectedSubject;
    if (selectedSub == null) return;

    removeTopicFromSubject(selectedSub, topic);
  }

// Get list of all subjects that have been added
  List<String> get subjects {
    final currentState = state;
    if (currentState is! _ModeSelected) return [];

    final map = currentState.selectedSubjectAndTopic;
    if (map == null || map.isEmpty) return [];

    return map.keys.toList();
  }

// Get topics for a specific subject
  List<String> getTopicsForSubject(String subject) {
    final currentState = state;
    if (currentState is! _ModeSelected) return [];

    final map = currentState.selectedSubjectAndTopic;
    if (map == null || !map.containsKey(subject)) return [];

    return map[subject] ?? [];
  }

// Get topics for the currently selected subject
  List<String> get selectedSubjectTopics {
    final currentState = state;
    if (currentState is! _ModeSelected) return [];

    final selectedSub = currentState.selectedSubject;
    if (selectedSub == null) return [];

    return getTopicsForSubject(selectedSub);
  }

// Check if a subject has been added
  bool hasSubject(String subject) {
    final currentState = state;
    if (currentState is! _ModeSelected) return false;

    final map = currentState.selectedSubjectAndTopic;
    return map?.containsKey(subject) ?? false;
  }

// Check if a subject has a specific topic
  bool hasTopicInSubject(String subject, String topic) {
    final topics = getTopicsForSubject(subject);
    return topics.contains(topic);
  }

// Get the total number of subjects added
  int get subjectCount {
    return subjects.length;
  }

// Get the total number of topics across all subjects
  int get totalTopicCount {
    final currentState = state;
    if (currentState is! _ModeSelected) return 0;

    final map = currentState.selectedSubjectAndTopic;
    if (map == null) return 0;

    return map.values.fold(0, (sumTotal, topics) => sumTotal + topics.length);
  }

// Get the entire map (for debugging or advanced usage)
  Map<String, List<String>> get subjectsAndTopics {
    final currentState = state;
    if (currentState is! _ModeSelected) return {};

    return currentState.selectedSubjectAndTopic ?? {};
  }

  // ============================================================================
  // START EXAM
  // ============================================================================

  /// Updated startExam - marks data as changed
  Future<void> startExam({
    required String userId,
    required String subjectId,
    required ExamBody examBody,
    required PaperType paperType,
    required List<ExamQuestion> questions,
    required List<String> currentSubjects,
    required ExamMode examMode,
    required int totalMarks,
    int? customTimeLimit,
  }) async {
    try {
      final currentState = state;
      if (currentState is! _ModeSelected && currentState is! _HasData) return;
      emit(const ExamState.loading());

      final examSession = ExamSession(
        examSessionId: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        subjectId: subjectId,
        examBody: examBody,
        paperType: paperType,
        questions: questions,
        totalMarks: totalMarks,
        timeLimitMinutes:
            customTimeLimit ?? examMode.suggestedDuration.inMinutes,
        startedAt: DateTime.now(),
        status: ExamSessionStatus.inProgress,
      );

      final existingSessions = await _loadSessionsFromStorage();
      existingSessions.add(examSession);

      await _saveToLocalStorage(existingSessions);
      _hasUnsyncedChanges = true;
      _lastSyncedDataHash = null; // Force sync on next check

      emit(ExamState.hasData(
        selectedSubjects: currentSubjects,
        examSessions: existingSessions,
        currentSession: examSession,
        examMode: examMode,
      ));

      // Immediate sync for exam start (important action)
      _syncViaSyncCubit(userId, examSession);
    } catch (e) {
      emit(ExamState.error(message: 'Failed to start exam: $e'));
    }
  }

  // ============================================================================
  // LOAD FROM STORAGE
  // ============================================================================

  // ============================================================================
// FIXED STORAGE METHODS FOR EXAM CUBIT
// ============================================================================

  /// Save to local storage (ENHANCED)
  Future<void> _saveToLocalStorage(List<ExamSession> sessions) async {
    try {
      if (sessions.isEmpty) {
        await _prefs.remove(_storageKey);
        pskyLog('Cleared empty sessions from storage');
        return;
      }

      // Convert sessions to JSON
      final sessionJsonList = sessions
          .map((s) {
            try {
              return s.toJson();
            } catch (e) {
              print('Error converting session ${s.examSessionId} to JSON: $e');
              return null;
            }
          })
          .whereType<Map<String, dynamic>>()
          .toList();

      if (sessionJsonList.isEmpty) {
        print('Warning: No valid sessions to save');
        return;
      }

      final sessionsJson = jsonEncode(sessionJsonList);
      await _prefs.setString(_storageKey, sessionsJson);

      pskyLog('Saved ${sessionJsonList.length} sessions to local storage');
    } catch (e, stackTrace) {
      print('Error saving to local storage: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to save to local storage: $e');
    }
  }

  /// Clear all storage (UTILITY METHOD)
  Future<void> clearStorage() async {
    try {
      await _prefs.remove(_storageKey);
      pskyLog('Cleared all exam sessions from storage');
    } catch (e) {
      print('Error clearing storage: $e');
    }
  }

  /// Get storage info (DEBUGGING HELPER)
  Future<StorageInfo> getStorageInfo() async {
    try {
      final sessionsJson = _prefs.getString(_storageKey);

      if (sessionsJson == null || sessionsJson.isEmpty) {
        return StorageInfo(
          hasData: false,
          sessionCount: 0,
          storageSize: 0,
          lastModified: null,
        );
      }

      final List<dynamic> sessionsList = jsonDecode(sessionsJson);
      final sizeInBytes = sessionsJson.length;

      return StorageInfo(
        hasData: true,
        sessionCount: sessionsList.length,
        storageSize: sizeInBytes,
        lastModified:
            DateTime.now(), // Can't get actual timestamp from SharedPrefs
      );
    } catch (e) {
      print('Error getting storage info: $e');
      return StorageInfo(
        hasData: false,
        sessionCount: 0,
        storageSize: 0,
        lastModified: null,
      );
    }
  }

  /// Validate storage data (DEBUGGING HELPER)
  Future<ValidationResult> validateStorage() async {
    try {
      final sessionsJson = _prefs.getString(_storageKey);

      if (sessionsJson == null || sessionsJson.isEmpty) {
        return ValidationResult(
          isValid: true,
          errors: [],
          warnings: ['No data in storage'],
        );
      }

      final errors = <String>[];
      final warnings = <String>[];

      // Try to parse JSON
      try {
        final List<dynamic> sessionsList = jsonDecode(sessionsJson);

        // Try to parse each session
        for (int i = 0; i < sessionsList.length; i++) {
          try {
            final json = sessionsList[i] as Map<String, dynamic>;
            _normalizeStorageData(json);
            ExamSession.fromJson(json);
          } catch (e) {
            errors.add('Session $i failed to parse: $e');
          }
        }

        if (errors.isEmpty) {
          return ValidationResult(
            isValid: true,
            errors: [],
            warnings: warnings,
          );
        }
      } catch (e) {
        errors.add('Failed to decode JSON: $e');
      }

      return ValidationResult(
        isValid: false,
        errors: errors,
        warnings: warnings,
      );
    } catch (e) {
      return ValidationResult(
        isValid: false,
        errors: ['Validation failed: $e'],
        warnings: [],
      );
    }
  }

  /// Load exam sessions from local storage (FIXED)
  Future<void> loadFromStorage() async {
    try {
      emit(const ExamState.loading());

      final sessions = await _loadSessionsFromStorage();

      if (sessions.isEmpty) {
        emit(const ExamState.initial());
        return;
      }

      // Find the most recent in-progress session
      final currentSession = sessions.firstWhere(
        (s) =>
            s.status == ExamSessionStatus.inProgress ||
            s.status == ExamSessionStatus.paused,
        orElse: () => sessions.last,
      );

      final subjects = sessions
          .map((s) => getIt<SubjectRepository>().getSubjectById(s.subjectId))
          .where((s) => s != null)
          .map((s) => s!.name)
          .toList();

      emit(ExamState.hasData(
        examSessions: sessions,
        currentSession: currentSession,
        selectedSubjects: subjects,
        examMode: ExamMode.custom,
      ));
    } catch (e, stackTrace) {
      print('Error loading from storage: $e');
      print('Stack trace: $stackTrace');
      emit(ExamState.error(message: 'Failed to load sessions: $e'));
    }
  }

  /// Load sessions from SharedPreferences (FIXED)
  Future<List<ExamSession>> _loadSessionsFromStorage() async {
    try {
      final sessionsJson = _prefs.getString(_storageKey);
      pskyLog('Raw storage data: $sessionsJson');

      if (sessionsJson == null || sessionsJson.isEmpty) {
        pskyLog('No sessions in storage');
        return [];
      }

      final List<dynamic> sessionsList = jsonDecode(sessionsJson);
      pskyLog('Decoded ${sessionsList.length} sessions');

      final List<ExamSession> sessions = [];

      for (int i = 0; i < sessionsList.length; i++) {
        try {
          final json = sessionsList[i] as Map<String, dynamic>;

          // Normalize the data before parsing
          _normalizeStorageData(json);

          final session = ExamSession.fromJson(json);
          sessions.add(session);
          pskyLog('Loaded session ${i + 1}: ${session.examSessionId}');
        } catch (e) {
          print('Error parsing session $i: $e');
          print('Session data: ${sessionsList[i]}');
          // Continue with other sessions instead of failing completely
          continue;
        }
      }

      pskyLog('Successfully loaded ${sessions.length} sessions from storage');
      return sessions;
    } catch (e, stackTrace) {
      print('Error loading sessions from storage: $e');
      print('Stack trace: $stackTrace');
      return [];
    }
  }

  /// Normalize storage data to match expected format (NEW HELPER)
  void _normalizeStorageData(Map<String, dynamic> data) {
    // Ensure startedAt is a string
    if (data['startedAt'] != null && data['startedAt'] is! String) {
      data['startedAt'] = DateTime.now().toIso8601String();
    }

    // Ensure completedAt is a string or null
    if (data['completedAt'] != null && data['completedAt'] is! String) {
      data['completedAt'] = null;
    }

    // Ensure progress exists with all required fields
    if (data['progress'] == null) {
      data['progress'] = {
        'totalQuestions': (data['questions'] as List?)?.length ?? 0,
        'currentQuestionIndex': 0,
        'answeredCount': 0,
        'skippedCount': 0,
        'unansweredCount': (data['questions'] as List?)?.length ?? 0,
        'answeredQuestions': [],
        'skippedQuestions': [],
        'reviewedQuestions': [],
        'timeElapsedMinutes': 0,
        'lastUpdated': DateTime.now().toIso8601String(),
      };
    } else {
      // Ensure progress has all required fields
      final progress = data['progress'] as Map<String, dynamic>;

      progress['totalQuestions'] ??= (data['questions'] as List?)?.length ?? 0;
      progress['currentQuestionIndex'] ??= 0;
      progress['answeredCount'] ??= 0;
      progress['skippedCount'] ??= 0;
      progress['unansweredCount'] ??= 0;
      progress['answeredQuestions'] ??= [];
      progress['skippedQuestions'] ??= [];
      progress['reviewedQuestions'] ??= [];
      progress['timeElapsedMinutes'] ??= 0;
      progress['lastUpdated'] ??= DateTime.now().toIso8601String();

      // Ensure lastUpdated is a string
      if (progress['lastUpdated'] is! String) {
        progress['lastUpdated'] = DateTime.now().toIso8601String();
      }
    }

    // Ensure questions array exists and has proper structure
    if (data['questions'] != null && data['questions'] is List) {
      for (final question in data['questions']) {
        if (question is Map<String, dynamic>) {
          // Ensure createdAt is a string
          if (question['createdAt'] != null &&
              question['createdAt'] is! String) {
            question['createdAt'] = DateTime.now().toIso8601String();
          } else if (question['createdAt'] == null) {
            question['createdAt'] = DateTime.now().toIso8601String();
          }

          // Ensure selectedAnswer can be null
          if (!question.containsKey('selectedAnswer')) {
            question['selectedAnswer'] = null;
          }

          // Ensure answerText exists (can be empty string)
          question['answerText'] ??= '';

          // Ensure common mistakes is a list
          if (question['commonMistakes'] == null) {
            question['commonMistakes'] = [];
          }
        }
      }
    }
  }

  // ============================================================================
  // PAUSE AND SAVE
  // ============================================================================

  /// Updated pauseAndSave - marks data as changed
  Future<void> pauseAndSave() async {
    final currentState = state;
    if (currentState is! _HasData) return;

    try {
      final updatedSession = ExamSession(
        examSessionId: currentState.currentSession.examSessionId,
        userId: currentState.currentSession.userId,
        subjectId: currentState.currentSession.subjectId,
        examBody: currentState.currentSession.examBody,
        paperType: currentState.currentSession.paperType,
        questions: currentState.currentSession.questions,
        totalMarks: currentState.currentSession.totalMarks,
        timeLimitMinutes: currentState.currentSession.timeLimitMinutes,
        startedAt: currentState.currentSession.startedAt,
        status: ExamSessionStatus.paused,
        progress: currentState.currentSession.progress,
      );

      final updatedSessions = currentState.examSessions.map((session) {
        return session.examSessionId == updatedSession.examSessionId
            ? updatedSession
            : session;
      }).toList();

      final subjects = updatedSessions
          .map((s) => getIt<SubjectRepository>().getSubjectById(s.subjectId))
          .toList()
          .map((s) => s?.name ?? '')
          .toList();

      await _saveToLocalStorage(updatedSessions);
      _hasUnsyncedChanges = true;
      _lastSyncedDataHash = null; // Force sync

      emit(ExamState.hasData(
        examSessions: updatedSessions,
        currentSession: updatedSession,
        selectedSubjects: subjects,
        examMode: currentState.examMode,
      ));

      // Immediate sync for pause (important action)
      _syncViaSyncCubit(updatedSession.userId, updatedSession);
    } catch (e) {
      emit(ExamState.error(message: 'Failed to pause exam: $e'));
    }
  }

  // ============================================================================
  // END AND SAVE
  // ============================================================================

  /// Updated endAndSave - stops auto-sync since session is no longer active
  Future<void> endAndSave() async {
    final currentState = state;
    if (currentState is! _HasData) return;

    try {
      emit(const ExamState.loading());

      final updatedSession = ExamSession(
        examSessionId: currentState.currentSession.examSessionId,
        userId: currentState.currentSession.userId,
        subjectId: currentState.currentSession.subjectId,
        examBody: currentState.currentSession.examBody,
        paperType: currentState.currentSession.paperType,
        questions: currentState.currentSession.questions,
        totalMarks: currentState.currentSession.totalMarks,
        timeLimitMinutes: currentState.currentSession.timeLimitMinutes,
        startedAt: currentState.currentSession.startedAt,
        completedAt: DateTime.now(),
        status: ExamSessionStatus.completed,
        progress: currentState.currentSession.progress,
      );

      final updatedSessions = currentState.examSessions.map((session) {
        return session.examSessionId == updatedSession.examSessionId
            ? updatedSession
            : session;
      }).toList();

      await _saveToLocalStorage(updatedSessions);

      emit(ExamState.completed(
        examSessions: updatedSessions,
        completedSession: updatedSession,
      ));

      // Immediate sync for completion (critical action)
      _syncViaSyncCubit(updatedSession.userId, updatedSession);

      // Background tasks
      _updateLeaderboard(updatedSession.userId);
      _checkAchievements(updatedSession.userId, updatedSessions);
      _sendCompletionNotification(updatedSession);

      // Reset sync tracking since session is complete
      _lastSyncedDataHash = null;
      // ✅ NEW: Update streak data
      await _updateStreakAfterCompletion(updatedSession);
      pskyLog('Exam completed: ${updatedSession.examSessionId}');
    } catch (e) {
      emit(ExamState.error(message: 'Failed to end exam: $e'));
    }
  }

  /// Send exam completion notification
  void _sendCompletionNotification(ExamSession session) {
    try {
      final notificationService = getIt<ExamNotificationService>();
      final result = ExamCalculator.calculateResult(session);

      notificationService.sendAchievementNotification(
        userId: session.userId,
        achievement: Achievement(
          id: 'exam_completed_${session.examSessionId}',
          title: 'Exam Completed!',
          description: 'Score: ${result.score.percentage.toStringAsFixed(1)}%',
          category: AchievementCategory.completion,
          points: 10,
          unlockedAt: DateTime.now(),
        ),
      );
    } catch (e) {
      pskyLog('Failed to send completion notification: $e');
    }
  }

  // ============================================================================
  // SYNC TO DATABASE
  // ============================================================================

  /// Load sessions from Firebase and merge with local - USES SYNCCUBIT
  Future<void> syncFromDb(String userId) async {
    try {
      emit(const ExamState.loading());

      // ✅ NEW: Use FirebaseExamDataSource through repository
      final dataSource = getIt<FirebaseExamDataSource>();
      final firestoreSessions = await dataSource.getUserExamSessions(
        userId: userId,
      );

      // Get local sessions
      final localSessions = await _loadSessionsFromStorage();

      // Merge sessions (Firebase takes precedence)
      final mergedSessions = _mergeSessions(localSessions, firestoreSessions);

      // Save merged sessions to local storage
      await _saveToLocalStorage(mergedSessions);

      // Find current session
      final currentSession = mergedSessions.firstWhere(
        (s) =>
            s.status == ExamSessionStatus.inProgress ||
            s.status == ExamSessionStatus.paused,
        orElse: () => mergedSessions.last,
      );

      if (currentSession == null) {
        emit(const ExamState.initial());
        return;
      }

      final subjects = mergedSessions
          .map((s) => getIt<SubjectRepository>().getSubjectById(s.subjectId))
          .toList()
          .map((s) => s?.name ?? '')
          .toList();

      emit(ExamState.hasData(
        selectedSubjects: subjects,
        examSessions: mergedSessions,
        currentSession: currentSession,
        examMode: ExamMode.custom,
      ));
    } catch (e) {
      emit(ExamState.error(message: 'Failed to sync from database: $e'));
    }
  }

// ============================================================================
// NEW HELPER METHODS FOR SYNCCUBIT INTEGRATION
// ============================================================================

  /// Sync session via SyncCubit (non-blocking) - ENHANCED VERSION
  void _syncViaSyncCubit(String userId, ExamSession session) {
    try {
      // Don't sync if already syncing
      if (_isCurrentlySyncing) {
        pskyLog('Sync already in progress, skipping');
        return;
      }

      final syncCubit = getIt<SyncCubit>();

      _isCurrentlySyncing = true;

      // Fire and forget - don't await
      syncCubit
          .syncSession(
        userId: userId,
        session: session,
      )
          .then((_) {
        _markDataAsSynced();
        _lastFirebaseSync = DateTime.now();
        pskyLog('Sync completed successfully');
      }).catchError((e) {
        pskyLog('Sync failed: $e');
      }).whenComplete(() {
        _isCurrentlySyncing = false;
      });
    } catch (e) {
      pskyLog('Failed to trigger sync: $e');
      _isCurrentlySyncing = false;
    }
  }

  /// Manual sync - only syncs if there are changes
  Future<bool> syncIfNeeded() async {
    if (!hasSessionInProgress()) {
      pskyLog('No active session to sync');
      return false;
    }

    if (!hasDataChanged()) {
      pskyLog('No changes to sync');
      return false;
    }

    final activeSession = getActiveSession();
    if (activeSession == null) {
      pskyLog('No active session found');
      return false;
    }

    try {
      final syncCubit = getIt<SyncCubit>();
      await syncCubit.syncSession(
        userId: activeSession.userId,
        session: activeSession,
      );
      _markDataAsSynced();
      return true;
    } catch (e) {
      pskyLog('Sync failed: $e');
      return false;
    }
  }

  /// Force sync even if no changes (useful for manual user-triggered sync)
  Future<void> forceSyncActiveSession() async {
    final activeSession = getActiveSession();
    if (activeSession == null) {
      pskyLog('No active session to force sync');
      return;
    }

    final syncCubit = getIt<SyncCubit>();
    await syncCubit.syncSession(
      userId: activeSession.userId,
      session: activeSession,
    );
    _markDataAsSynced();
    pskyLog('Force sync completed');
  }

  /// Update leaderboard after exam completion
  void _updateLeaderboard(String userId) {
    try {
      final leaderboardCalculator = getIt<LeaderboardCalculator>();

      // Fire and forget - calculate and update in background
      leaderboardCalculator.calculateLeaderboardEntry(
        userId: userId,
        displayName: 'User', // Get from UserCubit
      );
    } catch (e) {
      pskyLog('Failed to update leaderboard: $e');
      // Don't throw - non-critical
    }
  }

  /// Check and unlock achievements after exam completion
  void _checkAchievements(String userId, List<ExamSession> sessions) {
    try {
      final achievementService = getIt<AchievementService>();

      // Fire and forget - check achievements in background
      achievementService.checkAchievements(
        userId: userId,
        sessions: sessions,
      );
    } catch (e) {
      pskyLog('Failed to check achievements: $e');
      // Don't throw - non-critical
    }
  }
// ============================================================================
// ENHANCED AUTO-SAVE WITH SMART SYNC
// ============================================================================

  /// Modified auto-save - only syncs when there's an active session with changes
  void _startAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSyncTimer?.cancel();

    // Auto-save to local storage every 3 minutes
    _autoSaveTimer = Timer.periodic(_autoSaveInterval, (_) async {
      final currentState = state;
      if (currentState is _HasData) {
        // Always save to local storage (cheap, fast)
        await _saveToLocalStorage(currentState.examSessions);
        pskyLog('Auto-saved to local storage');
      }
    });

    // Smart auto-sync every 5 minutes (only if needed)
    _autoSyncTimer = Timer.periodic(const Duration(minutes: 5), (_) async {
      await _smartAutoSync();
    });
  }

  /// Smart auto-sync - only syncs when necessary
  Future<void> _smartAutoSync() async {
    final currentState = state;

    // Check 1: Must have data
    if (currentState is! _HasData) {
      pskyLog('Smart sync: No data to sync');
      return;
    }

    // Check 2: Must have an active session (in-progress or paused)
    final hasActiveSession = _hasActiveSession();
    if (!hasActiveSession) {
      pskyLog('Smart sync: No active session, skipping sync');
      return;
    }

    // Check 3: Data must have changed since last sync
    final currentDataHash = _generateDataHash(currentState.examSessions);
    if (currentDataHash == _lastSyncedDataHash) {
      pskyLog('Smart sync: No changes detected, skipping sync');
      return;
    }

    // Check 4: Not already syncing
    if (_isCurrentlySyncing) {
      pskyLog('Smart sync: Already syncing, skipping');
      return;
    }

    // All checks passed - perform sync
    pskyLog('Smart sync: Syncing active session...');
    _isCurrentlySyncing = true;

    try {
      final activeSession = _getActiveSession();
      if (activeSession != null) {
        _syncViaSyncCubit(activeSession.userId, activeSession);
        _lastSyncedDataHash = currentDataHash;
        _hasUnsyncedChanges = false;
        pskyLog('Smart sync: Successfully synced');
      }
    } catch (e) {
      pskyLog('Smart sync: Failed - $e');
    } finally {
      _isCurrentlySyncing = false;
    }
  }

  /// Manually trigger sync of current session
  Future<void> syncCurrentSessionNow() async {
    final currentState = state;
    if (currentState is! _HasData) return;

    final syncCubit = getIt<SyncCubit>();
    await syncCubit.syncSession(
      userId: currentState.currentSession.userId,
      session: currentState.currentSession,
    );
  }

  /// Manually trigger sync of all sessions
  Future<void> syncAllSessionsNow() async {
    final currentState = state;
    if (currentState is! _HasData) return;

    final syncCubit = getIt<SyncCubit>();
    await syncCubit.sync(
      userId: currentState.currentSession.userId,
      sessions: currentState.examSessions,
    );
  }

  /// Check sync status
  Future<SyncStatus> getSyncStatus() async {
    final repository = getIt<ExamRepository>();
    return await repository.getSyncStatus();
  }

  List<ExamSession> _mergeSessions(
    List<ExamSession> local,
    List<ExamSession> remote,
  ) {
    final Map<String, ExamSession> sessionMap = {};

    // Add local sessions
    for (final session in local) {
      sessionMap[session.examSessionId] = session;
    }

    // Override with remote sessions (they're more authoritative)
    for (final session in remote) {
      sessionMap[session.examSessionId] = session;
    }

    return sessionMap.values.toList()
      ..sort((a, b) => b.startedAt!.compareTo(a.startedAt!));
  }

// ============================================================================
// CHECK FOR ACTIVE SESSIONS
// ============================================================================

  /// Check if there is any session in progress or paused
  bool hasSessionInProgress() {
    final currentState = state;

    if (currentState is! _HasData) return false;

    return currentState.examSessions.any((session) =>
        session.status == ExamSessionStatus.inProgress ||
        session.status == ExamSessionStatus.paused);
  }

  /// Get the currently active session (in-progress or most recent paused)
  ExamSession? getActiveSession() {
    return _getActiveSession();
  }

  /// Private helper to get active session
  ExamSession? _getActiveSession() {
    final currentState = state;

    if (currentState is! _HasData) return null;

    // First, look for in-progress sessions
    final inProgressSession = currentState.examSessions
        .where((s) => s.status == ExamSessionStatus.inProgress)
        .firstOrNull;

    if (inProgressSession != null) return inProgressSession;

    // If no in-progress, look for most recent paused session
    final pausedSessions = currentState.examSessions
        .where((s) => s.status == ExamSessionStatus.paused)
        .toList();

    if (pausedSessions.isEmpty) return null;

    // Return most recently started paused session
    pausedSessions.sort((a, b) => (b.startedAt ?? DateTime(1970))
        .compareTo(a.startedAt ?? DateTime(1970)));

    return pausedSessions.first;
  }

  /// Check if there are any active sessions (helper for internal use)
  bool _hasActiveSession() {
    return getActiveSession() != null;
  }

// ============================================================================
// FETCH SESSIONS IN PROGRESS
// ============================================================================

   /// Get all sessions that are currently in progress
  List<ExamSession> getAllSessions() {
    final currentState = state;

    if (currentState is! _HasData) return [];

    return currentState.examSessions;
  }

 
  /// Get all sessions that are currently in progress
  List<ExamSession> getSessionsInProgress() {
    final currentState = state;

    if (currentState is! _HasData) return [];

    return currentState.examSessions
        .where((s) => s.status == ExamSessionStatus.inProgress)
        .toList();
  }

  /// Get all paused sessions
  List<ExamSession> getPausedSessions() {
    final currentState = state;

    if (currentState is! _HasData) return [];

    return currentState.examSessions
        .where((s) => s.status == ExamSessionStatus.paused)
        .toList();
  }

  /// Get all active sessions (in-progress + paused)
  List<ExamSession> getAllActiveSessions() {
    final currentState = state;

    if (currentState is! _HasData) return [];

    return currentState.examSessions
        .where((s) =>
            s.status == ExamSessionStatus.inProgress ||
            s.status == ExamSessionStatus.paused)
        .toList();
  }

  /// Get count of active sessions
  int getActiveSessionCount() {
    return getAllActiveSessions().length;
  }

// ============================================================================
// SYNC STATUS GETTERS
// ============================================================================

  /// Get detailed sync information
  SyncInfo getSyncInfo() {
    return SyncInfo(
      hasActiveSession: hasSessionInProgress(),
      hasUnsyncedChanges: hasDataChanged(),
      isCurrentlySyncing: _isCurrentlySyncing,
      lastSyncTime: _lastFirebaseSync,
      activeSessionCount: getActiveSessionCount(),
      canSync: hasSessionInProgress() && hasDataChanged(),
    );
  }

  /// Pretty print sync status (for debugging)
  void printSyncStatus() {
    final info = getSyncInfo();
    pskyLog('=== Sync Status ===');
    pskyLog('Has Active Session: ${info.hasActiveSession}');
    pskyLog('Has Unsynced Changes: ${info.hasUnsyncedChanges}');
    pskyLog('Currently Syncing: ${info.isCurrentlySyncing}');
    pskyLog('Active Sessions: ${info.activeSessionCount}');
    pskyLog('Can Sync: ${info.canSync}');
    pskyLog('Last Sync: ${info.lastSyncTime?.toString() ?? "Never"}');
    pskyLog('==================');
  }

  /// Get active session info summary
  ActiveSessionInfo? getActiveSessionInfo() {
    final activeSession = getActiveSession();
    if (activeSession == null) return null;

    final timeSpent = _calculateTimeSpent(activeSession);
    final timeLimit = Duration(minutes: activeSession.timeLimitMinutes);
    final timeRemaining = timeLimit - timeSpent;

    return ActiveSessionInfo(
      session: activeSession,
      isInProgress: activeSession.status == ExamSessionStatus.inProgress,
      isPaused: activeSession.status == ExamSessionStatus.paused,
      timeSpent: timeSpent,
      timeRemaining: timeRemaining.isNegative ? Duration.zero : timeRemaining,
      questionsAnswered: activeSession.progress?.answeredCount ?? 0,
      totalQuestions: activeSession.questions.length,
      progressPercentage: activeSession.questions.isEmpty
          ? 0.0
          : ((activeSession.progress?.answeredCount ?? 0) /
              activeSession.questions.length *
              100),
    );
  }

// ============================================================================
// DATA CHANGE DETECTION
// ============================================================================

  /// Generate a hash of the exam sessions data to detect changes
  String _generateDataHash(List<ExamSession> sessions) {
    // Only hash active sessions (in-progress or paused) for efficiency
    final activeSessions = sessions
        .where((s) =>
            s.status == ExamSessionStatus.inProgress ||
            s.status == ExamSessionStatus.paused)
        .toList();

    if (activeSessions.isEmpty) return 'no_active_sessions';

    // Create a simple hash from key data points
    final hashData = activeSessions.map((s) {
      final answeredCount = s.progress?.answeredCount ?? 0;
      final timeElapsed = s.progress?.timeElapsedMinutes ?? 0;
      final questionsHash =
          s.questions.map((q) => q.answerText ?? '').join(',');

      return '${s.examSessionId}_${s.status.name}_${answeredCount}_${timeElapsed}_${questionsHash}';
    }).join('|');

    return hashData.hashCode.toString();
  }

  /// Check if data has changed since last sync
  bool hasDataChanged() {
    final currentState = state;
    if (currentState is! _HasData) return false;

    final currentHash = _generateDataHash(currentState.examSessions);
    return currentHash != _lastSyncedDataHash;
  }

  /// Mark data as synced (call this after successful sync)
  void _markDataAsSynced() {
    final currentState = state;
    if (currentState is _HasData) {
      _lastSyncedDataHash = _generateDataHash(currentState.examSessions);
      _hasUnsyncedChanges = false;
    }
  }

  // ============================================================================
  // SWITCH SESSION
  // ============================================================================

  /// Switch to a different exam session
  void switchSession(String examSessionId) {
    final currentState = state;
    if (currentState is! _HasData) return;

    try {
      final newSession = currentState.examSessions.firstWhere(
        (s) => s.examSessionId == examSessionId,
      );
      final subjects = currentState.examSessions
          .map((s) => getIt<SubjectRepository>().getSubjectById(s.subjectId))
          .toList()
          .map((s) => s?.name ?? '')
          .toList();
      emit(ExamState.hasData(
        examSessions: currentState.examSessions,
        currentSession: newSession,
        selectedSubjects: subjects,
        examMode: currentState.examMode,
      ));
    } catch (e) {
      emit(ExamState.error(message: 'Session not found'));
    }
  }

  // ============================================================================
  // UPDATE SESSION (for syncing with ExamSessionCubit)
  // ============================================================================

  /// Update the current session (used for syncing from ExamSessionCubit)
  Future<void> updateCurrentSession(ExamSession updatedSession) async {
    final currentState = state;
    if (currentState is! _HasData) return;

    try {
      // Update sessions list
      final updatedSessions = currentState.examSessions.map((session) {
        return session.examSessionId == updatedSession.examSessionId
            ? updatedSession
            : session;
      }).toList();

      // Save to local storage (cheap operation)
      await _saveToLocalStorage(updatedSessions);

      // Mark that we have unsynced changes
      _hasUnsyncedChanges = true;
      final subjects = updatedSessions
          .map((s) => getIt<SubjectRepository>().getSubjectById(s.subjectId))
          .toList()
          .map((s) => s?.name ?? '')
          .toList();
      emit(ExamState.hasData(
        selectedSubjects: subjects,
        examSessions: updatedSessions,
        currentSession: updatedSession,
        examMode: currentState.examMode,
      ));
    } catch (e) {
      print('Failed to update session: $e');
    }
  }

  /// Update answer for a question in the current session
  Future<void> updateAnswer({
    required String questionId,
    required String answer,
  }) async {
    final currentState = state;
    if (currentState is! _HasData) return;

    try {
      // Update the question in the current session
      final updatedQuestions = currentState.currentSession.questions.map((q) {
        if (q.questionId == questionId) {
          return ExamQuestion(
            questionId: q.questionId,
            questionNumber: q.questionNumber,
            questionText: q.questionText,
            questionType: q.questionType,
            subjectId: q.subjectId,
            topicId: q.topicId,
            examBody: q.examBody,
            difficultyLevel: q.difficultyLevel,
            marks: q.marks,
            timeEstimateMinutes: q.timeEstimateMinutes,
            options: q.options,
            correctAnswer: q.correctAnswer,
            answerText: answer,
            markingScheme: q.markingScheme,
            explanation: q.explanation,
            commonMistakes: q.commonMistakes,
            syllabusReference: q.syllabusReference,
            requiresDiagram: q.requiresDiagram,
            diagramDescription: q.diagramDescription,
            diagramUrl: q.diagramUrl,
            pastYearReference: q.pastYearReference,
            createdAt: q.createdAt,
            createdBy: q.createdBy,
          );
        }
        return q;
      }).toList();

      final updatedSession = ExamSession(
        examSessionId: currentState.currentSession.examSessionId,
        userId: currentState.currentSession.userId,
        subjectId: currentState.currentSession.subjectId,
        examBody: currentState.currentSession.examBody,
        paperType: currentState.currentSession.paperType,
        questions: updatedQuestions,
        totalMarks: currentState.currentSession.totalMarks,
        timeLimitMinutes: currentState.currentSession.timeLimitMinutes,
        startedAt: currentState.currentSession.startedAt,
        completedAt: currentState.currentSession.completedAt,
        status: currentState.currentSession.status,
        progress: currentState.currentSession.progress,
      );

      // Update sessions list
      final updatedSessions = currentState.examSessions.map((session) {
        return session.examSessionId == updatedSession.examSessionId
            ? updatedSession
            : session;
      }).toList();

      // Save to local storage (cheap operation)
      await _saveToLocalStorage(updatedSessions);

      // Mark that we have unsynced changes
      _hasUnsyncedChanges = true;
      final subjects = updatedSessions
          .map((s) => getIt<SubjectRepository>().getSubjectById(s.subjectId))
          .toList()
          .map((s) => s?.name ?? '')
          .toList();
      emit(ExamState.hasData(
        selectedSubjects: subjects,
        examSessions: updatedSessions,
        currentSession: updatedSession,
        examMode: currentState.examMode,
      ));
    } catch (e) {
      print('Failed to update answer: $e');
    }
  }

  // ============================================================================
  // DELETE SESSION
  // ============================================================================

  /// Delete a session from local and Firebase
  Future<void> deleteSession(String examSessionId) async {
    final currentState = state;
    if (currentState is! _HasData) return;

    try {
      final session = currentState.examSessions.firstWhere(
        (s) => s.examSessionId == examSessionId,
      );

      // Remove from Firebase
      await _firestore
          .collection('users')
          .doc(session.userId)
          .collection('exam_sessions')
          .doc(examSessionId)
          .delete();

      // Update local sessions
      final updatedSessions = currentState.examSessions
          .where((s) => s.examSessionId != examSessionId)
          .toList();

      await _saveToLocalStorage(updatedSessions);

      if (updatedSessions.isEmpty) {
        emit(const ExamState.initial());
      } else {
        final subjects = updatedSessions
            .map((s) => getIt<SubjectRepository>().getSubjectById(s.subjectId))
            .toList()
            .map((s) => s?.name ?? '')
            .toList();
        emit(ExamState.hasData(
          selectedSubjects: subjects,
          examSessions: updatedSessions,
          currentSession: updatedSessions.first,
          examMode: currentState.examMode,
        ));
      }
    } catch (e) {
      emit(ExamState.error(message: 'Failed to delete session: $e'));
    }
  }

  // ============================================================================
  // MANUAL SYNC CONTROL
  // ============================================================================
  // clear current sessions
  void clear() {
    emit(const ExamState.initial());
  }

  /// Force immediate sync to Firebase (for manual user-triggered sync)
  Future<void> forceSyncToFirebase() async {
    final currentState = state;
    if (currentState is! _HasData) return;

    try {
      // ✅ NEW: Sync via SyncCubit (critical action - sync immediately)
      _syncViaSyncCubit(
          currentState.currentSession.userId, currentState.currentSession);

      print('Manual Firebase sync completed');
    } catch (e) {
      print('Manual sync failed: $e');
      rethrow;
    }
  }

  /// Check if there are unsynced changes
  bool hasUnsyncedChanges() => _hasUnsyncedChanges;

  /// Get time since last Firebase sync
  Duration? getTimeSinceLastSync() {
    if (_lastFirebaseSync == null) return null;
    return DateTime.now().difference(_lastFirebaseSync!);
  }

  // ============================================================================
  // AGGREGATE CALCULATIONS (Multiple Sessions)
  // ============================================================================

  /// Calculate aggregate results for all completed sessions
  AggregateExamResult? calculateAggregateResults() {
    final currentState = state;

    if (currentState is! _HasData && currentState is! _Completed) {
      pskyLog('Cannot calculate aggregate: Invalid state');
      return null;
    }

    try {
      List<ExamSession> allSessions;

      if (currentState is _HasData) {
        allSessions = currentState.examSessions;
      } else {
        allSessions = (currentState as _Completed).examSessions;
      }

      // Filter only completed sessions
      final completedSessions = allSessions
          .where((s) => s.status == ExamSessionStatus.completed)
          .toList();

      if (completedSessions.isEmpty) {
        pskyLog('No completed sessions to calculate');
        return null;
      }

      final result = ExamCalculator.calculateAggregateResult(completedSessions);
      pskyLog(
          'Aggregate result calculated: ${completedSessions.length} sessions, '
          'Overall: ${result.aggregateScore.percentage}% - ${result.overallGrade.grade}');

      return result;
    } catch (e) {
      pskyLog('Error calculating aggregate results: $e');
      return null;
    }
  }

  /// Calculate aggregate results for all completed sessions
  AggregateExamResult? calculateAggregateWithParams(
      List<ExamSession> sessions) {
    try {
      if (sessions.isEmpty) {
        pskyLog('No completed sessions to calculate');
        return null;
      }

      final result = ExamCalculator.calculateAggregateResult(sessions);
      pskyLog('Aggregate result calculated: ${sessions.length} sessions, '
          'Overall: ${result.aggregateScore.percentage}% - ${result.overallGrade.grade}');

      return result;
    } catch (e) {
      pskyLog('Error calculating aggregate results: $e');
      return null;
    }
  }

  /// Get aggregate results for a specific subject
  AggregateExamResult? calculateSubjectAggregateResults(String subjectId) {
    final currentState = state;

    if (currentState is! _HasData && currentState is! _Completed) {
      return null;
    }

    try {
      List<ExamSession> allSessions;

      if (currentState is _HasData) {
        allSessions = currentState.examSessions;
      } else {
        allSessions = (currentState as _Completed).examSessions;
      }

      // Filter completed sessions for this subject
      final subjectSessions = allSessions
          .where((s) =>
              s.subjectId == subjectId &&
              s.status == ExamSessionStatus.completed)
          .toList();

      if (subjectSessions.isEmpty) {
        pskyLog('No completed sessions for subject: $subjectId');
        return null;
      }

      return ExamCalculator.calculateAggregateResult(subjectSessions);
    } catch (e) {
      pskyLog('Error calculating subject aggregate: $e');
      return null;
    }
  }

  /// Get all individual results for completed sessions
  List<ExamResult> getAllSessionResults() {
    final currentState = state;

    if (currentState is! _HasData && currentState is! _Completed) {
      return [];
    }

    try {
      List<ExamSession> allSessions;

      if (currentState is _HasData) {
        allSessions = currentState.examSessions;
      } else {
        allSessions = (currentState as _Completed).examSessions;
      }

      final completedSessions = allSessions
          .where((s) => s.status == ExamSessionStatus.completed)
          .toList();

      return completedSessions
          .map((session) {
            try {
              return ExamCalculator.calculateResult(session);
            } catch (e) {
              pskyLog(
                  'Error calculating result for session ${session.examSessionId}: $e');
              return null;
            }
          })
          .whereType<ExamResult>() // Filter out nulls
          .toList();
    } catch (e) {
      pskyLog('Error getting all session results: $e');
      return [];
    }
  }

  /// Get results grouped by subject
  Map<String, List<ExamResult>> getResultsBySubject() {
    final results = getAllSessionResults();
    final currentState = state;

    if (currentState is! _HasData && currentState is! _Completed) {
      return {};
    }

    try {
      List<ExamSession> allSessions;

      if (currentState is _HasData) {
        allSessions = currentState.examSessions;
      } else {
        allSessions = (currentState as _Completed).examSessions;
      }

      final Map<String, List<ExamResult>> groupedResults = {};

      for (final result in results) {
        // Find the corresponding session
        final session = allSessions.firstWhere(
          (s) => s.examSessionId == result.examSession.examSessionId,
          orElse: () => allSessions.first,
        );

        final subjectId = session.subjectId;

        if (!groupedResults.containsKey(subjectId)) {
          groupedResults[subjectId] = [];
        }

        groupedResults[subjectId]!.add(result);
      }

      return groupedResults;
    } catch (e) {
      pskyLog('Error grouping results by subject: $e');
      return {};
    }
  }

// Add cache tracking
  DateTime? _lastLeaderboardFetch;
  static const Duration _leaderboardRefreshInterval = Duration(minutes: 5);

  /// Get leaderboard entries with advanced filtering and caching
  /// Returns empty list if there's only one person on the leaderboard
  Future<List<LeaderboardEntry>> getLeaderboardEntries({
    int limit = 100,
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
    LeaderboardFilter? filter,
    bool forceRefresh = false,
  }) async {
    try {
      final repository = getIt<ExamRepository>();

      // Smart refresh logic: only refresh if forced or cache is stale
      final shouldRefresh = forceRefresh || _shouldRefreshLeaderboard();

      // Check if there are multiple users (cached)
      final hasMultipleUsers = await repository.hasMultipleLeaderboardUsers(
        forceRefresh: shouldRefresh,
      );

      if (!hasMultipleUsers) {
        pskyLog('Leaderboard has only one user, returning empty list');
        return [];
      }

      // Fetch leaderboard entries (uses cache internally)
      var entries = await repository.getLeaderboardList(
        limit: limit,
        type: type,
        subjectId: subjectId,
        forceRefresh: shouldRefresh,
      );

      // Update last fetch time
      if (shouldRefresh) {
        _lastLeaderboardFetch = DateTime.now();
      }

      // Apply client-side filtering if provided
      if (filter != null) {
        entries = _applyLeaderboardFilter(entries, filter);
      }

      pskyLog(
          'Retrieved ${entries.length} leaderboard entries (after filtering)');
      return entries;
    } catch (e) {
      pskyLog('Error getting leaderboard entries: $e');
      return [];
    }
  }

  /// Check if leaderboard should be refreshed
  bool _shouldRefreshLeaderboard() {
    if (_lastLeaderboardFetch == null) return true;

    final timeSinceLastFetch =
        DateTime.now().difference(_lastLeaderboardFetch!);
    return timeSinceLastFetch > _leaderboardRefreshInterval;
  }

  /// Force refresh leaderboard cache
  Future<void> refreshLeaderboardCache() async {
    final repository = getIt<ExamRepository>();
    repository.clearLeaderboardCache();
    _lastLeaderboardFetch = null;
    pskyLog('Leaderboard cache force refreshed');
  }

  /// Apply client-side filtering to leaderboard entries
  List<LeaderboardEntry> _applyLeaderboardFilter(
    List<LeaderboardEntry> entries,
    LeaderboardFilter filter,
  ) {
    var filtered = entries;

    // Filter by minimum score
    if (filter.minScore != null) {
      filtered =
          filtered.where((e) => e.overallScore >= filter.minScore!).toList();
    }

    // Filter by maximum score
    if (filter.maxScore != null) {
      filtered =
          filtered.where((e) => e.overallScore <= filter.maxScore!).toList();
    }

    // // Filter by minimum exam count
    // if (filter.minExamsCompleted != null) {
    //   filtered = filtered.where((e) => e.totalExams >= filter.minExamsCompleted!).toList();
    // }

    // Filter by user IDs (useful for friends/group filtering)
    if (filter.userIds != null && filter.userIds!.isNotEmpty) {
      filtered =
          filtered.where((e) => filter.userIds!.contains(e.userId)).toList();
    }

    // Filter by display name search
    if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
      final query = filter.searchQuery!.toLowerCase();
      filtered = filtered
          .where((e) => e.displayName.toLowerCase().contains(query))
          .toList();
    }

    // Filter by date range (last updated)
    if (filter.startDate != null) {
      filtered = filtered
          .where((e) =>
              e.lastUpdated.isAfter(filter.startDate!) ||
              e.lastUpdated.isAtSameMomentAs(filter.startDate!))
          .toList();
    }

    if (filter.endDate != null) {
      filtered = filtered
          .where((e) =>
              e.lastUpdated.isBefore(filter.endDate!) ||
              e.lastUpdated.isAtSameMomentAs(filter.endDate!))
          .toList();
    }

    // Filter by rank range
    if (filter.minRank != null || filter.maxRank != null) {
      // Add ranks to entries first
      for (int i = 0; i < filtered.length; i++) {
        // Rank is position + 1
        final rank = i + 1;

        if (filter.minRank != null && rank < filter.minRank!) {
          continue;
        }
        if (filter.maxRank != null && rank > filter.maxRank!) {
          break;
        }
      }

      if (filter.minRank != null) {
        filtered = filtered.skip(filter.minRank! - 1).toList();
      }
      if (filter.maxRank != null) {
        filtered = filtered.take(filter.maxRank!).toList();
      }
    }

    // Apply sorting if specified
    if (filter.sortBy != null) {
      filtered = _sortLeaderboardEntries(
          filtered, filter.sortBy!, filter.sortDescending);
    }

    // Apply limit after filtering
    if (filter.customLimit != null) {
      filtered = filtered.take(filter.customLimit!).toList();
    }

    return filtered;
  }

  /// Sort leaderboard entries by different criteria
  List<LeaderboardEntry> _sortLeaderboardEntries(
    List<LeaderboardEntry> entries,
    LeaderboardSortBy sortBy,
    bool descending,
  ) {
    final sorted = List<LeaderboardEntry>.from(entries);

    switch (sortBy) {
      case LeaderboardSortBy.score:
        sorted.sort((a, b) => descending
            ? b.overallScore.compareTo(a.overallScore)
            : a.overallScore.compareTo(b.overallScore));
        break;

      case LeaderboardSortBy.lastUpdated:
        sorted.sort((a, b) => descending
            ? b.lastUpdated.compareTo(a.lastUpdated)
            : a.lastUpdated.compareTo(b.lastUpdated));
        break;

      case LeaderboardSortBy.displayName:
        sorted.sort((a, b) => descending
            ? b.displayName.compareTo(a.displayName)
            : a.displayName.compareTo(b.displayName));
        break;
    }

    return sorted;
  }

  /// Get leaderboard count (cached)
  Future<int> getLeaderboardUserCount({bool forceRefresh = false}) async {
    try {
      final repository = getIt<ExamRepository>();
      return await repository.getLeaderboardCount(forceRefresh: forceRefresh);
    } catch (e) {
      pskyLog('Error getting leaderboard count: $e');
      return 0;
    }
  }

  /// Check if should show leaderboard (cached check)
  Future<bool> shouldShowLeaderboard({bool forceRefresh = false}) async {
    try {
      final repository = getIt<ExamRepository>();
      return await repository.hasMultipleLeaderboardUsers(
          forceRefresh: forceRefresh);
    } catch (e) {
      pskyLog('Error checking leaderboard visibility: $e');
      return false;
    }
  }

  /// Get leaderboard with current user's rank (optimized)
  Future<LeaderboardData?> getLeaderboardWithUserRank({
    required String userId,
    int limit = 100,
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
    LeaderboardFilter? filter,
    bool forceRefresh = false,
  }) async {
    try {
      final repository = getIt<ExamRepository>();

      // Smart refresh
      final shouldRefresh = forceRefresh || _shouldRefreshLeaderboard();

      // Check if there are multiple users (cached)
      final hasMultipleUsers = await repository.hasMultipleLeaderboardUsers(
        forceRefresh: shouldRefresh,
      );

      if (!hasMultipleUsers) {
        pskyLog('Leaderboard has only one user, returning null');
        return null;
      }

      // Fetch leaderboard entries and user rank in parallel
      final results = await Future.wait([
        repository.getLeaderboardList(
          limit: limit,
          type: type,
          subjectId: subjectId,
          forceRefresh: shouldRefresh,
        ),
        repository.getUserRank(
          userId: userId,
          type: type,
          subjectId: subjectId,
        ),
      ]);

      var entries = results[0] as List<LeaderboardEntry>;
      final userRank = results[1] as LeaderboardRank;

      // Update last fetch time
      if (shouldRefresh) {
        _lastLeaderboardFetch = DateTime.now();
      }

      // Apply filtering if provided
      if (filter != null) {
        entries = _applyLeaderboardFilter(entries, filter);
      }

      // Find user's entry in the list
      final userEntry = entries.firstWhere(
        (entry) => entry.userId == userId,
        orElse: () => entries.first,
      );

      return LeaderboardData(
        entries: entries,
        userRank: userRank,
        userEntry: userEntry,
        totalUsers: userRank.totalUsers,
        type: type,
        appliedFilter: filter,
      );
    } catch (e) {
      pskyLog('Error getting leaderboard with user rank: $e');
      return null;
    }
  }

  /// Get top performers with optional filtering (cached)
  Future<List<LeaderboardEntry>> getTopPerformers({
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
    LeaderboardFilter? filter,
    bool forceRefresh = false,
  }) async {
    return await getLeaderboardEntries(
      limit: 10,
      type: type,
      subjectId: subjectId,
      filter: filter,
      forceRefresh: forceRefresh,
    );
  }

  /// Get leaderboard for specific subject with filtering (cached)
  Future<List<LeaderboardEntry>> getSubjectLeaderboard(
    String subjectId, {
    LeaderboardFilter? filter,
    bool forceRefresh = false,
  }) async {
    return await getLeaderboardEntries(
      type: LeaderboardType.subject,
      subjectId: subjectId,
      limit: 50,
      filter: filter,
      forceRefresh: forceRefresh,
    );
  }

  /// Get filtered leaderboard by score range (cached)
  Future<List<LeaderboardEntry>> getLeaderboardByScoreRange({
    required double minScore,
    required double maxScore,
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
    bool forceRefresh = false,
  }) async {
    return await getLeaderboardEntries(
      type: type,
      subjectId: subjectId,
      filter: LeaderboardFilter(
        minScore: minScore,
        maxScore: maxScore,
      ),
      forceRefresh: forceRefresh,
    );
  }

  /// Get leaderboard for friends/specific users (cached)
  Future<List<LeaderboardEntry>> getFriendsLeaderboard({
    required List<String> friendUserIds,
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
    bool forceRefresh = false,
  }) async {
    return await getLeaderboardEntries(
      type: type,
      subjectId: subjectId,
      filter: LeaderboardFilter(
        userIds: friendUserIds,
      ),
      forceRefresh: forceRefresh,
    );
  }

  /// Search leaderboard by display name (cached)
  Future<List<LeaderboardEntry>> searchLeaderboard({
    required String query,
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
    bool forceRefresh = false,
  }) async {
    return await getLeaderboardEntries(
      type: type,
      subjectId: subjectId,
      filter: LeaderboardFilter(
        searchQuery: query,
      ),
      forceRefresh: forceRefresh,
    );
  }

  /// Get active users (updated recently) (cached)
  Future<List<LeaderboardEntry>> getActiveUsers({
    int daysBack = 7,
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
    bool forceRefresh = false,
  }) async {
    final startDate = DateTime.now().subtract(Duration(days: daysBack));

    return await getLeaderboardEntries(
      type: type,
      subjectId: subjectId,
      filter: LeaderboardFilter(
        startDate: startDate,
        sortBy: LeaderboardSortBy.lastUpdated,
        sortDescending: true,
      ),
      forceRefresh: forceRefresh,
    );
  }

  /// Get top rank range (e.g., ranks 1-10, 11-20, etc.) (cached)
  Future<List<LeaderboardEntry>> getLeaderboardByRankRange({
    required int minRank,
    required int maxRank,
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
    bool forceRefresh = false,
  }) async {
    return await getLeaderboardEntries(
      limit: maxRank,
      type: type,
      subjectId: subjectId,
      filter: LeaderboardFilter(
        minRank: minRank,
        maxRank: maxRank,
      ),
      forceRefresh: forceRefresh,
    );
  }

  /// Get performance trend (improvement over time)
  ProgressTrend? getPerformanceTrend() {
    final aggregate = calculateAggregateResults();
    return aggregate?.progressTrend;
  }

  /// Get best performing session
  ExamResult? getBestSession() {
    final aggregate = calculateAggregateResults();
    return aggregate?.bestPerformance;
  }

  /// Get worst performing session
  ExamResult? getWorstSession() {
    final aggregate = calculateAggregateResults();
    return aggregate?.worstPerformance;
  }

  /// Get overall statistics
  ExamStatisticsSummary? getOverallStatistics() {
    final currentState = state;

    if (currentState is! _HasData && currentState is! _Completed) {
      return null;
    }

    try {
      List<ExamSession> allSessions;

      if (currentState is _HasData) {
        allSessions = currentState.examSessions;
      } else {
        allSessions = (currentState as _Completed).examSessions;
      }

      final completedSessions = allSessions
          .where((s) => s.status == ExamSessionStatus.completed)
          .toList();

      final inProgressSessions = allSessions
          .where((s) => s.status == ExamSessionStatus.inProgress)
          .toList();

      final pausedSessions = allSessions
          .where((s) => s.status == ExamSessionStatus.paused)
          .toList();

      final abandonedSessions = allSessions
          .where((s) => s.status == ExamSessionStatus.abandoned)
          .toList();

      // Calculate total time spent
      final totalTimeSpent = completedSessions.fold<int>(
        0,
        (sum, session) => sum + (session.progress?.timeElapsedMinutes ?? 0),
      );

      // Calculate total questions attempted
      final totalQuestionsAttempted = completedSessions.fold<int>(
        0,
        (sum, session) => sum + (session.progress?.answeredCount ?? 0),
      );

      return ExamStatisticsSummary(
        totalSessions: allSessions.length,
        completedSessions: completedSessions.length,
        inProgressSessions: inProgressSessions.length,
        pausedSessions: pausedSessions.length,
        abandonedSessions: abandonedSessions.length,
        totalTimeSpentMinutes: totalTimeSpent,
        totalQuestionsAttempted: totalQuestionsAttempted,
        averageSessionDuration: completedSessions.isNotEmpty
            ? totalTimeSpent / completedSessions.length
            : 0.0,
      );
    } catch (e) {
      pskyLog('Error calculating overall statistics: $e');
      return null;
    }
  }

  /// Check if any sessions have been completed
  bool hasCompletedSessions() {
    final currentState = state;

    if (currentState is! _HasData && currentState is! _Completed) {
      return false;
    }

    List<ExamSession> allSessions;

    if (currentState is _HasData) {
      allSessions = currentState.examSessions;
    } else {
      allSessions = (currentState as _Completed).examSessions;
    }

    return allSessions.any((s) => s.status == ExamSessionStatus.completed);
  }

  /// Get completion rate (percentage of sessions completed)
  double getCompletionRate() {
    final stats = getOverallStatistics();
    if (stats == null || stats.totalSessions == 0) return 0.0;

    return (stats.completedSessions / stats.totalSessions) * 100;
  }

  // Add these functions to your ExamCubit class

// ============================================================================
// TIME CALCULATION FUNCTIONS
// ============================================================================
  /// Get total time spent across ALL sessions (completed + in-progress + paused)
  Duration getTotalTimeSpentAcrossAllSessions() {
    final currentState = state;
    if (currentState is! _HasData && currentState is! _Completed) {
      return Duration.zero;
    }

    List<ExamSession> allSessions;
    if (currentState is _HasData) {
      allSessions = currentState.examSessions;
    } else {
      allSessions = (currentState as _Completed).examSessions;
    }

    int totalMinutes = 0;

    for (final session in allSessions) {
      final spent = _calculateTimeSpent(session);
      totalMinutes += spent.inMinutes;
    }

    return Duration(minutes: totalMinutes);
  }

  /// Get total time limit across ALL sessions
  Duration getTotalTimeLimitAcrossAllSessions() {
    final currentState = state;
    if (currentState is! _HasData && currentState is! _Completed) {
      return Duration.zero;
    }

    List<ExamSession> allSessions;
    if (currentState is _HasData) {
      allSessions = currentState.examSessions;
    } else {
      allSessions = (currentState as _Completed).examSessions;
    }

    int totalMinutes = 0;
    for (final session in allSessions) {
      totalMinutes += session.timeLimitMinutes;
    }

    return Duration(minutes: totalMinutes);
  }

  /// Get average time spent per session (only completed ones)
  Duration getAverageTimeSpentPerSession() {
    final currentState = state;
    if (currentState is! _HasData && currentState is! _Completed) {
      return Duration.zero;
    }

    List<ExamSession> allSessions;
    if (currentState is _HasData) {
      allSessions = currentState.examSessions;
    } else {
      allSessions = (currentState as _Completed).examSessions;
    }

    final completedSessions = allSessions
        .where((s) => s.status == ExamSessionStatus.completed)
        .toList();

    if (completedSessions.isEmpty) return Duration.zero;

    int totalMinutes = 0;
    for (final session in completedSessions) {
      totalMinutes += session.progress?.timeElapsedMinutes ?? 0;
    }

    final avgMinutes = totalMinutes ~/ completedSessions.length;
    return Duration(minutes: totalMinutes);
  }

  /// Get total remaining time across all in-progress sessions
  Duration getTotalTimeRemainingAcrossInProgress() {
    final currentState = state;
    if (currentState is! _HasData && currentState is! _Completed) {
      return Duration.zero;
    }

    List<ExamSession> allSessions;
    if (currentState is _HasData) {
      allSessions = currentState.examSessions;
    } else {
      allSessions = (currentState as _Completed).examSessions;
    }

    int totalRemainingMinutes = 0;

    for (final session in allSessions) {
      if (session.status == ExamSessionStatus.inProgress) {
        final timeLimit = Duration(minutes: session.timeLimitMinutes);
        final timeSpent = _calculateTimeSpent(session);
        final remaining = timeLimit - timeSpent;
        if (remaining.isNegative) {
          totalRemainingMinutes += 0;
        } else {
          totalRemainingMinutes += remaining.inMinutes;
        }
      }
    }

    return Duration(minutes: totalRemainingMinutes);
  }

  String getFormattedTotalTimeAcrossAllSessions() {
    final duration = getTotalTimeSpentAcrossAllSessions();
    return _formatReadableDuration(duration);
  }

  String getFormattedAverageTimePerSession() {
    final duration = getAverageTimeSpentPerSession();
    return _formatReadableDuration(duration);
  }

  String getFormattedTotalTimeLimitAcrossAll() {
    final duration = getTotalTimeLimitAcrossAllSessions();
    return _formatReadableDuration(duration);
  }

  GlobalTimeMetrics getGlobalTimeMetrics() {
    final currentState = state;
    if (currentState is! _HasData && currentState is! _Completed) {
      return GlobalTimeMetrics.zero();
    }

    List<ExamSession> allSessions;
    if (currentState is _HasData) {
      allSessions = currentState.examSessions;
    } else {
      allSessions = (currentState as _Completed).examSessions;
    }

    final completed = allSessions
        .where((s) => s.status == ExamSessionStatus.completed)
        .toList();
    final inProgress = allSessions
        .where((s) => s.status == ExamSessionStatus.inProgress)
        .toList();

    final totalTimeSpent = getTotalTimeSpentAcrossAllSessions();
    final totalTimeLimit = getTotalTimeLimitAcrossAllSessions();
    final totalTimeRemaining = getTotalTimeRemainingAcrossInProgress();
    final avgTimePerSession = getAverageTimeSpentPerSession();

    final totalTimeUsedPercentage = totalTimeLimit.inSeconds > 0
        ? (totalTimeSpent.inSeconds / totalTimeLimit.inSeconds) * 100
        : 0.0;

    return GlobalTimeMetrics(
      totalSessions: allSessions.length,
      completedSessions: completed.length,
      inProgressSessions: inProgress.length,
      totalTimeSpent: totalTimeSpent,
      totalTimeLimit: totalTimeLimit,
      totalTimeRemaining: totalTimeRemaining,
      averageTimePerSession: avgTimePerSession,
      totalTimeUsedPercentage: totalTimeUsedPercentage,
      formattedTotalTimeSpent: _formatReadableDuration(totalTimeSpent),
      formattedTotalTimeLimit: _formatReadableDuration(totalTimeLimit),
      formattedAverageTime: _formatReadableDuration(avgTimePerSession),
    );
  }

  // ============================================================================
// INTEGRATION WITH EXAM CUBIT
// ============================================================================

// Add these methods to your ExamCubit class

  /// Get current streak data
  Future<StreakData> getStreakData() async {
    final currentState = state;

    List<ExamSession> sessions = [];
    String userId = '';

    if (currentState is _HasData) {
      sessions = currentState.examSessions;
      userId = currentState.currentSession.userId;
    } else if (currentState is _Completed) {
      sessions = currentState.examSessions;
      userId = currentState.completedSession.userId;
    } else {
      return StreakData.empty();
    }

    final streakService = getIt<StreakService>();
    return await streakService.calculateStreakData(
      userId: userId,
      sessions: sessions,
    );
  }

  /// Update streak after completing an exam
  Future<void> _updateStreakAfterCompletion(ExamSession session) async {
    try {
      final currentState = state;
      if (currentState is! _Completed) return;

      final streakService = getIt<StreakService>();
      await streakService.updateStreakOnSessionComplete(
        userId: session.userId,
        session: session,
        allSessions: currentState.examSessions,
      );

      // Check for milestones
      final streakData = await getStreakData();
      final milestone = streakService.checkMilestone(streakData.currentStreak);

      if (milestone != null) {
        _notifyStreakMilestone(session.userId, milestone);
      }

      // Check if need to send reminder
      if (streakService.shouldSendStreakReminder(streakData)) {
        _sendStreakReminder(session.userId, streakData.currentStreak);
      }
    } catch (e) {
      pskyLog('Error updating streak: $e');
    }
  }

  /// Send streak milestone notification
  void _notifyStreakMilestone(String userId, StreakMilestone milestone) {
    try {
      final notificationService = getIt<ExamNotificationService>();

      notificationService.sendAchievementNotification(
        userId: userId,
        achievement: Achievement(
          id: 'streak_milestone_${milestone.days}',
          title: milestone.title,
          description: milestone.message,
          category: AchievementCategory.streak,
          points: milestone.reward,
          unlockedAt: DateTime.now(),
        ),
      );
    } catch (e) {
      pskyLog('Error sending milestone notification: $e');
    }
  }

  /// Send streak reminder notification
  void _sendStreakReminder(String userId, int currentStreak) {
    try {
      final notificationService = getIt<ExamNotificationService>();

      notificationService.sendStreakReminder(
        userId: userId,
        currentStreak: currentStreak,
      );
    } catch (e) {
      pskyLog('Error sending streak reminder: $e');
    }
  }

  /// Get data for streak card (Image 1 & 2)
  Future<StreakCardData> getStreakCardData() async {
    final streakData = await getStreakData();

    return StreakCardData(
      currentStreak: streakData.currentStreak,
      hasStreak: streakData.currentStreak > 0,
      message: streakData.currentStreak > 0
          ? 'Days you\'ve shown up — keep it going!'
          : 'Do a first session to start streak',
      isActive: streakData.currentStreak > 0 &&
          streakData.lastActivityDate != null &&
          DateTime.now().difference(streakData.lastActivityDate!).inDays < 2,
    );
  }

  /// Get data for 30-day grid (Image 3)
  Future<MonthlyGridData> getMonthlyGridData() async {
    final streakData = await getStreakData();
    final now = DateTime.now();

    return MonthlyGridData(
      activeDays: streakData.stats.activeDaysThisMonth,
      totalDays: 30,
      month: _getMonthName(now.month),
      days: streakData.monthlyActivity,
      message: 'Number of days you\'ve shown up — keep it up',
    );
  }

  /// Get data for 30-day grid (Image 3)
//   Future<MonthlyGridData> getMonthlyGridDataByMonthName(String month) async {
//     final streakData = await getStreakData();
//     final now = DateTime.;

//     return MonthlyGridData(
//       activeDays: streakData.stats.activeDaysThisMonth,
//       totalDays: 30,
//       month: _getMonthByName(month.toLowerCase()),
//       days: streakData.monthlyActivity,
//       message: 'Number of days you\'ve shown up — keep it up',
//     );
//   }
// }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
  // String _getMonthByName(String month) {
  //   const months = [
  //     'January',
  //     'February',
  //     'March',
  //     'April',
  //     'May',
  //     'June',
  //     'July',
  //     'August',
  //     'September',
  //     'October',
  //     'November',
  //     'December'
  //   ];
  //   return months.firstWhere((s)=>s.toLowerCase()==month.toLowerCase());
  // }

// ============================================================================
// PRIVATE HELPER FUNCTIONS
// ============================================================================

  /// Helper to calculate time spent for any session
  Duration _calculateTimeSpent(ExamSession session) {
    // If session hasn't started, return zero
    if (session.startedAt == null) return Duration.zero;

    // If session is completed, use the progress timeElapsed
    if (session.status == ExamSessionStatus.completed &&
        session.progress != null) {
      return Duration(minutes: session.progress!.timeElapsedMinutes);
    }

    // If session is in progress, calculate from start time
    if (session.status == ExamSessionStatus.inProgress) {
      final elapsed = DateTime.now().difference(session.startedAt!);
      return elapsed;
    }

    // For paused sessions, use the saved progress time
    if (session.status == ExamSessionStatus.paused &&
        session.progress != null) {
      return Duration(minutes: session.progress!.timeElapsedMinutes);
    }

    return Duration.zero;
  }

  /// Format duration as "HH:MM:SS" or "MM:SS"
  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
  }

  /// Format duration as readable string (e.g., "1h 30m", "45m", "30s")
  String _formatReadableDuration(Duration duration) {
    if (duration == Duration.zero) return '0s';

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final parts = <String>[];
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    if (seconds > 0 && hours == 0) parts.add('${seconds}s');

    return parts.isEmpty ? '0s' : parts.join(' ');
  }

  @override
  Future<void> close() {
    _autoSaveTimer?.cancel();
    return super.close();
  }
}
