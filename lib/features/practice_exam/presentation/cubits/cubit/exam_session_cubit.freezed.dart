// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_session_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExamSessionState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExamSessionState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExamSessionState()';
  }
}

/// @nodoc
class $ExamSessionStateCopyWith<$Res> {
  $ExamSessionStateCopyWith(
      ExamSessionState _, $Res Function(ExamSessionState) __);
}

/// Adds pattern-matching-related methods to [ExamSessionState].
extension ExamSessionStatePatterns on ExamSessionState {
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
    TResult Function(_Initial value)? initial,
    TResult Function(_Active value)? active,
    TResult Function(_Paused value)? paused,
    TResult Function(_Completed value)? completed,
    TResult Function(_Abandoned value)? abandoned,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Active() when active != null:
        return active(_that);
      case _Paused() when paused != null:
        return paused(_that);
      case _Completed() when completed != null:
        return completed(_that);
      case _Abandoned() when abandoned != null:
        return abandoned(_that);
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Active value) active,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Abandoned value) abandoned,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial(_that);
      case _Active():
        return active(_that);
      case _Paused():
        return paused(_that);
      case _Completed():
        return completed(_that);
      case _Abandoned():
        return abandoned(_that);
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Active value)? active,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Abandoned value)? abandoned,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Active() when active != null:
        return active(_that);
      case _Paused() when paused != null:
        return paused(_that);
      case _Completed() when completed != null:
        return completed(_that);
      case _Abandoned() when abandoned != null:
        return abandoned(_that);
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
    TResult Function()? initial,
    TResult Function(ExamSession session, int currentQuestionIndex,
            int timeRemainingSeconds, bool hasReachedQuestionLimit)?
        active,
    TResult Function(ExamSession session, int currentQuestionIndex,
            int timeRemainingSeconds, bool hasReachedQuestionLimit)?
        paused,
    TResult Function(ExamSession session, int currentQuestionIndex)? completed,
    TResult Function(ExamSession session)? abandoned,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Active() when active != null:
        return active(_that.session, _that.currentQuestionIndex,
            _that.timeRemainingSeconds, _that.hasReachedQuestionLimit);
      case _Paused() when paused != null:
        return paused(_that.session, _that.currentQuestionIndex,
            _that.timeRemainingSeconds, _that.hasReachedQuestionLimit);
      case _Completed() when completed != null:
        return completed(_that.session, _that.currentQuestionIndex);
      case _Abandoned() when abandoned != null:
        return abandoned(_that.session);
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
    required TResult Function() initial,
    required TResult Function(ExamSession session, int currentQuestionIndex,
            int timeRemainingSeconds, bool hasReachedQuestionLimit)
        active,
    required TResult Function(ExamSession session, int currentQuestionIndex,
            int timeRemainingSeconds, bool hasReachedQuestionLimit)
        paused,
    required TResult Function(ExamSession session, int currentQuestionIndex)
        completed,
    required TResult Function(ExamSession session) abandoned,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _Active():
        return active(_that.session, _that.currentQuestionIndex,
            _that.timeRemainingSeconds, _that.hasReachedQuestionLimit);
      case _Paused():
        return paused(_that.session, _that.currentQuestionIndex,
            _that.timeRemainingSeconds, _that.hasReachedQuestionLimit);
      case _Completed():
        return completed(_that.session, _that.currentQuestionIndex);
      case _Abandoned():
        return abandoned(_that.session);
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
    TResult? Function()? initial,
    TResult? Function(ExamSession session, int currentQuestionIndex,
            int timeRemainingSeconds, bool hasReachedQuestionLimit)?
        active,
    TResult? Function(ExamSession session, int currentQuestionIndex,
            int timeRemainingSeconds, bool hasReachedQuestionLimit)?
        paused,
    TResult? Function(ExamSession session, int currentQuestionIndex)? completed,
    TResult? Function(ExamSession session)? abandoned,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Active() when active != null:
        return active(_that.session, _that.currentQuestionIndex,
            _that.timeRemainingSeconds, _that.hasReachedQuestionLimit);
      case _Paused() when paused != null:
        return paused(_that.session, _that.currentQuestionIndex,
            _that.timeRemainingSeconds, _that.hasReachedQuestionLimit);
      case _Completed() when completed != null:
        return completed(_that.session, _that.currentQuestionIndex);
      case _Abandoned() when abandoned != null:
        return abandoned(_that.session);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements ExamSessionState {
  const _Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExamSessionState.initial()';
  }
}

