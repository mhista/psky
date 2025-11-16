// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_exam_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiExamState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AiExamState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AiExamState()';
  }
}

/// @nodoc
class $AiExamStateCopyWith<$Res> {
  $AiExamStateCopyWith(AiExamState _, $Res Function(AiExamState) __);
}

/// Adds pattern-matching-related methods to [AiExamState].
extension AiExamStatePatterns on AiExamState {
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
    TResult Function(_Loading value)? loading,
    TResult Function(_HasData value)? hasData,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Loading() when loading != null:
        return loading(_that);
      case _HasData() when hasData != null:
        return hasData(_that);
      case _Error() when error != null:
        return error(_that);
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_HasData value) hasData,
    required TResult Function(_Error value) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial(_that);
      case _Loading():
        return loading(_that);
      case _HasData():
        return hasData(_that);
      case _Error():
        return error(_that);
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
    TResult? Function(_Loading value)? loading,
    TResult? Function(_HasData value)? hasData,
    TResult? Function(_Error value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Loading() when loading != null:
        return loading(_that);
      case _HasData() when hasData != null:
        return hasData(_that);
      case _Error() when error != null:
        return error(_that);
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
    TResult Function()? loading,
    TResult Function(
            AiQuestionData activeExam,
            List<AiQuestionData> allExams,
            int currentIndex,
            int? currentNumberOfQuestionsGenerated,
            int lastFetchThreshold,
            bool didFetchAnyExam)?
        hasData,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _HasData() when hasData != null:
        return hasData(
            _that.activeExam,
            _that.allExams,
            _that.currentIndex,
            _that.currentNumberOfQuestionsGenerated,
            _that.lastFetchThreshold,
            _that.didFetchAnyExam);
      case _Error() when error != null:
        return error(_that.message);
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
    required TResult Function() loading,
    required TResult Function(
            AiQuestionData activeExam,
            List<AiQuestionData> allExams,
            int currentIndex,
            int? currentNumberOfQuestionsGenerated,
            int lastFetchThreshold,
            bool didFetchAnyExam)
        hasData,
    required TResult Function(String message) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _Loading():
        return loading();
      case _HasData():
        return hasData(
            _that.activeExam,
            _that.allExams,
            _that.currentIndex,
            _that.currentNumberOfQuestionsGenerated,
            _that.lastFetchThreshold,
            _that.didFetchAnyExam);
      case _Error():
        return error(_that.message);
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
    TResult? Function()? loading,
    TResult? Function(
            AiQuestionData activeExam,
            List<AiQuestionData> allExams,
            int currentIndex,
            int? currentNumberOfQuestionsGenerated,
            int lastFetchThreshold,
            bool didFetchAnyExam)?
        hasData,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _HasData() when hasData != null:
        return hasData(
            _that.activeExam,
            _that.allExams,
            _that.currentIndex,
            _that.currentNumberOfQuestionsGenerated,
            _that.lastFetchThreshold,
            _that.didFetchAnyExam);
      case _Error() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements AiExamState {
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
    return 'AiExamState.initial()';
  }
}

/// @nodoc

class _Loading implements AiExamState {
  const _Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AiExamState.loading()';
  }
}

/// @nodoc

class _HasData implements AiExamState {
  const _HasData(
      {required this.activeExam,
      required final List<AiQuestionData> allExams,
      required this.currentIndex,
      this.currentNumberOfQuestionsGenerated,
      this.lastFetchThreshold = 0,
      this.didFetchAnyExam = false})
      : _allExams = allExams;

  final AiQuestionData activeExam;
  final List<AiQuestionData> _allExams;
  List<AiQuestionData> get allExams {
    if (_allExams is EqualUnmodifiableListView) return _allExams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allExams);
  }

  final int currentIndex;
  final int? currentNumberOfQuestionsGenerated;
  @JsonKey()
  final int lastFetchThreshold;
// Track when we last fetched
  @JsonKey()
  final bool didFetchAnyExam;

  /// Create a copy of AiExamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HasDataCopyWith<_HasData> get copyWith =>
      __$HasDataCopyWithImpl<_HasData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HasData &&
            (identical(other.activeExam, activeExam) ||
                other.activeExam == activeExam) &&
            const DeepCollectionEquality().equals(other._allExams, _allExams) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.currentNumberOfQuestionsGenerated,
                    currentNumberOfQuestionsGenerated) ||
                other.currentNumberOfQuestionsGenerated ==
                    currentNumberOfQuestionsGenerated) &&
            (identical(other.lastFetchThreshold, lastFetchThreshold) ||
                other.lastFetchThreshold == lastFetchThreshold) &&
            (identical(other.didFetchAnyExam, didFetchAnyExam) ||
                other.didFetchAnyExam == didFetchAnyExam));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      activeExam,
      const DeepCollectionEquality().hash(_allExams),
      currentIndex,
      currentNumberOfQuestionsGenerated,
      lastFetchThreshold,
      didFetchAnyExam);

  @override
  String toString() {
    return 'AiExamState.hasData(activeExam: $activeExam, allExams: $allExams, currentIndex: $currentIndex, currentNumberOfQuestionsGenerated: $currentNumberOfQuestionsGenerated, lastFetchThreshold: $lastFetchThreshold, didFetchAnyExam: $didFetchAnyExam)';
  }
}

/// @nodoc
abstract mixin class _$HasDataCopyWith<$Res>
    implements $AiExamStateCopyWith<$Res> {
  factory _$HasDataCopyWith(_HasData value, $Res Function(_HasData) _then) =
      __$HasDataCopyWithImpl;
  @useResult
  $Res call(
      {AiQuestionData activeExam,
      List<AiQuestionData> allExams,
      int currentIndex,
      int? currentNumberOfQuestionsGenerated,
      int lastFetchThreshold,
      bool didFetchAnyExam});
}

/// @nodoc
class __$HasDataCopyWithImpl<$Res> implements _$HasDataCopyWith<$Res> {
  __$HasDataCopyWithImpl(this._self, this._then);

  final _HasData _self;
  final $Res Function(_HasData) _then;

  /// Create a copy of AiExamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? activeExam = null,
    Object? allExams = null,
    Object? currentIndex = null,
    Object? currentNumberOfQuestionsGenerated = freezed,
    Object? lastFetchThreshold = null,
    Object? didFetchAnyExam = null,
  }) {
    return _then(_HasData(
      activeExam: null == activeExam
          ? _self.activeExam
          : activeExam // ignore: cast_nullable_to_non_nullable
              as AiQuestionData,
      allExams: null == allExams
          ? _self._allExams
          : allExams // ignore: cast_nullable_to_non_nullable
              as List<AiQuestionData>,
      currentIndex: null == currentIndex
          ? _self.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      currentNumberOfQuestionsGenerated: freezed ==
              currentNumberOfQuestionsGenerated
          ? _self.currentNumberOfQuestionsGenerated
          : currentNumberOfQuestionsGenerated // ignore: cast_nullable_to_non_nullable
              as int?,
      lastFetchThreshold: null == lastFetchThreshold
          ? _self.lastFetchThreshold
          : lastFetchThreshold // ignore: cast_nullable_to_non_nullable
              as int,
      didFetchAnyExam: null == didFetchAnyExam
          ? _self.didFetchAnyExam
          : didFetchAnyExam // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _Error implements AiExamState {
  const _Error({required this.message});

  final String message;

  /// Create a copy of AiExamState
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
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AiExamState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res>
    implements $AiExamStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) =
      __$ErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

  /// Create a copy of AiExamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_Error(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
