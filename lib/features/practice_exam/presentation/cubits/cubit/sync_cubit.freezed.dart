// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SyncState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SyncState()';
  }
}

/// @nodoc
class $SyncStateCopyWith<$Res> {
  $SyncStateCopyWith(SyncState _, $Res Function(SyncState) __);
}

/// Adds pattern-matching-related methods to [SyncState].
extension SyncStatePatterns on SyncState {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_Status value)? status,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Idle() when idle != null:
        return idle(_that);
      case _Syncing() when syncing != null:
        return syncing(_that);
      case _Success() when success != null:
        return success(_that);
      case _Error() when error != null:
        return error(_that);
      case _Status() when status != null:
        return status(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_Status value) status,
  }) {
    final _that = this;
    switch (_that) {
      case _Idle():
        return idle(_that);
      case _Syncing():
        return syncing(_that);
      case _Success():
        return success(_that);
      case _Error():
        return error(_that);
      case _Status():
        return status(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_Status value)? status,
  }) {
    final _that = this;
    switch (_that) {
      case _Idle() when idle != null:
        return idle(_that);
      case _Syncing() when syncing != null:
        return syncing(_that);
      case _Success() when success != null:
        return success(_that);
      case _Error() when error != null:
        return error(_that);
      case _Status() when status != null:
        return status(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? syncing,
    TResult Function(SyncResult result)? success,
    TResult Function(String message, SyncResult? result)? error,
    TResult Function(SyncStatus status)? status,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Idle() when idle != null:
        return idle();
      case _Syncing() when syncing != null:
        return syncing();
      case _Success() when success != null:
        return success(_that.result);
      case _Error() when error != null:
        return error(_that.message, _that.result);
      case _Status() when status != null:
        return status(_that.status);
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
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() syncing,
    required TResult Function(SyncResult result) success,
    required TResult Function(String message, SyncResult? result) error,
    required TResult Function(SyncStatus status) status,
  }) {
    final _that = this;
    switch (_that) {
      case _Idle():
        return idle();
      case _Syncing():
        return syncing();
      case _Success():
        return success(_that.result);
      case _Error():
        return error(_that.message, _that.result);
      case _Status():
        return status(_that.status);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? syncing,
    TResult? Function(SyncResult result)? success,
    TResult? Function(String message, SyncResult? result)? error,
    TResult? Function(SyncStatus status)? status,
  }) {
    final _that = this;
    switch (_that) {
      case _Idle() when idle != null:
        return idle();
      case _Syncing() when syncing != null:
        return syncing();
      case _Success() when success != null:
        return success(_that.result);
      case _Error() when error != null:
        return error(_that.message, _that.result);
      case _Status() when status != null:
        return status(_that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Idle implements SyncState {
  const _Idle();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Idle);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SyncState.idle()';
  }
}

/// @nodoc

class _Syncing implements SyncState {
  const _Syncing();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Syncing);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SyncState.syncing()';
  }
}

/// @nodoc

class _Success implements SyncState {
  const _Success({required this.result});

  final SyncResult result;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  @override
  String toString() {
    return 'SyncState.success(result: $result)';
  }
}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res>
    implements $SyncStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) =
      __$SuccessCopyWithImpl;
  @useResult
  $Res call({SyncResult result});

  $SyncResultCopyWith<$Res> get result;
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res> implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? result = null,
  }) {
    return _then(_Success(
      result: null == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as SyncResult,
    ));
  }

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SyncResultCopyWith<$Res> get result {
    return $SyncResultCopyWith<$Res>(_self.result, (value) {
      return _then(_self.copyWith(result: value));
    });
  }
}

/// @nodoc

class _Error implements SyncState {
  const _Error({required this.message, this.result});

  final String message;
  final SyncResult? result;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, result);

  @override
  String toString() {
    return 'SyncState.error(message: $message, result: $result)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SyncStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) =
      __$ErrorCopyWithImpl;
  @useResult
  $Res call({String message, SyncResult? result});

  $SyncResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? result = freezed,
  }) {
    return _then(_Error(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      result: freezed == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as SyncResult?,
    ));
  }

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SyncResultCopyWith<$Res>? get result {
    if (_self.result == null) {
      return null;
    }

    return $SyncResultCopyWith<$Res>(_self.result!, (value) {
      return _then(_self.copyWith(result: value));
    });
  }
}

/// @nodoc

class _Status implements SyncState {
  const _Status({required this.status});

  final SyncStatus status;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StatusCopyWith<_Status> get copyWith =>
      __$StatusCopyWithImpl<_Status>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Status &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'SyncState.status(status: $status)';
  }
}

/// @nodoc
abstract mixin class _$StatusCopyWith<$Res>
    implements $SyncStateCopyWith<$Res> {
  factory _$StatusCopyWith(_Status value, $Res Function(_Status) _then) =
      __$StatusCopyWithImpl;
  @useResult
  $Res call({SyncStatus status});

  $SyncStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$StatusCopyWithImpl<$Res> implements _$StatusCopyWith<$Res> {
  __$StatusCopyWithImpl(this._self, this._then);

  final _Status _self;
  final $Res Function(_Status) _then;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
  }) {
    return _then(_Status(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
    ));
  }

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SyncStatusCopyWith<$Res> get status {
    return $SyncStatusCopyWith<$Res>(_self.status, (value) {
      return _then(_self.copyWith(status: value));
    });
  }
}

// dart format on