/// @nodoc

class _Active implements ExamSessionState {
  const _Active(
      {required this.session,
      required this.currentQuestionIndex,
      required this.timeRemainingSeconds,
      this.hasReachedQuestionLimit = false});

  final ExamSession session;
  final int currentQuestionIndex;
  final int timeRemainingSeconds;
  @JsonKey()
  final bool hasReachedQuestionLimit;

  /// Create a copy of ExamSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActiveCopyWith<_Active> get copyWith =>
      __$ActiveCopyWithImpl<_Active>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Active &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            (identical(other.timeRemainingSeconds, timeRemainingSeconds) ||
                other.timeRemainingSeconds == timeRemainingSeconds) &&
            (identical(
                    other.hasReachedQuestionLimit, hasReachedQuestionLimit) ||
                other.hasReachedQuestionLimit == hasReachedQuestionLimit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session, currentQuestionIndex,
      timeRemainingSeconds, hasReachedQuestionLimit);

  @override
  String toString() {
    return 'ExamSessionState.active(session: $session, currentQuestionIndex: $currentQuestionIndex, timeRemainingSeconds: $timeRemainingSeconds, hasReachedQuestionLimit: $hasReachedQuestionLimit)';
  }
}

/// @nodoc
abstract mixin class _$ActiveCopyWith<$Res>
    implements $ExamSessionStateCopyWith<$Res> {
  factory _$ActiveCopyWith(_Active value, $Res Function(_Active) _then) =
      __$ActiveCopyWithImpl;
  @useResult
  $Res call(
      {ExamSession session,
      int currentQuestionIndex,
      int timeRemainingSeconds,
      bool hasReachedQuestionLimit});
}

/// @nodoc
class __$ActiveCopyWithImpl<$Res> implements _$ActiveCopyWith<$Res> {
  __$ActiveCopyWithImpl(this._self, this._then);

  final _Active _self;
  final $Res Function(_Active) _then;

