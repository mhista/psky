

// ============================================================================
// OFFLINE QUEUE MANAGER
// ============================================================================

import 'dart:async';
import 'dart:convert';

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/local_storage/storage_utility.dart';
import 'package:ahiaa_web/features/practice_exam/data/datasources/firebase_exam_satasource.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:ahiaa_web/features/practice_exam/domain/repository/exam_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages offline operations and syncs when online
@lazySingleton
class OfflineQueueManager {
  final LocalStorageService _prefs;
  final FirebaseExamDataSource _dataSource;
  final Connectivity _connectivity;

  static const String _queueKey = 'offline_queue';

  final _queueController = StreamController<int>.broadcast();
  Stream<int> get queueSize => _queueController.stream;

  OfflineQueueManager(this._prefs, this._dataSource, this._connectivity) {
    _listenToConnectivity();
  }

  /// Add operation to offline queue
  Future<void> addToQueue(OfflineOperation operation) async {
    try {
      final queue = await _getQueue();
      queue.add(operation);
      await _saveQueue(queue);
      _queueController.add(queue.length);
    } catch (e) {
      print('Error adding to offline queue: $e');
    }
  }

  /// Process offline queue
  Future<void> processQueue() async {
    try {
      final queue = await _getQueue();
      if (queue.isEmpty) return;

      final failed = <OfflineOperation>[];

      for (final operation in queue) {
        try {
          await _executeOperation(operation);
        } catch (e) {
          print('Failed to execute operation: $e');
          failed.add(operation);
        }
      }

      // Save failed operations back to queue
      await _saveQueue(failed);
      _queueController.add(failed.length);

      print('Processed ${queue.length - failed.length} operations, ${failed.length} failed');
    } catch (e) {
      print('Error processing offline queue: $e');
    }
  }

  /// Clear queue
  Future<void> clearQueue() async {
    await _prefs.removeUserData(_queueKey);
    _queueController.add(0);
  }

  /// Get queue size
  Future<int> getQueueSize() async {
    final queue = await _getQueue();
    return queue.length;
  }

  // ============================================================================
  // PRIVATE METHODS
  // ============================================================================

  Future<List<OfflineOperation>> _getQueue() async {
    try {
      final queueJson = _prefs.getUserData(_queueKey);
      if (queueJson == null) return [];

      final List<dynamic> queueList = jsonDecode(queueJson);
      return queueList
          .map((json) => OfflineOperation.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting queue: $e');
      return [];
    }
  }

  Future<void> _saveQueue(List<OfflineOperation> queue) async {
    try {
      final queueJson = jsonEncode(queue.map((op) => op.toJson()).toList());
      await _prefs.saveUserData(_queueKey, queueJson);
    } catch (e) {
      print('Error saving queue: $e');
    }
  }

  Future<void> _executeOperation(OfflineOperation operation) async {
    switch (operation.type) {
      case OperationType.saveSession:
        final session = ExamSession.fromJson(operation.data);
        await _dataSource.saveExamSession(
          userId: operation.userId,
          session: session,
        );
        break;
      
      case OperationType.deleteSession:
        await _dataSource.deleteExamSession(
          userId: operation.userId,
          sessionId: operation.data['sessionId'],
        );
        break;
      
      case OperationType.updateLeaderboard:
        final entry = LeaderboardEntry.fromJson(operation.data);
        await _dataSource.updateLeaderboardEntry(
          userId: operation.userId,
          entry: entry,
        );
        break;
    }
  }

  void _listenToConnectivity() {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        // Connected - process queue
        processQueue();
      }
    });
  }

  void dispose() {
    _queueController.close();
  }
}




// ============================================================================
// ANALYTICS EXPORT SERVICE
// ============================================================================

@lazySingleton
class AnalyticsExportService {
  final ExamRepository _repository;

  AnalyticsExportService(this._repository);

  /// Export user analytics to CSV
  Future<String> exportToCSV({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final sessions = await _repository.getSessions(
      userId: userId,
      filter: ExamSessionFilter(
        startDate: startDate,
        endDate: endDate,
        status: ExamSessionStatus.completed,
      ),
    );

    final csv = StringBuffer();
    csv.writeln('Session ID,Subject,Started At,Completed At,Score,Time (mins),Questions,Correct');

    for (final session in sessions) {
      final score = _calculateScore(session);
      final correct = _countCorrect(session);
      
      csv.writeln([
        session.examSessionId,
        session.subjectId,
        session.startedAt?.toIso8601String() ?? '',
        session.completedAt?.toIso8601String() ?? '',
        score.toStringAsFixed(2),
        session.progress?.timeElapsedMinutes ?? 0,
        session.questions.length,
        correct,
      ].join(','));
    }

    return csv.toString();
  }

  double _calculateScore(ExamSession session) {
    final correct = _countCorrect(session);
    return session.questions.isEmpty 
        ? 0.0 
        : (correct / session.questions.length) * 100;
  }

  int _countCorrect(ExamSession session) {
    return session.questions.where((q) {
      if (q.questionType == QuestionType.objective) {
        return q.selectedAnswer == q.correctAnswer;
      }
      return false;
    }).length;
  }
}