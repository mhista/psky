
// ============================================================================
// SYNC CUBIT
// ============================================================================

import 'dart:async';

import 'package:ahiaa_web/features/practice_exam/data/datasources/firebase_exam_satasource.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:ahiaa_web/features/practice_exam/domain/repository/exam_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_state.dart';
part 'sync_cubit.freezed.dart';

@lazySingleton
class SyncCubit extends Cubit<SyncState> {
  final ExamRepository _repository;
  final FirebaseExamDataSource _dataSource;
  
  Timer? _autoSyncTimer;
  static const Duration _autoSyncInterval = Duration(minutes: 15);

  SyncCubit(this._repository, this._dataSource) 
      : super(const SyncState.idle()) {
    _startAutoSync();
  }

  // ============================================================================
  // MANUAL SYNC
  // ============================================================================

  /// Manually trigger sync
  Future<void> sync({
    required String userId,
    required List<ExamSession> sessions,
  }) async {
    try {
      emit(const SyncState.syncing());

      final result = await _repository.batchSaveSessions(
        userId: userId,
        sessions: sessions,
      );

      if (result.success) {
        emit(SyncState.success(result: result));
      } else {
        emit(SyncState.error(
          message: result.error ?? 'Sync failed',
          result: result,
        ));
      }
    } catch (e) {
      emit(SyncState.error(message: 'Sync failed: $e'));
    }
  }

  /// Sync single session
  Future<void> syncSession({
    required String userId,
    required ExamSession session,
  }) async {
    try {
      emit(const SyncState.syncing());

      final result = await _repository.saveSession(
        userId: userId,
        session: session,
      );

      if (result.success) {
        emit(SyncState.success(result: result));
      } else {
        emit(SyncState.error(
          message: result.error ?? 'Sync failed',
          result: result,
        ));
      }
    } catch (e) {
      emit(SyncState.error(message: 'Sync failed: $e'));
    }
  }

  // ============================================================================
  // SYNC STATUS
  // ============================================================================

  /// Get current sync status
  Future<void> checkSyncStatus() async {
    try {
      final status = await _repository.getSyncStatus();
      emit(SyncState.status(status: status));
    } catch (e) {
      emit(SyncState.error(message: 'Failed to check sync status: $e'));
    }
  }

  /// Check if sync is needed
  Future<bool> needsSync() async {
    return await _repository.needsSync();
  }

  // ============================================================================
  // AUTO SYNC
  // ============================================================================

  void _startAutoSync() {
    _autoSyncTimer?.cancel();
    _autoSyncTimer = Timer.periodic(_autoSyncInterval, (_) async {
      final needsSync = await _repository.needsSync();
      if (needsSync) {
        print('Auto-sync triggered');
        // Note: You'll need to pass userId and sessions from somewhere
        // This is just a placeholder - implement based on your architecture
      }
    });
  }

  /// Enable/disable auto sync
  void setAutoSync(bool enabled) {
    if (enabled) {
      _startAutoSync();
    } else {
      _autoSyncTimer?.cancel();
    }
  }

  // ============================================================================
  // CLEANUP
  // ============================================================================

  @override
  Future<void> close() {
    _autoSyncTimer?.cancel();
    return super.close();
  }
}

