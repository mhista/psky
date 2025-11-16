part of 'initialization_cubit.dart';

@freezed
class InitializationState with _$InitializationState {
  const factory InitializationState.initial() = _Initial;
  const factory InitializationState.initializing() = _Initializing;
  const factory InitializationState.initialized({
    required InitializationResult result,
  }) = _Initialized;
  const factory InitializationState.error({
    required String message,
    InitializationResult? result,
  }) = _Error;
}