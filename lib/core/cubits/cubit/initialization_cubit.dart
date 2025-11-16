import 'package:ahiaa_web/core/entities/init_entities.dart';
import 'package:ahiaa_web/core/services/app_init.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'initialization_state.dart';
part 'initialization_cubit.freezed.dart';


// ============================================================================
// INITIALIZATION CUBIT
// ============================================================================

@lazySingleton
class InitializationCubit extends Cubit<InitializationState> {
  final AppInitializationService _service;

  InitializationCubit(this._service) : super(const InitializationState.initial());

  /// Initialize app
  Future<void> initialize({
    required String userId,
    bool forceSync = false,
    bool quickStart = true,
  }) async {
    try {
      emit(const InitializationState.initializing());

      final result = quickStart
          ? await _service.quickStart(userId: userId)
          : await _service.initialize(userId: userId, forceSync: forceSync);

      if (result.success) {
        emit(InitializationState.initialized(result: result));
      } else {
        emit(InitializationState.error(
          message: result.error ?? 'Initialization failed',
          result: result,
        ));
      }
    } catch (e) {
      emit(InitializationState.error(message: 'Initialization failed: $e'));
    }
  }

  /// Retry initialization
  Future<void> retry({
    required String userId,
    bool forceSync = true,
  }) async {
    await initialize(
      userId: userId,
      forceSync: forceSync,
      quickStart: false,
    );
  }
}

