// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'init_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InitializationResult {
  bool get success;
  Duration get duration;
  List<InitializationStep> get steps;
  DateTime get timestamp;
  String? get error;

  /// Create a copy of InitializationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InitializationResultCopyWith<InitializationResult> get copyWith =>
      _$InitializationResultCopyWithImpl<InitializationResult>(
          this as InitializationResult, _$identity);

  /// Serializes this InitializationResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InitializationResult &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other.steps, steps) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, duration,
      const DeepCollectionEquality().hash(steps), timestamp, error);

  @override
  String toString() {
    return 'InitializationResult(success: $success, duration: $duration, steps: $steps, timestamp: $timestamp, error: $error)';
  }
}

/// @nodoc
abstract mixin class $InitializationResultCopyWith<$Res> {
  factory $InitializationResultCopyWith(InitializationResult value,
          $Res Function(InitializationResult) _then) =
      _$InitializationResultCopyWithImpl;
  @useResult
  $Res call(
      {bool success,
      Duration duration,
      List<InitializationStep> steps,
      DateTime timestamp,
      String? error});
}

/// @nodoc
class _$InitializationResultCopyWithImpl<$Res>
    implements $InitializationResultCopyWith<$Res> {
  _$InitializationResultCopyWithImpl(this._self, this._then);

  final InitializationResult _self;
  final $Res Function(InitializationResult) _then;

  /// Create a copy of InitializationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? duration = null,
    Object? steps = null,
    Object? timestamp = null,
    Object? error = freezed,
  }) {
    return _then(_self.copyWith(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      steps: null == steps
          ? _self.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<InitializationStep>,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [InitializationResult].
extension InitializationResultPatterns on InitializationResult {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InitializationResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InitializationResult() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InitializationResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InitializationResult():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InitializationResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InitializationResult() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(bool success, Duration duration,
            List<InitializationStep> steps, DateTime timestamp, String? error)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InitializationResult() when $default != null:
        return $default(_that.success, _that.duration, _that.steps,
            _that.timestamp, _that.error);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(bool success, Duration duration,
            List<InitializationStep> steps, DateTime timestamp, String? error)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InitializationResult():
        return $default(_that.success, _that.duration, _that.steps,
            _that.timestamp, _that.error);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(bool success, Duration duration,
            List<InitializationStep> steps, DateTime timestamp, String? error)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InitializationResult() when $default != null:
        return $default(_that.success, _that.duration, _that.steps,
            _that.timestamp, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _InitializationResult extends InitializationResult {
  const _InitializationResult(
      {required this.success,
      required this.duration,
      required final List<InitializationStep> steps,
      required this.timestamp,
      this.error})
      : _steps = steps,
        super._();
  factory _InitializationResult.fromJson(Map<String, dynamic> json) =>
      _$InitializationResultFromJson(json);

  @override
  final bool success;
  @override
  final Duration duration;
  final List<InitializationStep> _steps;
  @override
  List<InitializationStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final DateTime timestamp;
  @override
  final String? error;

  /// Create a copy of InitializationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InitializationResultCopyWith<_InitializationResult> get copyWith =>
      __$InitializationResultCopyWithImpl<_InitializationResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InitializationResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InitializationResult &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, duration,
      const DeepCollectionEquality().hash(_steps), timestamp, error);

  @override
  String toString() {
    return 'InitializationResult(success: $success, duration: $duration, steps: $steps, timestamp: $timestamp, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$InitializationResultCopyWith<$Res>
    implements $InitializationResultCopyWith<$Res> {
  factory _$InitializationResultCopyWith(_InitializationResult value,
          $Res Function(_InitializationResult) _then) =
      __$InitializationResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool success,
      Duration duration,
      List<InitializationStep> steps,
      DateTime timestamp,
      String? error});
}

/// @nodoc
class __$InitializationResultCopyWithImpl<$Res>
    implements _$InitializationResultCopyWith<$Res> {
  __$InitializationResultCopyWithImpl(this._self, this._then);

  final _InitializationResult _self;
  final $Res Function(_InitializationResult) _then;

  /// Create a copy of InitializationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = null,
    Object? duration = null,
    Object? steps = null,
    Object? timestamp = null,
    Object? error = freezed,
  }) {
    return _then(_InitializationResult(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      steps: null == steps
          ? _self._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<InitializationStep>,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$InitializationStep {
  String get name;
  bool get success;
  String get message;
  bool get skipped;
  Map<String, dynamic>? get metadata;

  /// Create a copy of InitializationStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InitializationStepCopyWith<InitializationStep> get copyWith =>
      _$InitializationStepCopyWithImpl<InitializationStep>(
          this as InitializationStep, _$identity);

  /// Serializes this InitializationStep to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InitializationStep &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.skipped, skipped) || other.skipped == skipped) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, success, message, skipped,
      const DeepCollectionEquality().hash(metadata));

  @override
  String toString() {
    return 'InitializationStep(name: $name, success: $success, message: $message, skipped: $skipped, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $InitializationStepCopyWith<$Res> {
  factory $InitializationStepCopyWith(
          InitializationStep value, $Res Function(InitializationStep) _then) =
      _$InitializationStepCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      bool success,
      String message,
      bool skipped,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$InitializationStepCopyWithImpl<$Res>
    implements $InitializationStepCopyWith<$Res> {
  _$InitializationStepCopyWithImpl(this._self, this._then);

  final InitializationStep _self;
  final $Res Function(InitializationStep) _then;

  /// Create a copy of InitializationStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? success = null,
    Object? message = null,
    Object? skipped = null,
    Object? metadata = freezed,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      skipped: null == skipped
          ? _self.skipped
          : skipped // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [InitializationStep].
extension InitializationStepPatterns on InitializationStep {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InitializationStep value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InitializationStep() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InitializationStep value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InitializationStep():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InitializationStep value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InitializationStep() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, bool success, String message, bool skipped,
            Map<String, dynamic>? metadata)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InitializationStep() when $default != null:
        return $default(_that.name, _that.success, _that.message, _that.skipped,
            _that.metadata);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, bool success, String message, bool skipped,
            Map<String, dynamic>? metadata)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InitializationStep():
        return $default(_that.name, _that.success, _that.message, _that.skipped,
            _that.metadata);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String name, bool success, String message, bool skipped,
            Map<String, dynamic>? metadata)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InitializationStep() when $default != null:
        return $default(_that.name, _that.success, _that.message, _that.skipped,
            _that.metadata);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _InitializationStep extends InitializationStep {
  const _InitializationStep(
      {required this.name,
      required this.success,
      required this.message,
      this.skipped = false,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata,
        super._();
  factory _InitializationStep.fromJson(Map<String, dynamic> json) =>
      _$InitializationStepFromJson(json);

  @override
  final String name;
  @override
  final bool success;
  @override
  final String message;
  @override
  @JsonKey()
  final bool skipped;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of InitializationStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InitializationStepCopyWith<_InitializationStep> get copyWith =>
      __$InitializationStepCopyWithImpl<_InitializationStep>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InitializationStepToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InitializationStep &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.skipped, skipped) || other.skipped == skipped) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, success, message, skipped,
      const DeepCollectionEquality().hash(_metadata));

  @override
  String toString() {
    return 'InitializationStep(name: $name, success: $success, message: $message, skipped: $skipped, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$InitializationStepCopyWith<$Res>
    implements $InitializationStepCopyWith<$Res> {
  factory _$InitializationStepCopyWith(
          _InitializationStep value, $Res Function(_InitializationStep) _then) =
      __$InitializationStepCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      bool success,
      String message,
      bool skipped,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$InitializationStepCopyWithImpl<$Res>
    implements _$InitializationStepCopyWith<$Res> {
  __$InitializationStepCopyWithImpl(this._self, this._then);

  final _InitializationStep _self;
  final $Res Function(_InitializationStep) _then;

  /// Create a copy of InitializationStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? success = null,
    Object? message = null,
    Object? skipped = null,
    Object? metadata = freezed,
  }) {
    return _then(_InitializationStep(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      skipped: null == skipped
          ? _self.skipped
          : skipped // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

// dart format on
