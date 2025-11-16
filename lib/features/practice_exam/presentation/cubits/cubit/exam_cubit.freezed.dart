// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExamState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExamState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExamState()';
  }
}

/// @nodoc
class $ExamStateCopyWith<$Res> {
  $ExamStateCopyWith(ExamState _, $Res Function(ExamState) __);
}

/// Adds pattern-matching-related methods to [ExamState].
extension ExamStatePatterns on ExamState {
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
    TResult Function(_ModeSelected value)? modeSelected,
    TResult Function(_Loading value)? loading,
    TResult Function(_HasData value)? hasData,
    TResult Function(_Completed value)? completed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _ModeSelected() when modeSelected != null:
        return modeSelected(_that);
      case _Loading() when loading != null:
        return loading(_that);
      case _HasData() when hasData != null:
        return hasData(_that);
      case _Completed() when completed != null:
        return completed(_that);
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
    required TResult Function(_ModeSelected value) modeSelected,
    required TResult Function(_Loading value) loading,
    required TResult Function(_HasData value) hasData,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Error value) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial(_that);
      case _ModeSelected():
        return modeSelected(_that);
      case _Loading():
        return loading(_that);
      case _HasData():
        return hasData(_that);
      case _Completed():
        return completed(_that);
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
    TResult? Function(_ModeSelected value)? modeSelected,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_HasData value)? hasData,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Error value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _ModeSelected() when modeSelected != null:
        return modeSelected(_that);
      case _Loading() when loading != null:
        return loading(_that);
      case _HasData() when hasData != null:
        return hasData(_that);
      case _Completed() when completed != null:
        return completed(_that);
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
    TResult Function(
            ExamMode examMode,
            Map<String, List<String>>? selectedSubjectAndTopic,
            String? selectedSubject,
            List<String> selectedSubjectTopics)?
        modeSelected,
    TResult Function()? loading,
    TResult Function(ExamMode examMode, List<String> selectedSubjects,
            List<ExamSession> examSessions, ExamSession currentSession)?
        hasData,
    TResult Function(
            List<ExamSession> examSessions, ExamSession completedSession)?
        completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _ModeSelected() when modeSelected != null:
        return modeSelected(_that.examMode, _that.selectedSubjectAndTopic,
            _that.selectedSubject, _that.selectedSubjectTopics);
      case _Loading() when loading != null:
        return loading();
      case _HasData() when hasData != null:
        return hasData(_that.examMode, _that.selectedSubjects,
            _that.examSessions, _that.currentSession);
      case _Completed() when completed != null:
        return completed(_that.examSessions, _that.completedSession);
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
    required TResult Function(
            ExamMode examMode,
            Map<String, List<String>>? selectedSubjectAndTopic,
            String? selectedSubject,
            List<String> selectedSubjectTopics)
        modeSelected,
    required TResult Function() loading,
    required TResult Function(ExamMode examMode, List<String> selectedSubjects,
            List<ExamSession> examSessions, ExamSession currentSession)
        hasData,
    required TResult Function(
            List<ExamSession> examSessions, ExamSession completedSession)
        completed,
    required TResult Function(String message) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _ModeSelected():
        return modeSelected(_that.examMode, _that.selectedSubjectAndTopic,
            _that.selectedSubject, _that.selectedSubjectTopics);
      case _Loading():
        return loading();
      case _HasData():
        return hasData(_that.examMode, _that.selectedSubjects,
            _that.examSessions, _that.currentSession);
      case _Completed():
        return completed(_that.examSessions, _that.completedSession);
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
    TResult? Function(
            ExamMode examMode,
            Map<String, List<String>>? selectedSubjectAndTopic,
            String? selectedSubject,
            List<String> selectedSubjectTopics)?
        modeSelected,
    TResult? Function()? loading,
    TResult? Function(ExamMode examMode, List<String> selectedSubjects,
            List<ExamSession> examSessions, ExamSession currentSession)?
        hasData,
    TResult? Function(
            List<ExamSession> examSessions, ExamSession completedSession)?
        completed,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _ModeSelected() when modeSelected != null:
        return modeSelected(_that.examMode, _that.selectedSubjectAndTopic,
            _that.selectedSubject, _that.selectedSubjectTopics);
      case _Loading() when loading != null:
        return loading();
      case _HasData() when hasData != null:
        return hasData(_that.examMode, _that.selectedSubjects,
            _that.examSessions, _that.currentSession);
      case _Completed() when completed != null:
        return completed(_that.examSessions, _that.completedSession);
      case _Error() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements ExamState {
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
    return 'ExamState.initial()';
  }
}