  /// Create a copy of ExamSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? session = null,
    Object? currentQuestionIndex = null,
    Object? timeRemainingSeconds = null,
    Object? hasReachedQuestionLimit = null,
  }) {
    return _then(_Active(
      session: null == session
          ? _self.session
          : session // ignore: cast_nullable_to_non_nullable
              as ExamSession,
      currentQuestionIndex: null == currentQuestionIndex
          ? _self.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      timeRemainingSeconds: null == timeRemainingSeconds
          ? _self.timeRemainingSeconds
          : timeRemainingSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      hasReachedQuestionLimit: null == hasReachedQuestionLimit
          ? _self.hasReachedQuestionLimit
          : hasReachedQuestionLimit // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _Paused implements ExamSessionState {
  const _Paused(
      {required this.session,
      required this.currentQuestionIndex,
      required this.timeRemainingSeconds,
      this.hasReachedQuestionLimit = false});

  final ExamSession session;
  final int currentQuestionIndex;
  final int timeRemainingSeconds;
  @JsonKey()
  final bool hasReachedQuestionLimit;

  /// Create a copy of ExamSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PausedCopyWith<_Paused> get copyWith =>
      __$PausedCopyWithImpl<_Paused>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Paused &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            (identical(other.timeRemainingSeconds, timeRemainingSeconds) ||
                other.timeRemainingSeconds == timeRemainingSeconds) &&
            (identical(
                    other.hasReachedQuestionLimit, hasReachedQuestionLimit) ||
                other.hasReachedQuestionLimit == hasReachedQuestionLimit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session, currentQuestionIndex,
      timeRemainingSeconds, hasReachedQuestionLimit);

  @override
  String toString() {
    return 'ExamSessionState.paused(session: $session, currentQuestionIndex: $currentQuestionIndex, timeRemainingSeconds: $timeRemainingSeconds, hasReachedQuestionLimit: $hasReachedQuestionLimit)';
  }
}

/// @nodoc
abstract mixin class _$PausedCopyWith<$Res>
    implements $ExamSessionStateCopyWith<$Res> {
  factory _$PausedCopyWith(_Paused value, $Res Function(_Paused) _then) =
      __$PausedCopyWithImpl;
  @useResult
  $Res call(
      {ExamSession session,
      int currentQuestionIndex,
      int timeRemainingSeconds,
      bool hasReachedQuestionLimit});
}

/// @nodoc
class __$PausedCopyWithImpl<$Res> implements _$PausedCopyWith<$Res> {
  __$PausedCopyWithImpl(this._self, this._then);

  final _Paused _self;
  final $Res Function(_Paused) _then;

  /// Create a copy of ExamSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? session = null,
    Object? currentQuestionIndex = null,
    Object? timeRemainingSeconds = null,
    Object? hasReachedQuestionLimit = null,
  }) {
    return _then(_Paused(
      session: null == session
          ? _self.session
          : session // ignore: cast_nullable_to_non_nullable
              as ExamSession,
      currentQuestionIndex: null == currentQuestionIndex
          ? _self.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      timeRemainingSeconds: null == timeRemainingSeconds
          ? _self.timeRemainingSeconds
          : timeRemainingSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      hasReachedQuestionLimit: null == hasReachedQuestionLimit
          ? _self.hasReachedQuestionLimit
          : hasReachedQuestionLimit // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _Completed implements ExamSessionState {
  const _Completed({required this.session, required this.currentQuestionIndex});

  final ExamSession session;
  final int currentQuestionIndex;

  /// Create a copy of ExamSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CompletedCopyWith<_Completed> get copyWith =>
      __$CompletedCopyWithImpl<_Completed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Completed &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session, currentQuestionIndex);

  @override
  String toString() {
    return 'ExamSessionState.completed(session: $session, currentQuestionIndex: $currentQuestionIndex)';
  }
}

/// @nodoc
abstract mixin class _$CompletedCopyWith<$Res>
    implements $ExamSessionStateCopyWith<$Res> {
  factory _$CompletedCopyWith(
          _Completed value, $Res Function(_Completed) _then) =
      __$CompletedCopyWithImpl;
  @useResult
  $Res call({ExamSession session, int currentQuestionIndex});
}

/// @nodoc
class __$CompletedCopyWithImpl<$Res> implements _$CompletedCopyWith<$Res> {
  __$CompletedCopyWithImpl(this._self, this._then);

  final _Completed _self;
  final $Res Function(_Completed) _then;

  /// Create a copy of ExamSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? session = null,
    Object? currentQuestionIndex = null,
  }) {
    return _then(_Completed(
      session: null == session
          ? _self.session
          : session // ignore: cast_nullable_to_non_nullable
              as ExamSession,
      currentQuestionIndex: null == currentQuestionIndex
          ? _self.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _Abandoned implements ExamSessionState {
  const _Abandoned({required this.session});

  final ExamSession session;

  /// Create a copy of ExamSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AbandonedCopyWith<_Abandoned> get copyWith =>
      __$AbandonedCopyWithImpl<_Abandoned>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Abandoned &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  @override
  String toString() {
    return 'ExamSessionState.abandoned(session: $session)';
  }
}

/// @nodoc
abstract mixin class _$AbandonedCopyWith<$Res>
    implements $ExamSessionStateCopyWith<$Res> {
  factory _$AbandonedCopyWith(
          _Abandoned value, $Res Function(_Abandoned) _then) =
      __$AbandonedCopyWithImpl;
  @useResult
  $Res call({ExamSession session});
}

/// @nodoc
class __$AbandonedCopyWithImpl<$Res> implements _$AbandonedCopyWith<$Res> {
  __$AbandonedCopyWithImpl(this._self, this._then);

  final _Abandoned _self;
  final $Res Function(_Abandoned) _then;

  /// Create a copy of ExamSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? session = null,
  }) {
    return _then(_Abandoned(
      session: null == session
          ? _self.session
          : session // ignore: cast_nullable_to_non_nullable
              as ExamSession,
    ));
  }
}

// dart format on
