// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InitializationResult _$InitializationResultFromJson(
        Map<String, dynamic> json) =>
    _InitializationResult(
      success: json['success'] as bool,
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => InitializationStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$InitializationResultToJson(
        _InitializationResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'duration': instance.duration.inMicroseconds,
      'steps': instance.steps,
      'timestamp': instance.timestamp.toIso8601String(),
      'error': instance.error,
    };

_InitializationStep _$InitializationStepFromJson(Map<String, dynamic> json) =>
    _InitializationStep(
      name: json['name'] as String,
      success: json['success'] as bool,
      message: json['message'] as String,
      skipped: json['skipped'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$InitializationStepToJson(_InitializationStep instance) =>
    <String, dynamic>{
      'name': instance.name,
      'success': instance.success,
      'message': instance.message,
      'skipped': instance.skipped,
      'metadata': instance.metadata,
    };
