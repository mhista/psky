import 'package:freezed_annotation/freezed_annotation.dart';
part 'init_entities.freezed.dart';
part 'init_entities.g.dart';
// ============================================================================
// INITIALIZATION ENTITIES
// ============================================================================

@freezed
abstract class InitializationResult with _$InitializationResult {
  const InitializationResult._();
  const factory InitializationResult({
    required bool success,
    required Duration duration,
    required List<InitializationStep> steps,
    required DateTime timestamp,
    String? error,
  }) = _InitializationResult;

  factory InitializationResult.fromJson(Map<String, dynamic> json) =>
      _$InitializationResultFromJson(json);
}

@freezed
abstract class InitializationStep with _$InitializationStep {
  const InitializationStep._();
  const factory InitializationStep({
    required String name,
    required bool success,
    required String message,
    @Default(false) bool skipped,
    Map<String, dynamic>? metadata,
  }) = _InitializationStep;

  factory InitializationStep.fromJson(Map<String, dynamic> json) =>
      _$InitializationStepFromJson(json);
}