/// @nodoc

class _ModeSelected implements ExamState {
  const _ModeSelected(
      {required this.examMode,
      final Map<String, List<String>>? selectedSubjectAndTopic,
      this.selectedSubject,
      required final List<String> selectedSubjectTopics})
      : _selectedSubjectAndTopic = selectedSubjectAndTopic,
        _selectedSubjectTopics = selectedSubjectTopics;

  final ExamMode examMode;
  final Map<String, List<String>>? _selectedSubjectAndTopic;
  Map<String, List<String>>? get selectedSubjectAndTopic {
    final value = _selectedSubjectAndTopic;
    if (value == null) return null;
    if (_selectedSubjectAndTopic is EqualUnmodifiableMapView)
      return _selectedSubjectAndTopic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final String? selectedSubject;
// Add this field
  final List<String> _selectedSubjectTopics;
// Add this field
  List<String> get selectedSubjectTopics {
    if (_selectedSubjectTopics is EqualUnmodifiableListView)
      return _selectedSubjectTopics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedSubjectTopics);
  }

  /// Create a copy of ExamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ModeSelectedCopyWith<_ModeSelected> get copyWith =>
      __$ModeSelectedCopyWithImpl<_ModeSelected>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ModeSelected &&
            (identical(other.examMode, examMode) ||
                other.examMode == examMode) &&
            const DeepCollectionEquality().equals(
                other._selectedSubjectAndTopic, _selectedSubjectAndTopic) &&
            (identical(other.selectedSubject, selectedSubject) ||
                other.selectedSubject == selectedSubject) &&
            const DeepCollectionEquality()
                .equals(other._selectedSubjectTopics, _selectedSubjectTopics));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      examMode,
      const DeepCollectionEquality().hash(_selectedSubjectAndTopic),
      selectedSubject,
      const DeepCollectionEquality().hash(_selectedSubjectTopics));

  @override
  String toString() {
    return 'ExamState.modeSelected(examMode: $examMode, selectedSubjectAndTopic: $selectedSubjectAndTopic, selectedSubject: $selectedSubject, selectedSubjectTopics: $selectedSubjectTopics)';
  }
}

/// @nodoc
abstract mixin class _$ModeSelectedCopyWith<$Res>
    implements $ExamStateCopyWith<$Res> {
  factory _$ModeSelectedCopyWith(
          _ModeSelected value, $Res Function(_ModeSelected) _then) =
      __$ModeSelectedCopyWithImpl;
  @useResult
  $Res call(
      {ExamMode examMode,
      Map<String, List<String>>? selectedSubjectAndTopic,
      String? selectedSubject,
      List<String> selectedSubjectTopics});
}

/// @nodoc
class __$ModeSelectedCopyWithImpl<$Res>
    implements _$ModeSelectedCopyWith<$Res> {
  __$ModeSelectedCopyWithImpl(this._self, this._then);

  final _ModeSelected _self;
  final $Res Function(_ModeSelected) _then;

  /// Create a copy of ExamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? examMode = null,
    Object? selectedSubjectAndTopic = freezed,
    Object? selectedSubject = freezed,
    Object? selectedSubjectTopics = null,
  }) {
    return _then(_ModeSelected(
      examMode: null == examMode
          ? _self.examMode
          : examMode // ignore: cast_nullable_to_non_nullable
              as ExamMode,
      selectedSubjectAndTopic: freezed == selectedSubjectAndTopic
          ? _self._selectedSubjectAndTopic
          : selectedSubjectAndTopic // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>?,
      selectedSubject: freezed == selectedSubject
          ? _self.selectedSubject
          : selectedSubject // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedSubjectTopics: null == selectedSubjectTopics
          ? _self._selectedSubjectTopics
          : selectedSubjectTopics // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _Loading implements ExamState {
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
    return 'ExamState.loading()';
  }
}

/// @nodoc

class _HasData implements ExamState {
  const _HasData(
      {required this.examMode,
      required final List<String> selectedSubjects,
      required final List<ExamSession> examSessions,
      required this.currentSession})
      : _selectedSubjects = selectedSubjects,
        _examSessions = examSessions;

  final ExamMode examMode;
  final List<String> _selectedSubjects;
  List<String> get selectedSubjects {
    if (_selectedSubjects is EqualUnmodifiableListView)
      return _selectedSubjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedSubjects);
  }

  final List<ExamSession> _examSessions;
  List<ExamSession> get examSessions {
    if (_examSessions is EqualUnmodifiableListView) return _examSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examSessions);
  }

  final ExamSession currentSession;

  /// Create a copy of ExamState
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
            (identical(other.examMode, examMode) ||
                other.examMode == examMode) &&
            const DeepCollectionEquality()
                .equals(other._selectedSubjects, _selectedSubjects) &&
            const DeepCollectionEquality()
                .equals(other._examSessions, _examSessions) &&
            (identical(other.currentSession, currentSession) ||
                other.currentSession == currentSession));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      examMode,
      const DeepCollectionEquality().hash(_selectedSubjects),
      const DeepCollectionEquality().hash(_examSessions),
      currentSession);

  @override
  String toString() {
    return 'ExamState.hasData(examMode: $examMode, selectedSubjects: $selectedSubjects, examSessions: $examSessions, currentSession: $currentSession)';
  }
}

/// @nodoc
abstract mixin class _$HasDataCopyWith<$Res>
    implements $ExamStateCopyWith<$Res> {
  factory _$HasDataCopyWith(_HasData value, $Res Function(_HasData) _then) =
      __$HasDataCopyWithImpl;
  @useResult
  $Res call(
      {ExamMode examMode,
      List<String> selectedSubjects,
      List<ExamSession> examSessions,
      ExamSession currentSession});
}

/// @nodoc
class __$HasDataCopyWithImpl<$Res> implements _$HasDataCopyWith<$Res> {
  __$HasDataCopyWithImpl(this._self, this._then);

  final _HasData _self;
  final $Res Function(_HasData) _then;

  /// Create a copy of ExamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? examMode = null,
    Object? selectedSubjects = null,
    Object? examSessions = null,
    Object? currentSession = null,
  }) {
    return _then(_HasData(
      examMode: null == examMode
          ? _self.examMode
          : examMode // ignore: cast_nullable_to_non_nullable
              as ExamMode,
      selectedSubjects: null == selectedSubjects
          ? _self._selectedSubjects
          : selectedSubjects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      examSessions: null == examSessions
          ? _self._examSessions
          : examSessions // ignore: cast_nullable_to_non_nullable
              as List<ExamSession>,
      currentSession: null == currentSession
          ? _self.currentSession
          : currentSession // ignore: cast_nullable_to_non_nullable
              as ExamSession,
    ));
  }
}

/// @nodoc

class _Completed implements ExamState {
  const _Completed(
      {required final List<ExamSession> examSessions,
      required this.completedSession})
      : _examSessions = examSessions;

  final List<ExamSession> _examSessions;
  List<ExamSession> get examSessions {
    if (_examSessions is EqualUnmodifiableListView) return _examSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examSessions);
  }

  final ExamSession completedSession;

  /// Create a copy of ExamState
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
            const DeepCollectionEquality()
                .equals(other._examSessions, _examSessions) &&
            (identical(other.completedSession, completedSession) ||
                other.completedSession == completedSession));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_examSessions), completedSession);

  @override
  String toString() {
    return 'ExamState.completed(examSessions: $examSessions, completedSession: $completedSession)';
  }
}

/// @nodoc
abstract mixin class _$CompletedCopyWith<$Res>
    implements $ExamStateCopyWith<$Res> {
  factory _$CompletedCopyWith(
          _Completed value, $Res Function(_Completed) _then) =
      __$CompletedCopyWithImpl;
  @useResult
  $Res call({List<ExamSession> examSessions, ExamSession completedSession});
}

/// @nodoc
class __$CompletedCopyWithImpl<$Res> implements _$CompletedCopyWith<$Res> {
  __$CompletedCopyWithImpl(this._self, this._then);

  final _Completed _self;
  final $Res Function(_Completed) _then;

  /// Create a copy of ExamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? examSessions = null,
    Object? completedSession = null,
  }) {
    return _then(_Completed(
      examSessions: null == examSessions
          ? _self._examSessions
          : examSessions // ignore: cast_nullable_to_non_nullable
              as List<ExamSession>,
      completedSession: null == completedSession
          ? _self.completedSession
          : completedSession // ignore: cast_nullable_to_non_nullable
              as ExamSession,
    ));
  }
}

/// @nodoc

class _Error implements ExamState {
  const _Error({required this.message});

  final String message;

  /// Create a copy of ExamState
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
    return 'ExamState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ExamStateCopyWith<$Res> {
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

  /// Create a copy of ExamState
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
