// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaderboardEntry {
  String get userId;
  String get displayName;
  String? get avatarUrl;
  double get overallScore;
  Map<String, double> get subjectScores;
  int get totalExamsCompleted;
  int get totalQuestionsAnswered;
  int get totalCorrectAnswers;
  DateTime get lastUpdated;
  int get streak;
  Map<String, dynamic>? get metadata;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaderboardEntryCopyWith<LeaderboardEntry> get copyWith =>
      _$LeaderboardEntryCopyWithImpl<LeaderboardEntry>(
          this as LeaderboardEntry, _$identity);

  /// Serializes this LeaderboardEntry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaderboardEntry &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore) &&
            const DeepCollectionEquality()
                .equals(other.subjectScores, subjectScores) &&
            (identical(other.totalExamsCompleted, totalExamsCompleted) ||
                other.totalExamsCompleted == totalExamsCompleted) &&
            (identical(other.totalQuestionsAnswered, totalQuestionsAnswered) ||
                other.totalQuestionsAnswered == totalQuestionsAnswered) &&
            (identical(other.totalCorrectAnswers, totalCorrectAnswers) ||
                other.totalCorrectAnswers == totalCorrectAnswers) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      displayName,
      avatarUrl,
      overallScore,
      const DeepCollectionEquality().hash(subjectScores),
      totalExamsCompleted,
      totalQuestionsAnswered,
      totalCorrectAnswers,
      lastUpdated,
      streak,
      const DeepCollectionEquality().hash(metadata));

  @override
  String toString() {
    return 'LeaderboardEntry(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, overallScore: $overallScore, subjectScores: $subjectScores, totalExamsCompleted: $totalExamsCompleted, totalQuestionsAnswered: $totalQuestionsAnswered, totalCorrectAnswers: $totalCorrectAnswers, lastUpdated: $lastUpdated, streak: $streak, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $LeaderboardEntryCopyWith<$Res> {
  factory $LeaderboardEntryCopyWith(
          LeaderboardEntry value, $Res Function(LeaderboardEntry) _then) =
      _$LeaderboardEntryCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? avatarUrl,
      double overallScore,
      Map<String, double> subjectScores,
      int totalExamsCompleted,
      int totalQuestionsAnswered,
      int totalCorrectAnswers,
      DateTime lastUpdated,
      int streak,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$LeaderboardEntryCopyWithImpl<$Res>
    implements $LeaderboardEntryCopyWith<$Res> {
  _$LeaderboardEntryCopyWithImpl(this._self, this._then);

  final LeaderboardEntry _self;
  final $Res Function(LeaderboardEntry) _then;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? overallScore = null,
    Object? subjectScores = null,
    Object? totalExamsCompleted = null,
    Object? totalQuestionsAnswered = null,
    Object? totalCorrectAnswers = null,
    Object? lastUpdated = null,
    Object? streak = null,
    Object? metadata = freezed,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      overallScore: null == overallScore
          ? _self.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
      subjectScores: null == subjectScores
          ? _self.subjectScores
          : subjectScores // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      totalExamsCompleted: null == totalExamsCompleted
          ? _self.totalExamsCompleted
          : totalExamsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuestionsAnswered: null == totalQuestionsAnswered
          ? _self.totalQuestionsAnswered
          : totalQuestionsAnswered // ignore: cast_nullable_to_non_nullable
              as int,
      totalCorrectAnswers: null == totalCorrectAnswers
          ? _self.totalCorrectAnswers
          : totalCorrectAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      streak: null == streak
          ? _self.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: freezed == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LeaderboardEntry].
extension LeaderboardEntryPatterns on LeaderboardEntry {
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
    TResult Function(_LeaderboardEntry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntry() when $default != null:
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
    TResult Function(_LeaderboardEntry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntry():
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
    TResult? Function(_LeaderboardEntry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntry() when $default != null:
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
    TResult Function(
            String userId,
            String displayName,
            String? avatarUrl,
            double overallScore,
            Map<String, double> subjectScores,
            int totalExamsCompleted,
            int totalQuestionsAnswered,
            int totalCorrectAnswers,
            DateTime lastUpdated,
            int streak,
            Map<String, dynamic>? metadata)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntry() when $default != null:
        return $default(
            _that.userId,
            _that.displayName,
            _that.avatarUrl,
            _that.overallScore,
            _that.subjectScores,
            _that.totalExamsCompleted,
            _that.totalQuestionsAnswered,
            _that.totalCorrectAnswers,
            _that.lastUpdated,
            _that.streak,
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
    TResult Function(
            String userId,
            String displayName,
            String? avatarUrl,
            double overallScore,
            Map<String, double> subjectScores,
            int totalExamsCompleted,
            int totalQuestionsAnswered,
            int totalCorrectAnswers,
            DateTime lastUpdated,
            int streak,
            Map<String, dynamic>? metadata)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntry():
        return $default(
            _that.userId,
            _that.displayName,
            _that.avatarUrl,
            _that.overallScore,
            _that.subjectScores,
            _that.totalExamsCompleted,
            _that.totalQuestionsAnswered,
            _that.totalCorrectAnswers,
            _that.lastUpdated,
            _that.streak,
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
    TResult? Function(
            String userId,
            String displayName,
            String? avatarUrl,
            double overallScore,
            Map<String, double> subjectScores,
            int totalExamsCompleted,
            int totalQuestionsAnswered,
            int totalCorrectAnswers,
            DateTime lastUpdated,
            int streak,
            Map<String, dynamic>? metadata)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardEntry() when $default != null:
        return $default(
            _that.userId,
            _that.displayName,
            _that.avatarUrl,
            _that.overallScore,
            _that.subjectScores,
            _that.totalExamsCompleted,
            _that.totalQuestionsAnswered,
            _that.totalCorrectAnswers,
            _that.lastUpdated,
            _that.streak,
            _that.metadata);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LeaderboardEntry extends LeaderboardEntry {
  const _LeaderboardEntry(
      {required this.userId,
      required this.displayName,
      this.avatarUrl,
      required this.overallScore,
      required final Map<String, double> subjectScores,
      required this.totalExamsCompleted,
      required this.totalQuestionsAnswered,
      required this.totalCorrectAnswers,
      required this.lastUpdated,
      this.streak = 0,
      final Map<String, dynamic>? metadata})
      : _subjectScores = subjectScores,
        _metadata = metadata,
        super._();
  factory _LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? avatarUrl;
  @override
  final double overallScore;
  final Map<String, double> _subjectScores;
  @override
  Map<String, double> get subjectScores {
    if (_subjectScores is EqualUnmodifiableMapView) return _subjectScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_subjectScores);
  }

  @override
  final int totalExamsCompleted;
  @override
  final int totalQuestionsAnswered;
  @override
  final int totalCorrectAnswers;
  @override
  final DateTime lastUpdated;
  @override
  @JsonKey()
  final int streak;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaderboardEntryCopyWith<_LeaderboardEntry> get copyWith =>
      __$LeaderboardEntryCopyWithImpl<_LeaderboardEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeaderboardEntryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaderboardEntry &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore) &&
            const DeepCollectionEquality()
                .equals(other._subjectScores, _subjectScores) &&
            (identical(other.totalExamsCompleted, totalExamsCompleted) ||
                other.totalExamsCompleted == totalExamsCompleted) &&
            (identical(other.totalQuestionsAnswered, totalQuestionsAnswered) ||
                other.totalQuestionsAnswered == totalQuestionsAnswered) &&
            (identical(other.totalCorrectAnswers, totalCorrectAnswers) ||
                other.totalCorrectAnswers == totalCorrectAnswers) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      displayName,
      avatarUrl,
      overallScore,
      const DeepCollectionEquality().hash(_subjectScores),
      totalExamsCompleted,
      totalQuestionsAnswered,
      totalCorrectAnswers,
      lastUpdated,
      streak,
      const DeepCollectionEquality().hash(_metadata));

  @override
  String toString() {
    return 'LeaderboardEntry(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, overallScore: $overallScore, subjectScores: $subjectScores, totalExamsCompleted: $totalExamsCompleted, totalQuestionsAnswered: $totalQuestionsAnswered, totalCorrectAnswers: $totalCorrectAnswers, lastUpdated: $lastUpdated, streak: $streak, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$LeaderboardEntryCopyWith<$Res>
    implements $LeaderboardEntryCopyWith<$Res> {
  factory _$LeaderboardEntryCopyWith(
          _LeaderboardEntry value, $Res Function(_LeaderboardEntry) _then) =
      __$LeaderboardEntryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? avatarUrl,
      double overallScore,
      Map<String, double> subjectScores,
      int totalExamsCompleted,
      int totalQuestionsAnswered,
      int totalCorrectAnswers,
      DateTime lastUpdated,
      int streak,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$LeaderboardEntryCopyWithImpl<$Res>
    implements _$LeaderboardEntryCopyWith<$Res> {
  __$LeaderboardEntryCopyWithImpl(this._self, this._then);

  final _LeaderboardEntry _self;
  final $Res Function(_LeaderboardEntry) _then;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? overallScore = null,
    Object? subjectScores = null,
    Object? totalExamsCompleted = null,
    Object? totalQuestionsAnswered = null,
    Object? totalCorrectAnswers = null,
    Object? lastUpdated = null,
    Object? streak = null,
    Object? metadata = freezed,
  }) {
    return _then(_LeaderboardEntry(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      overallScore: null == overallScore
          ? _self.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
      subjectScores: null == subjectScores
          ? _self._subjectScores
          : subjectScores // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      totalExamsCompleted: null == totalExamsCompleted
          ? _self.totalExamsCompleted
          : totalExamsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuestionsAnswered: null == totalQuestionsAnswered
          ? _self.totalQuestionsAnswered
          : totalQuestionsAnswered // ignore: cast_nullable_to_non_nullable
              as int,
      totalCorrectAnswers: null == totalCorrectAnswers
          ? _self.totalCorrectAnswers
          : totalCorrectAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      streak: null == streak
          ? _self.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: freezed == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$LeaderboardRank {
  int get rank;
  int get totalUsers;
  double get percentile;

  /// Create a copy of LeaderboardRank
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaderboardRankCopyWith<LeaderboardRank> get copyWith =>
      _$LeaderboardRankCopyWithImpl<LeaderboardRank>(
          this as LeaderboardRank, _$identity);

  /// Serializes this LeaderboardRank to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaderboardRank &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            (identical(other.percentile, percentile) ||
                other.percentile == percentile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rank, totalUsers, percentile);

  @override
  String toString() {
    return 'LeaderboardRank(rank: $rank, totalUsers: $totalUsers, percentile: $percentile)';
  }
}

/// @nodoc
abstract mixin class $LeaderboardRankCopyWith<$Res> {
  factory $LeaderboardRankCopyWith(
          LeaderboardRank value, $Res Function(LeaderboardRank) _then) =
      _$LeaderboardRankCopyWithImpl;
  @useResult
  $Res call({int rank, int totalUsers, double percentile});
}

/// @nodoc
class _$LeaderboardRankCopyWithImpl<$Res>
    implements $LeaderboardRankCopyWith<$Res> {
  _$LeaderboardRankCopyWithImpl(this._self, this._then);

  final LeaderboardRank _self;
  final $Res Function(LeaderboardRank) _then;

  /// Create a copy of LeaderboardRank
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? totalUsers = null,
    Object? percentile = null,
  }) {
    return _then(_self.copyWith(
      rank: null == rank
          ? _self.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      totalUsers: null == totalUsers
          ? _self.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      percentile: null == percentile
          ? _self.percentile
          : percentile // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [LeaderboardRank].
extension LeaderboardRankPatterns on LeaderboardRank {
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
    TResult Function(_LeaderboardRank value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaderboardRank() when $default != null:
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
    TResult Function(_LeaderboardRank value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardRank():
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
    TResult? Function(_LeaderboardRank value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardRank() when $default != null:
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
    TResult Function(int rank, int totalUsers, double percentile)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaderboardRank() when $default != null:
        return $default(_that.rank, _that.totalUsers, _that.percentile);
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
    TResult Function(int rank, int totalUsers, double percentile) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardRank():
        return $default(_that.rank, _that.totalUsers, _that.percentile);
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
    TResult? Function(int rank, int totalUsers, double percentile)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaderboardRank() when $default != null:
        return $default(_that.rank, _that.totalUsers, _that.percentile);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LeaderboardRank extends LeaderboardRank {
  const _LeaderboardRank(
      {required this.rank, required this.totalUsers, required this.percentile})
      : super._();
  factory _LeaderboardRank.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardRankFromJson(json);

  @override
  final int rank;
  @override
  final int totalUsers;
  @override
  final double percentile;

  /// Create a copy of LeaderboardRank
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaderboardRankCopyWith<_LeaderboardRank> get copyWith =>
      __$LeaderboardRankCopyWithImpl<_LeaderboardRank>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeaderboardRankToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaderboardRank &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            (identical(other.percentile, percentile) ||
                other.percentile == percentile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rank, totalUsers, percentile);

  @override
  String toString() {
    return 'LeaderboardRank(rank: $rank, totalUsers: $totalUsers, percentile: $percentile)';
  }
}

/// @nodoc
abstract mixin class _$LeaderboardRankCopyWith<$Res>
    implements $LeaderboardRankCopyWith<$Res> {
  factory _$LeaderboardRankCopyWith(
          _LeaderboardRank value, $Res Function(_LeaderboardRank) _then) =
      __$LeaderboardRankCopyWithImpl;
  @override
  @useResult
  $Res call({int rank, int totalUsers, double percentile});
}

/// @nodoc
class __$LeaderboardRankCopyWithImpl<$Res>
    implements _$LeaderboardRankCopyWith<$Res> {
  __$LeaderboardRankCopyWithImpl(this._self, this._then);

  final _LeaderboardRank _self;
  final $Res Function(_LeaderboardRank) _then;

  /// Create a copy of LeaderboardRank
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? rank = null,
    Object? totalUsers = null,
    Object? percentile = null,
  }) {
    return _then(_LeaderboardRank(
      rank: null == rank
          ? _self.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      totalUsers: null == totalUsers
          ? _self.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      percentile: null == percentile
          ? _self.percentile
          : percentile // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$UserExamStatistics {
  String get userId;
  int get totalSessions;
  int get completedSessions;
  double get averageScore;
  int get totalTimeSpentMinutes;
  DateTime? get lastActive;

  /// Create a copy of UserExamStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserExamStatisticsCopyWith<UserExamStatistics> get copyWith =>
      _$UserExamStatisticsCopyWithImpl<UserExamStatistics>(
          this as UserExamStatistics, _$identity);

  /// Serializes this UserExamStatistics to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserExamStatistics &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.completedSessions, completedSessions) ||
                other.completedSessions == completedSessions) &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.totalTimeSpentMinutes, totalTimeSpentMinutes) ||
                other.totalTimeSpentMinutes == totalTimeSpentMinutes) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, totalSessions,
      completedSessions, averageScore, totalTimeSpentMinutes, lastActive);

  @override
  String toString() {
    return 'UserExamStatistics(userId: $userId, totalSessions: $totalSessions, completedSessions: $completedSessions, averageScore: $averageScore, totalTimeSpentMinutes: $totalTimeSpentMinutes, lastActive: $lastActive)';
  }
}

/// @nodoc
abstract mixin class $UserExamStatisticsCopyWith<$Res> {
  factory $UserExamStatisticsCopyWith(
          UserExamStatistics value, $Res Function(UserExamStatistics) _then) =
      _$UserExamStatisticsCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      int totalSessions,
      int completedSessions,
      double averageScore,
      int totalTimeSpentMinutes,
      DateTime? lastActive});
}

/// @nodoc
class _$UserExamStatisticsCopyWithImpl<$Res>
    implements $UserExamStatisticsCopyWith<$Res> {
  _$UserExamStatisticsCopyWithImpl(this._self, this._then);

  final UserExamStatistics _self;
  final $Res Function(UserExamStatistics) _then;

  /// Create a copy of UserExamStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? totalSessions = null,
    Object? completedSessions = null,
    Object? averageScore = null,
    Object? totalTimeSpentMinutes = null,
    Object? lastActive = freezed,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      totalSessions: null == totalSessions
          ? _self.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      completedSessions: null == completedSessions
          ? _self.completedSessions
          : completedSessions // ignore: cast_nullable_to_non_nullable
              as int,
      averageScore: null == averageScore
          ? _self.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double,
      totalTimeSpentMinutes: null == totalTimeSpentMinutes
          ? _self.totalTimeSpentMinutes
          : totalTimeSpentMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      lastActive: freezed == lastActive
          ? _self.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserExamStatistics].
extension UserExamStatisticsPatterns on UserExamStatistics {
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
    TResult Function(_UserExamStatistics value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserExamStatistics() when $default != null:
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
    TResult Function(_UserExamStatistics value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserExamStatistics():
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
    TResult? Function(_UserExamStatistics value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserExamStatistics() when $default != null:
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
    TResult Function(
            String userId,
            int totalSessions,
            int completedSessions,
            double averageScore,
            int totalTimeSpentMinutes,
            DateTime? lastActive)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserExamStatistics() when $default != null:
        return $default(
            _that.userId,
            _that.totalSessions,
            _that.completedSessions,
            _that.averageScore,
            _that.totalTimeSpentMinutes,
            _that.lastActive);
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
    TResult Function(
            String userId,
            int totalSessions,
            int completedSessions,
            double averageScore,
            int totalTimeSpentMinutes,
            DateTime? lastActive)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserExamStatistics():
        return $default(
            _that.userId,
            _that.totalSessions,
            _that.completedSessions,
            _that.averageScore,
            _that.totalTimeSpentMinutes,
            _that.lastActive);
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
    TResult? Function(
            String userId,
            int totalSessions,
            int completedSessions,
            double averageScore,
            int totalTimeSpentMinutes,
            DateTime? lastActive)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserExamStatistics() when $default != null:
        return $default(
            _that.userId,
            _that.totalSessions,
            _that.completedSessions,
            _that.averageScore,
            _that.totalTimeSpentMinutes,
            _that.lastActive);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserExamStatistics extends UserExamStatistics {
  const _UserExamStatistics(
      {required this.userId,
      required this.totalSessions,
      required this.completedSessions,
      required this.averageScore,
      required this.totalTimeSpentMinutes,
      this.lastActive})
      : super._();
  factory _UserExamStatistics.fromJson(Map<String, dynamic> json) =>
      _$UserExamStatisticsFromJson(json);

  @override
  final String userId;
  @override
  final int totalSessions;
  @override
  final int completedSessions;
  @override
  final double averageScore;
  @override
  final int totalTimeSpentMinutes;
  @override
  final DateTime? lastActive;

  /// Create a copy of UserExamStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserExamStatisticsCopyWith<_UserExamStatistics> get copyWith =>
      __$UserExamStatisticsCopyWithImpl<_UserExamStatistics>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserExamStatisticsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserExamStatistics &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.completedSessions, completedSessions) ||
                other.completedSessions == completedSessions) &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.totalTimeSpentMinutes, totalTimeSpentMinutes) ||
                other.totalTimeSpentMinutes == totalTimeSpentMinutes) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, totalSessions,
      completedSessions, averageScore, totalTimeSpentMinutes, lastActive);

  @override
  String toString() {
    return 'UserExamStatistics(userId: $userId, totalSessions: $totalSessions, completedSessions: $completedSessions, averageScore: $averageScore, totalTimeSpentMinutes: $totalTimeSpentMinutes, lastActive: $lastActive)';
  }
}

/// @nodoc
abstract mixin class _$UserExamStatisticsCopyWith<$Res>
    implements $UserExamStatisticsCopyWith<$Res> {
  factory _$UserExamStatisticsCopyWith(
          _UserExamStatistics value, $Res Function(_UserExamStatistics) _then) =
      __$UserExamStatisticsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      int totalSessions,
      int completedSessions,
      double averageScore,
      int totalTimeSpentMinutes,
      DateTime? lastActive});
}

/// @nodoc
class __$UserExamStatisticsCopyWithImpl<$Res>
    implements _$UserExamStatisticsCopyWith<$Res> {
  __$UserExamStatisticsCopyWithImpl(this._self, this._then);

  final _UserExamStatistics _self;
  final $Res Function(_UserExamStatistics) _then;

  /// Create a copy of UserExamStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? totalSessions = null,
    Object? completedSessions = null,
    Object? averageScore = null,
    Object? totalTimeSpentMinutes = null,
    Object? lastActive = freezed,
  }) {
    return _then(_UserExamStatistics(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      totalSessions: null == totalSessions
          ? _self.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      completedSessions: null == completedSessions
          ? _self.completedSessions
          : completedSessions // ignore: cast_nullable_to_non_nullable
              as int,
      averageScore: null == averageScore
          ? _self.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double,
      totalTimeSpentMinutes: null == totalTimeSpentMinutes
          ? _self.totalTimeSpentMinutes
          : totalTimeSpentMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      lastActive: freezed == lastActive
          ? _self.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$OfflineOperation {
  String get id;
  OperationType get type;
  String get userId;
  Map<String, dynamic> get data;
  DateTime get createdAt;
  int get retryCount;

  /// Create a copy of OfflineOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OfflineOperationCopyWith<OfflineOperation> get copyWith =>
      _$OfflineOperationCopyWithImpl<OfflineOperation>(
          this as OfflineOperation, _$identity);

  /// Serializes this OfflineOperation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OfflineOperation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, userId,
      const DeepCollectionEquality().hash(data), createdAt, retryCount);

  @override
  String toString() {
    return 'OfflineOperation(id: $id, type: $type, userId: $userId, data: $data, createdAt: $createdAt, retryCount: $retryCount)';
  }
}

/// @nodoc
abstract mixin class $OfflineOperationCopyWith<$Res> {
  factory $OfflineOperationCopyWith(
          OfflineOperation value, $Res Function(OfflineOperation) _then) =
      _$OfflineOperationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      OperationType type,
      String userId,
      Map<String, dynamic> data,
      DateTime createdAt,
      int retryCount});
}

/// @nodoc
class _$OfflineOperationCopyWithImpl<$Res>
    implements $OfflineOperationCopyWith<$Res> {
  _$OfflineOperationCopyWithImpl(this._self, this._then);

  final OfflineOperation _self;
  final $Res Function(OfflineOperation) _then;

  /// Create a copy of OfflineOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? userId = null,
    Object? data = null,
    Object? createdAt = null,
    Object? retryCount = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as OperationType,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      retryCount: null == retryCount
          ? _self.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [OfflineOperation].
extension OfflineOperationPatterns on OfflineOperation {
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
    TResult Function(_OfflineOperation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineOperation() when $default != null:
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
    TResult Function(_OfflineOperation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineOperation():
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
    TResult? Function(_OfflineOperation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineOperation() when $default != null:
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
    TResult Function(String id, OperationType type, String userId,
            Map<String, dynamic> data, DateTime createdAt, int retryCount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineOperation() when $default != null:
        return $default(_that.id, _that.type, _that.userId, _that.data,
            _that.createdAt, _that.retryCount);
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
    TResult Function(String id, OperationType type, String userId,
            Map<String, dynamic> data, DateTime createdAt, int retryCount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineOperation():
        return $default(_that.id, _that.type, _that.userId, _that.data,
            _that.createdAt, _that.retryCount);
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
    TResult? Function(String id, OperationType type, String userId,
            Map<String, dynamic> data, DateTime createdAt, int retryCount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineOperation() when $default != null:
        return $default(_that.id, _that.type, _that.userId, _that.data,
            _that.createdAt, _that.retryCount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OfflineOperation extends OfflineOperation {
  const _OfflineOperation(
      {required this.id,
      required this.type,
      required this.userId,
      required final Map<String, dynamic> data,
      required this.createdAt,
      this.retryCount = 0})
      : _data = data,
        super._();
  factory _OfflineOperation.fromJson(Map<String, dynamic> json) =>
      _$OfflineOperationFromJson(json);

  @override
  final String id;
  @override
  final OperationType type;
  @override
  final String userId;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int retryCount;

  /// Create a copy of OfflineOperation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OfflineOperationCopyWith<_OfflineOperation> get copyWith =>
      __$OfflineOperationCopyWithImpl<_OfflineOperation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OfflineOperationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OfflineOperation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, userId,
      const DeepCollectionEquality().hash(_data), createdAt, retryCount);

  @override
  String toString() {
    return 'OfflineOperation(id: $id, type: $type, userId: $userId, data: $data, createdAt: $createdAt, retryCount: $retryCount)';
  }
}

/// @nodoc
abstract mixin class _$OfflineOperationCopyWith<$Res>
    implements $OfflineOperationCopyWith<$Res> {
  factory _$OfflineOperationCopyWith(
          _OfflineOperation value, $Res Function(_OfflineOperation) _then) =
      __$OfflineOperationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      OperationType type,
      String userId,
      Map<String, dynamic> data,
      DateTime createdAt,
      int retryCount});
}

/// @nodoc
class __$OfflineOperationCopyWithImpl<$Res>
    implements _$OfflineOperationCopyWith<$Res> {
  __$OfflineOperationCopyWithImpl(this._self, this._then);

  final _OfflineOperation _self;
  final $Res Function(_OfflineOperation) _then;

  /// Create a copy of OfflineOperation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? userId = null,
    Object? data = null,
    Object? createdAt = null,
    Object? retryCount = null,
  }) {
    return _then(_OfflineOperation(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as OperationType,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      retryCount: null == retryCount
          ? _self.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$SyncResult {
  bool get success;
  int get sessionsSynced;
  int get sessionsSkipped;
  DateTime get syncTime;
  String? get error;
  List<String> get failedSessionIds;

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SyncResultCopyWith<SyncResult> get copyWith =>
      _$SyncResultCopyWithImpl<SyncResult>(this as SyncResult, _$identity);

  /// Serializes this SyncResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SyncResult &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.sessionsSynced, sessionsSynced) ||
                other.sessionsSynced == sessionsSynced) &&
            (identical(other.sessionsSkipped, sessionsSkipped) ||
                other.sessionsSkipped == sessionsSkipped) &&
            (identical(other.syncTime, syncTime) ||
                other.syncTime == syncTime) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other.failedSessionIds, failedSessionIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      sessionsSynced,
      sessionsSkipped,
      syncTime,
      error,
      const DeepCollectionEquality().hash(failedSessionIds));

  @override
  String toString() {
    return 'SyncResult(success: $success, sessionsSynced: $sessionsSynced, sessionsSkipped: $sessionsSkipped, syncTime: $syncTime, error: $error, failedSessionIds: $failedSessionIds)';
  }
}

/// @nodoc
abstract mixin class $SyncResultCopyWith<$Res> {
  factory $SyncResultCopyWith(
          SyncResult value, $Res Function(SyncResult) _then) =
      _$SyncResultCopyWithImpl;
  @useResult
  $Res call(
      {bool success,
      int sessionsSynced,
      int sessionsSkipped,
      DateTime syncTime,
      String? error,
      List<String> failedSessionIds});
}

/// @nodoc
class _$SyncResultCopyWithImpl<$Res> implements $SyncResultCopyWith<$Res> {
  _$SyncResultCopyWithImpl(this._self, this._then);

  final SyncResult _self;
  final $Res Function(SyncResult) _then;

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? sessionsSynced = null,
    Object? sessionsSkipped = null,
    Object? syncTime = null,
    Object? error = freezed,
    Object? failedSessionIds = null,
  }) {
    return _then(_self.copyWith(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      sessionsSynced: null == sessionsSynced
          ? _self.sessionsSynced
          : sessionsSynced // ignore: cast_nullable_to_non_nullable
              as int,
      sessionsSkipped: null == sessionsSkipped
          ? _self.sessionsSkipped
          : sessionsSkipped // ignore: cast_nullable_to_non_nullable
              as int,
      syncTime: null == syncTime
          ? _self.syncTime
          : syncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      failedSessionIds: null == failedSessionIds
          ? _self.failedSessionIds
          : failedSessionIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SyncResult].
extension SyncResultPatterns on SyncResult {
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
    TResult Function(_SyncResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncResult() when $default != null:
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
    TResult Function(_SyncResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncResult():
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
    TResult? Function(_SyncResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncResult() when $default != null:
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
    TResult Function(bool success, int sessionsSynced, int sessionsSkipped,
            DateTime syncTime, String? error, List<String> failedSessionIds)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncResult() when $default != null:
        return $default(
            _that.success,
            _that.sessionsSynced,
            _that.sessionsSkipped,
            _that.syncTime,
            _that.error,
            _that.failedSessionIds);
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
    TResult Function(bool success, int sessionsSynced, int sessionsSkipped,
            DateTime syncTime, String? error, List<String> failedSessionIds)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncResult():
        return $default(
            _that.success,
            _that.sessionsSynced,
            _that.sessionsSkipped,
            _that.syncTime,
            _that.error,
            _that.failedSessionIds);
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
    TResult? Function(bool success, int sessionsSynced, int sessionsSkipped,
            DateTime syncTime, String? error, List<String> failedSessionIds)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncResult() when $default != null:
        return $default(
            _that.success,
            _that.sessionsSynced,
            _that.sessionsSkipped,
            _that.syncTime,
            _that.error,
            _that.failedSessionIds);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SyncResult extends SyncResult {
  const _SyncResult(
      {required this.success,
      required this.sessionsSynced,
      required this.sessionsSkipped,
      required this.syncTime,
      this.error,
      final List<String> failedSessionIds = const []})
      : _failedSessionIds = failedSessionIds,
        super._();
  factory _SyncResult.fromJson(Map<String, dynamic> json) =>
      _$SyncResultFromJson(json);

  @override
  final bool success;
  @override
  final int sessionsSynced;
  @override
  final int sessionsSkipped;
  @override
  final DateTime syncTime;
  @override
  final String? error;
  final List<String> _failedSessionIds;
  @override
  @JsonKey()
  List<String> get failedSessionIds {
    if (_failedSessionIds is EqualUnmodifiableListView)
      return _failedSessionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_failedSessionIds);
  }

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SyncResultCopyWith<_SyncResult> get copyWith =>
      __$SyncResultCopyWithImpl<_SyncResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SyncResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SyncResult &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.sessionsSynced, sessionsSynced) ||
                other.sessionsSynced == sessionsSynced) &&
            (identical(other.sessionsSkipped, sessionsSkipped) ||
                other.sessionsSkipped == sessionsSkipped) &&
            (identical(other.syncTime, syncTime) ||
                other.syncTime == syncTime) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other._failedSessionIds, _failedSessionIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      sessionsSynced,
      sessionsSkipped,
      syncTime,
      error,
      const DeepCollectionEquality().hash(_failedSessionIds));

  @override
  String toString() {
    return 'SyncResult(success: $success, sessionsSynced: $sessionsSynced, sessionsSkipped: $sessionsSkipped, syncTime: $syncTime, error: $error, failedSessionIds: $failedSessionIds)';
  }
}

/// @nodoc
abstract mixin class _$SyncResultCopyWith<$Res>
    implements $SyncResultCopyWith<$Res> {
  factory _$SyncResultCopyWith(
          _SyncResult value, $Res Function(_SyncResult) _then) =
      __$SyncResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool success,
      int sessionsSynced,
      int sessionsSkipped,
      DateTime syncTime,
      String? error,
      List<String> failedSessionIds});
}

/// @nodoc
class __$SyncResultCopyWithImpl<$Res> implements _$SyncResultCopyWith<$Res> {
  __$SyncResultCopyWithImpl(this._self, this._then);

  final _SyncResult _self;
  final $Res Function(_SyncResult) _then;

  /// Create a copy of SyncResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = null,
    Object? sessionsSynced = null,
    Object? sessionsSkipped = null,
    Object? syncTime = null,
    Object? error = freezed,
    Object? failedSessionIds = null,
  }) {
    return _then(_SyncResult(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      sessionsSynced: null == sessionsSynced
          ? _self.sessionsSynced
          : sessionsSynced // ignore: cast_nullable_to_non_nullable
              as int,
      sessionsSkipped: null == sessionsSkipped
          ? _self.sessionsSkipped
          : sessionsSkipped // ignore: cast_nullable_to_non_nullable
              as int,
      syncTime: null == syncTime
          ? _self.syncTime
          : syncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      failedSessionIds: null == failedSessionIds
          ? _self._failedSessionIds
          : failedSessionIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$SyncStatus {
  bool get isSyncing;
  bool get hasUnsyncedChanges;
  DateTime? get lastSyncTime;
  int? get unsyncedCount;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SyncStatusCopyWith<SyncStatus> get copyWith =>
      _$SyncStatusCopyWithImpl<SyncStatus>(this as SyncStatus, _$identity);

  /// Serializes this SyncStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SyncStatus &&
            (identical(other.isSyncing, isSyncing) ||
                other.isSyncing == isSyncing) &&
            (identical(other.hasUnsyncedChanges, hasUnsyncedChanges) ||
                other.hasUnsyncedChanges == hasUnsyncedChanges) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.unsyncedCount, unsyncedCount) ||
                other.unsyncedCount == unsyncedCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, isSyncing, hasUnsyncedChanges, lastSyncTime, unsyncedCount);

  @override
  String toString() {
    return 'SyncStatus(isSyncing: $isSyncing, hasUnsyncedChanges: $hasUnsyncedChanges, lastSyncTime: $lastSyncTime, unsyncedCount: $unsyncedCount)';
  }
}

/// @nodoc
abstract mixin class $SyncStatusCopyWith<$Res> {
  factory $SyncStatusCopyWith(
          SyncStatus value, $Res Function(SyncStatus) _then) =
      _$SyncStatusCopyWithImpl;
  @useResult
  $Res call(
      {bool isSyncing,
      bool hasUnsyncedChanges,
      DateTime? lastSyncTime,
      int? unsyncedCount});
}

/// @nodoc
class _$SyncStatusCopyWithImpl<$Res> implements $SyncStatusCopyWith<$Res> {
  _$SyncStatusCopyWithImpl(this._self, this._then);

  final SyncStatus _self;
  final $Res Function(SyncStatus) _then;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSyncing = null,
    Object? hasUnsyncedChanges = null,
    Object? lastSyncTime = freezed,
    Object? unsyncedCount = freezed,
  }) {
    return _then(_self.copyWith(
      isSyncing: null == isSyncing
          ? _self.isSyncing
          : isSyncing // ignore: cast_nullable_to_non_nullable
              as bool,
      hasUnsyncedChanges: null == hasUnsyncedChanges
          ? _self.hasUnsyncedChanges
          : hasUnsyncedChanges // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncTime: freezed == lastSyncTime
          ? _self.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unsyncedCount: freezed == unsyncedCount
          ? _self.unsyncedCount
          : unsyncedCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SyncStatus].
extension SyncStatusPatterns on SyncStatus {
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
    TResult Function(_SyncStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncStatus() when $default != null:
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
    TResult Function(_SyncStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncStatus():
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
    TResult? Function(_SyncStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncStatus() when $default != null:
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
    TResult Function(bool isSyncing, bool hasUnsyncedChanges,
            DateTime? lastSyncTime, int? unsyncedCount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncStatus() when $default != null:
        return $default(_that.isSyncing, _that.hasUnsyncedChanges,
            _that.lastSyncTime, _that.unsyncedCount);
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
    TResult Function(bool isSyncing, bool hasUnsyncedChanges,
            DateTime? lastSyncTime, int? unsyncedCount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncStatus():
        return $default(_that.isSyncing, _that.hasUnsyncedChanges,
            _that.lastSyncTime, _that.unsyncedCount);
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
    TResult? Function(bool isSyncing, bool hasUnsyncedChanges,
            DateTime? lastSyncTime, int? unsyncedCount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncStatus() when $default != null:
        return $default(_that.isSyncing, _that.hasUnsyncedChanges,
            _that.lastSyncTime, _that.unsyncedCount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SyncStatus extends SyncStatus {
  const _SyncStatus(
      {required this.isSyncing,
      required this.hasUnsyncedChanges,
      this.lastSyncTime,
      this.unsyncedCount})
      : super._();
  factory _SyncStatus.fromJson(Map<String, dynamic> json) =>
      _$SyncStatusFromJson(json);

  @override
  final bool isSyncing;
  @override
  final bool hasUnsyncedChanges;
  @override
  final DateTime? lastSyncTime;
  @override
  final int? unsyncedCount;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SyncStatusCopyWith<_SyncStatus> get copyWith =>
      __$SyncStatusCopyWithImpl<_SyncStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SyncStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SyncStatus &&
            (identical(other.isSyncing, isSyncing) ||
                other.isSyncing == isSyncing) &&
            (identical(other.hasUnsyncedChanges, hasUnsyncedChanges) ||
                other.hasUnsyncedChanges == hasUnsyncedChanges) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.unsyncedCount, unsyncedCount) ||
                other.unsyncedCount == unsyncedCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, isSyncing, hasUnsyncedChanges, lastSyncTime, unsyncedCount);

  @override
  String toString() {
    return 'SyncStatus(isSyncing: $isSyncing, hasUnsyncedChanges: $hasUnsyncedChanges, lastSyncTime: $lastSyncTime, unsyncedCount: $unsyncedCount)';
  }
}

/// @nodoc
abstract mixin class _$SyncStatusCopyWith<$Res>
    implements $SyncStatusCopyWith<$Res> {
  factory _$SyncStatusCopyWith(
          _SyncStatus value, $Res Function(_SyncStatus) _then) =
      __$SyncStatusCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isSyncing,
      bool hasUnsyncedChanges,
      DateTime? lastSyncTime,
      int? unsyncedCount});
}

/// @nodoc
class __$SyncStatusCopyWithImpl<$Res> implements _$SyncStatusCopyWith<$Res> {
  __$SyncStatusCopyWithImpl(this._self, this._then);

  final _SyncStatus _self;
  final $Res Function(_SyncStatus) _then;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isSyncing = null,
    Object? hasUnsyncedChanges = null,
    Object? lastSyncTime = freezed,
    Object? unsyncedCount = freezed,
  }) {
    return _then(_SyncStatus(
      isSyncing: null == isSyncing
          ? _self.isSyncing
          : isSyncing // ignore: cast_nullable_to_non_nullable
              as bool,
      hasUnsyncedChanges: null == hasUnsyncedChanges
          ? _self.hasUnsyncedChanges
          : hasUnsyncedChanges // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncTime: freezed == lastSyncTime
          ? _self.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unsyncedCount: freezed == unsyncedCount
          ? _self.unsyncedCount
          : unsyncedCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$BatchOperationResult {
  int get total;
  int get successful;
  int get failed;
  List<String> get failedIds;
  List<String> get errorMessages;

  /// Create a copy of BatchOperationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BatchOperationResultCopyWith<BatchOperationResult> get copyWith =>
      _$BatchOperationResultCopyWithImpl<BatchOperationResult>(
          this as BatchOperationResult, _$identity);

  /// Serializes this BatchOperationResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BatchOperationResult &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.successful, successful) ||
                other.successful == successful) &&
            (identical(other.failed, failed) || other.failed == failed) &&
            const DeepCollectionEquality().equals(other.failedIds, failedIds) &&
            const DeepCollectionEquality()
                .equals(other.errorMessages, errorMessages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      total,
      successful,
      failed,
      const DeepCollectionEquality().hash(failedIds),
      const DeepCollectionEquality().hash(errorMessages));

  @override
  String toString() {
    return 'BatchOperationResult(total: $total, successful: $successful, failed: $failed, failedIds: $failedIds, errorMessages: $errorMessages)';
  }
}

/// @nodoc
abstract mixin class $BatchOperationResultCopyWith<$Res> {
  factory $BatchOperationResultCopyWith(BatchOperationResult value,
          $Res Function(BatchOperationResult) _then) =
      _$BatchOperationResultCopyWithImpl;
  @useResult
  $Res call(
      {int total,
      int successful,
      int failed,
      List<String> failedIds,
      List<String> errorMessages});
}

/// @nodoc
class _$BatchOperationResultCopyWithImpl<$Res>
    implements $BatchOperationResultCopyWith<$Res> {
  _$BatchOperationResultCopyWithImpl(this._self, this._then);

  final BatchOperationResult _self;
  final $Res Function(BatchOperationResult) _then;

  /// Create a copy of BatchOperationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? successful = null,
    Object? failed = null,
    Object? failedIds = null,
    Object? errorMessages = null,
  }) {
    return _then(_self.copyWith(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      successful: null == successful
          ? _self.successful
          : successful // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _self.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
      failedIds: null == failedIds
          ? _self.failedIds
          : failedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errorMessages: null == errorMessages
          ? _self.errorMessages
          : errorMessages // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BatchOperationResult].
extension BatchOperationResultPatterns on BatchOperationResult {
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
    TResult Function(_BatchOperationResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BatchOperationResult() when $default != null:
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
    TResult Function(_BatchOperationResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BatchOperationResult():
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
    TResult? Function(_BatchOperationResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BatchOperationResult() when $default != null:
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
    TResult Function(int total, int successful, int failed,
            List<String> failedIds, List<String> errorMessages)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BatchOperationResult() when $default != null:
        return $default(_that.total, _that.successful, _that.failed,
            _that.failedIds, _that.errorMessages);
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
    TResult Function(int total, int successful, int failed,
            List<String> failedIds, List<String> errorMessages)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BatchOperationResult():
        return $default(_that.total, _that.successful, _that.failed,
            _that.failedIds, _that.errorMessages);
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
    TResult? Function(int total, int successful, int failed,
            List<String> failedIds, List<String> errorMessages)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BatchOperationResult() when $default != null:
        return $default(_that.total, _that.successful, _that.failed,
            _that.failedIds, _that.errorMessages);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BatchOperationResult extends BatchOperationResult {
  const _BatchOperationResult(
      {required this.total,
      required this.successful,
      required this.failed,
      final List<String> failedIds = const [],
      final List<String> errorMessages = const []})
      : _failedIds = failedIds,
        _errorMessages = errorMessages,
        super._();
  factory _BatchOperationResult.fromJson(Map<String, dynamic> json) =>
      _$BatchOperationResultFromJson(json);

  @override
  final int total;
  @override
  final int successful;
  @override
  final int failed;
  final List<String> _failedIds;
  @override
  @JsonKey()
  List<String> get failedIds {
    if (_failedIds is EqualUnmodifiableListView) return _failedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_failedIds);
  }

  final List<String> _errorMessages;
  @override
  @JsonKey()
  List<String> get errorMessages {
    if (_errorMessages is EqualUnmodifiableListView) return _errorMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errorMessages);
  }

  /// Create a copy of BatchOperationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BatchOperationResultCopyWith<_BatchOperationResult> get copyWith =>
      __$BatchOperationResultCopyWithImpl<_BatchOperationResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BatchOperationResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BatchOperationResult &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.successful, successful) ||
                other.successful == successful) &&
            (identical(other.failed, failed) || other.failed == failed) &&
            const DeepCollectionEquality()
                .equals(other._failedIds, _failedIds) &&
            const DeepCollectionEquality()
                .equals(other._errorMessages, _errorMessages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      total,
      successful,
      failed,
      const DeepCollectionEquality().hash(_failedIds),
      const DeepCollectionEquality().hash(_errorMessages));

  @override
  String toString() {
    return 'BatchOperationResult(total: $total, successful: $successful, failed: $failed, failedIds: $failedIds, errorMessages: $errorMessages)';
  }
}

/// @nodoc
abstract mixin class _$BatchOperationResultCopyWith<$Res>
    implements $BatchOperationResultCopyWith<$Res> {
  factory _$BatchOperationResultCopyWith(_BatchOperationResult value,
          $Res Function(_BatchOperationResult) _then) =
      __$BatchOperationResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int total,
      int successful,
      int failed,
      List<String> failedIds,
      List<String> errorMessages});
}

/// @nodoc
class __$BatchOperationResultCopyWithImpl<$Res>
    implements _$BatchOperationResultCopyWith<$Res> {
  __$BatchOperationResultCopyWithImpl(this._self, this._then);

  final _BatchOperationResult _self;
  final $Res Function(_BatchOperationResult) _then;

  /// Create a copy of BatchOperationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? total = null,
    Object? successful = null,
    Object? failed = null,
    Object? failedIds = null,
    Object? errorMessages = null,
  }) {
    return _then(_BatchOperationResult(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      successful: null == successful
          ? _self.successful
          : successful // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _self.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
      failedIds: null == failedIds
          ? _self._failedIds
          : failedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errorMessages: null == errorMessages
          ? _self._errorMessages
          : errorMessages // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$ExamSessionFilter {
  ExamSessionStatus? get status;
  String? get subjectId;
  ExamBody? get examBody;
  DateTime? get startDate;
  DateTime? get endDate;
  int? get minScore;
  int? get maxScore;
  int? get limit;
  int? get offset;

  /// Create a copy of ExamSessionFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExamSessionFilterCopyWith<ExamSessionFilter> get copyWith =>
      _$ExamSessionFilterCopyWithImpl<ExamSessionFilter>(
          this as ExamSessionFilter, _$identity);

  /// Serializes this ExamSessionFilter to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExamSessionFilter &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.examBody, examBody) ||
                other.examBody == examBody) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.minScore, minScore) ||
                other.minScore == minScore) &&
            (identical(other.maxScore, maxScore) ||
                other.maxScore == maxScore) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, subjectId, examBody,
      startDate, endDate, minScore, maxScore, limit, offset);

  @override
  String toString() {
    return 'ExamSessionFilter(status: $status, subjectId: $subjectId, examBody: $examBody, startDate: $startDate, endDate: $endDate, minScore: $minScore, maxScore: $maxScore, limit: $limit, offset: $offset)';
  }
}

/// @nodoc
abstract mixin class $ExamSessionFilterCopyWith<$Res> {
  factory $ExamSessionFilterCopyWith(
          ExamSessionFilter value, $Res Function(ExamSessionFilter) _then) =
      _$ExamSessionFilterCopyWithImpl;
  @useResult
  $Res call(
      {ExamSessionStatus? status,
      String? subjectId,
      ExamBody? examBody,
      DateTime? startDate,
      DateTime? endDate,
      int? minScore,
      int? maxScore,
      int? limit,
      int? offset});
}

/// @nodoc
class _$ExamSessionFilterCopyWithImpl<$Res>
    implements $ExamSessionFilterCopyWith<$Res> {
  _$ExamSessionFilterCopyWithImpl(this._self, this._then);

  final ExamSessionFilter _self;
  final $Res Function(ExamSessionFilter) _then;

  /// Create a copy of ExamSessionFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? subjectId = freezed,
    Object? examBody = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? minScore = freezed,
    Object? maxScore = freezed,
    Object? limit = freezed,
    Object? offset = freezed,
  }) {
    return _then(_self.copyWith(
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExamSessionStatus?,
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      examBody: freezed == examBody
          ? _self.examBody
          : examBody // ignore: cast_nullable_to_non_nullable
              as ExamBody?,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      minScore: freezed == minScore
          ? _self.minScore
          : minScore // ignore: cast_nullable_to_non_nullable
              as int?,
      maxScore: freezed == maxScore
          ? _self.maxScore
          : maxScore // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      offset: freezed == offset
          ? _self.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExamSessionFilter].
extension ExamSessionFilterPatterns on ExamSessionFilter {
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
    TResult Function(_ExamSessionFilter value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamSessionFilter() when $default != null:
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
    TResult Function(_ExamSessionFilter value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSessionFilter():
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
    TResult? Function(_ExamSessionFilter value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSessionFilter() when $default != null:
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
    TResult Function(
            ExamSessionStatus? status,
            String? subjectId,
            ExamBody? examBody,
            DateTime? startDate,
            DateTime? endDate,
            int? minScore,
            int? maxScore,
            int? limit,
            int? offset)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamSessionFilter() when $default != null:
        return $default(
            _that.status,
            _that.subjectId,
            _that.examBody,
            _that.startDate,
            _that.endDate,
            _that.minScore,
            _that.maxScore,
            _that.limit,
            _that.offset);
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
    TResult Function(
            ExamSessionStatus? status,
            String? subjectId,
            ExamBody? examBody,
            DateTime? startDate,
            DateTime? endDate,
            int? minScore,
            int? maxScore,
            int? limit,
            int? offset)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSessionFilter():
        return $default(
            _that.status,
            _that.subjectId,
            _that.examBody,
            _that.startDate,
            _that.endDate,
            _that.minScore,
            _that.maxScore,
            _that.limit,
            _that.offset);
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
    TResult? Function(
            ExamSessionStatus? status,
            String? subjectId,
            ExamBody? examBody,
            DateTime? startDate,
            DateTime? endDate,
            int? minScore,
            int? maxScore,
            int? limit,
            int? offset)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSessionFilter() when $default != null:
        return $default(
            _that.status,
            _that.subjectId,
            _that.examBody,
            _that.startDate,
            _that.endDate,
            _that.minScore,
            _that.maxScore,
            _that.limit,
            _that.offset);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExamSessionFilter extends ExamSessionFilter {
  const _ExamSessionFilter(
      {this.status,
      this.subjectId,
      this.examBody,
      this.startDate,
      this.endDate,
      this.minScore,
      this.maxScore,
      this.limit,
      this.offset})
      : super._();
  factory _ExamSessionFilter.fromJson(Map<String, dynamic> json) =>
      _$ExamSessionFilterFromJson(json);

  @override
  final ExamSessionStatus? status;
  @override
  final String? subjectId;
  @override
  final ExamBody? examBody;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final int? minScore;
  @override
  final int? maxScore;
  @override
  final int? limit;
  @override
  final int? offset;

  /// Create a copy of ExamSessionFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExamSessionFilterCopyWith<_ExamSessionFilter> get copyWith =>
      __$ExamSessionFilterCopyWithImpl<_ExamSessionFilter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExamSessionFilterToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExamSessionFilter &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.examBody, examBody) ||
                other.examBody == examBody) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.minScore, minScore) ||
                other.minScore == minScore) &&
            (identical(other.maxScore, maxScore) ||
                other.maxScore == maxScore) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, subjectId, examBody,
      startDate, endDate, minScore, maxScore, limit, offset);

  @override
  String toString() {
    return 'ExamSessionFilter(status: $status, subjectId: $subjectId, examBody: $examBody, startDate: $startDate, endDate: $endDate, minScore: $minScore, maxScore: $maxScore, limit: $limit, offset: $offset)';
  }
}

/// @nodoc
abstract mixin class _$ExamSessionFilterCopyWith<$Res>
    implements $ExamSessionFilterCopyWith<$Res> {
  factory _$ExamSessionFilterCopyWith(
          _ExamSessionFilter value, $Res Function(_ExamSessionFilter) _then) =
      __$ExamSessionFilterCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ExamSessionStatus? status,
      String? subjectId,
      ExamBody? examBody,
      DateTime? startDate,
      DateTime? endDate,
      int? minScore,
      int? maxScore,
      int? limit,
      int? offset});
}

/// @nodoc
class __$ExamSessionFilterCopyWithImpl<$Res>
    implements _$ExamSessionFilterCopyWith<$Res> {
  __$ExamSessionFilterCopyWithImpl(this._self, this._then);

  final _ExamSessionFilter _self;
  final $Res Function(_ExamSessionFilter) _then;

  /// Create a copy of ExamSessionFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = freezed,
    Object? subjectId = freezed,
    Object? examBody = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? minScore = freezed,
    Object? maxScore = freezed,
    Object? limit = freezed,
    Object? offset = freezed,
  }) {
    return _then(_ExamSessionFilter(
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExamSessionStatus?,
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      examBody: freezed == examBody
          ? _self.examBody
          : examBody // ignore: cast_nullable_to_non_nullable
              as ExamBody?,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      minScore: freezed == minScore
          ? _self.minScore
          : minScore // ignore: cast_nullable_to_non_nullable
              as int?,
      maxScore: freezed == maxScore
          ? _self.maxScore
          : maxScore // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      offset: freezed == offset
          ? _self.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$QuerySort {
  SortField get field;
  SortOrder get order;

  /// Create a copy of QuerySort
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuerySortCopyWith<QuerySort> get copyWith =>
      _$QuerySortCopyWithImpl<QuerySort>(this as QuerySort, _$identity);

  /// Serializes this QuerySort to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuerySort &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, field, order);

  @override
  String toString() {
    return 'QuerySort(field: $field, order: $order)';
  }
}

/// @nodoc
abstract mixin class $QuerySortCopyWith<$Res> {
  factory $QuerySortCopyWith(QuerySort value, $Res Function(QuerySort) _then) =
      _$QuerySortCopyWithImpl;
  @useResult
  $Res call({SortField field, SortOrder order});
}

/// @nodoc
class _$QuerySortCopyWithImpl<$Res> implements $QuerySortCopyWith<$Res> {
  _$QuerySortCopyWithImpl(this._self, this._then);

  final QuerySort _self;
  final $Res Function(QuerySort) _then;

  /// Create a copy of QuerySort
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? order = null,
  }) {
    return _then(_self.copyWith(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as SortField,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as SortOrder,
    ));
  }
}

/// Adds pattern-matching-related methods to [QuerySort].
extension QuerySortPatterns on QuerySort {
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
    TResult Function(_QuerySort value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuerySort() when $default != null:
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
    TResult Function(_QuerySort value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuerySort():
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
    TResult? Function(_QuerySort value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuerySort() when $default != null:
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
    TResult Function(SortField field, SortOrder order)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuerySort() when $default != null:
        return $default(_that.field, _that.order);
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
    TResult Function(SortField field, SortOrder order) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuerySort():
        return $default(_that.field, _that.order);
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
    TResult? Function(SortField field, SortOrder order)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuerySort() when $default != null:
        return $default(_that.field, _that.order);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _QuerySort extends QuerySort {
  const _QuerySort({required this.field, this.order = SortOrder.descending})
      : super._();
  factory _QuerySort.fromJson(Map<String, dynamic> json) =>
      _$QuerySortFromJson(json);

  @override
  final SortField field;
  @override
  @JsonKey()
  final SortOrder order;

  /// Create a copy of QuerySort
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuerySortCopyWith<_QuerySort> get copyWith =>
      __$QuerySortCopyWithImpl<_QuerySort>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuerySortToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuerySort &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, field, order);

  @override
  String toString() {
    return 'QuerySort(field: $field, order: $order)';
  }
}

/// @nodoc
abstract mixin class _$QuerySortCopyWith<$Res>
    implements $QuerySortCopyWith<$Res> {
  factory _$QuerySortCopyWith(
          _QuerySort value, $Res Function(_QuerySort) _then) =
      __$QuerySortCopyWithImpl;
  @override
  @useResult
  $Res call({SortField field, SortOrder order});
}

/// @nodoc
class __$QuerySortCopyWithImpl<$Res> implements _$QuerySortCopyWith<$Res> {
  __$QuerySortCopyWithImpl(this._self, this._then);

  final _QuerySort _self;
  final $Res Function(_QuerySort) _then;

  /// Create a copy of QuerySort
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
    Object? order = null,
  }) {
    return _then(_QuerySort(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as SortField,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as SortOrder,
    ));
  }
}

/// @nodoc
mixin _$PerformanceAnalytics {
  String get userId;
  double get averageScore;
  double get scoreImprovement;
  Map<String, double> get subjectPerformance;
  Map<String, int> get topicWeaknesses;
  List<String> get strongSubjects;
  List<String> get weakSubjects;
  int get currentStreak;
  int get longestStreak;
  DateTime? get lastStudyDate;
  Map<String, dynamic> get insights;

  /// Create a copy of PerformanceAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PerformanceAnalyticsCopyWith<PerformanceAnalytics> get copyWith =>
      _$PerformanceAnalyticsCopyWithImpl<PerformanceAnalytics>(
          this as PerformanceAnalytics, _$identity);

  /// Serializes this PerformanceAnalytics to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PerformanceAnalytics &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.scoreImprovement, scoreImprovement) ||
                other.scoreImprovement == scoreImprovement) &&
            const DeepCollectionEquality()
                .equals(other.subjectPerformance, subjectPerformance) &&
            const DeepCollectionEquality()
                .equals(other.topicWeaknesses, topicWeaknesses) &&
            const DeepCollectionEquality()
                .equals(other.strongSubjects, strongSubjects) &&
            const DeepCollectionEquality()
                .equals(other.weakSubjects, weakSubjects) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.lastStudyDate, lastStudyDate) ||
                other.lastStudyDate == lastStudyDate) &&
            const DeepCollectionEquality().equals(other.insights, insights));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      averageScore,
      scoreImprovement,
      const DeepCollectionEquality().hash(subjectPerformance),
      const DeepCollectionEquality().hash(topicWeaknesses),
      const DeepCollectionEquality().hash(strongSubjects),
      const DeepCollectionEquality().hash(weakSubjects),
      currentStreak,
      longestStreak,
      lastStudyDate,
      const DeepCollectionEquality().hash(insights));

  @override
  String toString() {
    return 'PerformanceAnalytics(userId: $userId, averageScore: $averageScore, scoreImprovement: $scoreImprovement, subjectPerformance: $subjectPerformance, topicWeaknesses: $topicWeaknesses, strongSubjects: $strongSubjects, weakSubjects: $weakSubjects, currentStreak: $currentStreak, longestStreak: $longestStreak, lastStudyDate: $lastStudyDate, insights: $insights)';
  }
}

/// @nodoc
abstract mixin class $PerformanceAnalyticsCopyWith<$Res> {
  factory $PerformanceAnalyticsCopyWith(PerformanceAnalytics value,
          $Res Function(PerformanceAnalytics) _then) =
      _$PerformanceAnalyticsCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      double averageScore,
      double scoreImprovement,
      Map<String, double> subjectPerformance,
      Map<String, int> topicWeaknesses,
      List<String> strongSubjects,
      List<String> weakSubjects,
      int currentStreak,
      int longestStreak,
      DateTime? lastStudyDate,
      Map<String, dynamic> insights});
}

/// @nodoc
class _$PerformanceAnalyticsCopyWithImpl<$Res>
    implements $PerformanceAnalyticsCopyWith<$Res> {
  _$PerformanceAnalyticsCopyWithImpl(this._self, this._then);

  final PerformanceAnalytics _self;
  final $Res Function(PerformanceAnalytics) _then;

  /// Create a copy of PerformanceAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? averageScore = null,
    Object? scoreImprovement = null,
    Object? subjectPerformance = null,
    Object? topicWeaknesses = null,
    Object? strongSubjects = null,
    Object? weakSubjects = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastStudyDate = freezed,
    Object? insights = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      averageScore: null == averageScore
          ? _self.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double,
      scoreImprovement: null == scoreImprovement
          ? _self.scoreImprovement
          : scoreImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      subjectPerformance: null == subjectPerformance
          ? _self.subjectPerformance
          : subjectPerformance // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      topicWeaknesses: null == topicWeaknesses
          ? _self.topicWeaknesses
          : topicWeaknesses // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      strongSubjects: null == strongSubjects
          ? _self.strongSubjects
          : strongSubjects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      weakSubjects: null == weakSubjects
          ? _self.weakSubjects
          : weakSubjects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentStreak: null == currentStreak
          ? _self.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _self.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      lastStudyDate: freezed == lastStudyDate
          ? _self.lastStudyDate
          : lastStudyDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      insights: null == insights
          ? _self.insights
          : insights // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PerformanceAnalytics].
extension PerformanceAnalyticsPatterns on PerformanceAnalytics {
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
    TResult Function(_PerformanceAnalytics value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PerformanceAnalytics() when $default != null:
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
    TResult Function(_PerformanceAnalytics value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PerformanceAnalytics():
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
    TResult? Function(_PerformanceAnalytics value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PerformanceAnalytics() when $default != null:
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
    TResult Function(
            String userId,
            double averageScore,
            double scoreImprovement,
            Map<String, double> subjectPerformance,
            Map<String, int> topicWeaknesses,
            List<String> strongSubjects,
            List<String> weakSubjects,
            int currentStreak,
            int longestStreak,
            DateTime? lastStudyDate,
            Map<String, dynamic> insights)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PerformanceAnalytics() when $default != null:
        return $default(
            _that.userId,
            _that.averageScore,
            _that.scoreImprovement,
            _that.subjectPerformance,
            _that.topicWeaknesses,
            _that.strongSubjects,
            _that.weakSubjects,
            _that.currentStreak,
            _that.longestStreak,
            _that.lastStudyDate,
            _that.insights);
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
    TResult Function(
            String userId,
            double averageScore,
            double scoreImprovement,
            Map<String, double> subjectPerformance,
            Map<String, int> topicWeaknesses,
            List<String> strongSubjects,
            List<String> weakSubjects,
            int currentStreak,
            int longestStreak,
            DateTime? lastStudyDate,
            Map<String, dynamic> insights)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PerformanceAnalytics():
        return $default(
            _that.userId,
            _that.averageScore,
            _that.scoreImprovement,
            _that.subjectPerformance,
            _that.topicWeaknesses,
            _that.strongSubjects,
            _that.weakSubjects,
            _that.currentStreak,
            _that.longestStreak,
            _that.lastStudyDate,
            _that.insights);
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
    TResult? Function(
            String userId,
            double averageScore,
            double scoreImprovement,
            Map<String, double> subjectPerformance,
            Map<String, int> topicWeaknesses,
            List<String> strongSubjects,
            List<String> weakSubjects,
            int currentStreak,
            int longestStreak,
            DateTime? lastStudyDate,
            Map<String, dynamic> insights)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PerformanceAnalytics() when $default != null:
        return $default(
            _that.userId,
            _that.averageScore,
            _that.scoreImprovement,
            _that.subjectPerformance,
            _that.topicWeaknesses,
            _that.strongSubjects,
            _that.weakSubjects,
            _that.currentStreak,
            _that.longestStreak,
            _that.lastStudyDate,
            _that.insights);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PerformanceAnalytics extends PerformanceAnalytics {
  const _PerformanceAnalytics(
      {required this.userId,
      required this.averageScore,
      required this.scoreImprovement,
      required final Map<String, double> subjectPerformance,
      required final Map<String, int> topicWeaknesses,
      required final List<String> strongSubjects,
      required final List<String> weakSubjects,
      required this.currentStreak,
      required this.longestStreak,
      this.lastStudyDate,
      final Map<String, dynamic> insights = const {}})
      : _subjectPerformance = subjectPerformance,
        _topicWeaknesses = topicWeaknesses,
        _strongSubjects = strongSubjects,
        _weakSubjects = weakSubjects,
        _insights = insights,
        super._();
  factory _PerformanceAnalytics.fromJson(Map<String, dynamic> json) =>
      _$PerformanceAnalyticsFromJson(json);

  @override
  final String userId;
  @override
  final double averageScore;
  @override
  final double scoreImprovement;
  final Map<String, double> _subjectPerformance;
  @override
  Map<String, double> get subjectPerformance {
    if (_subjectPerformance is EqualUnmodifiableMapView)
      return _subjectPerformance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_subjectPerformance);
  }

  final Map<String, int> _topicWeaknesses;
  @override
  Map<String, int> get topicWeaknesses {
    if (_topicWeaknesses is EqualUnmodifiableMapView) return _topicWeaknesses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_topicWeaknesses);
  }

  final List<String> _strongSubjects;
  @override
  List<String> get strongSubjects {
    if (_strongSubjects is EqualUnmodifiableListView) return _strongSubjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strongSubjects);
  }

  final List<String> _weakSubjects;
  @override
  List<String> get weakSubjects {
    if (_weakSubjects is EqualUnmodifiableListView) return _weakSubjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weakSubjects);
  }

  @override
  final int currentStreak;
  @override
  final int longestStreak;
  @override
  final DateTime? lastStudyDate;
  final Map<String, dynamic> _insights;
  @override
  @JsonKey()
  Map<String, dynamic> get insights {
    if (_insights is EqualUnmodifiableMapView) return _insights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_insights);
  }

  /// Create a copy of PerformanceAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PerformanceAnalyticsCopyWith<_PerformanceAnalytics> get copyWith =>
      __$PerformanceAnalyticsCopyWithImpl<_PerformanceAnalytics>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PerformanceAnalyticsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PerformanceAnalytics &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.scoreImprovement, scoreImprovement) ||
                other.scoreImprovement == scoreImprovement) &&
            const DeepCollectionEquality()
                .equals(other._subjectPerformance, _subjectPerformance) &&
            const DeepCollectionEquality()
                .equals(other._topicWeaknesses, _topicWeaknesses) &&
            const DeepCollectionEquality()
                .equals(other._strongSubjects, _strongSubjects) &&
            const DeepCollectionEquality()
                .equals(other._weakSubjects, _weakSubjects) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.lastStudyDate, lastStudyDate) ||
                other.lastStudyDate == lastStudyDate) &&
            const DeepCollectionEquality().equals(other._insights, _insights));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      averageScore,
      scoreImprovement,
      const DeepCollectionEquality().hash(_subjectPerformance),
      const DeepCollectionEquality().hash(_topicWeaknesses),
      const DeepCollectionEquality().hash(_strongSubjects),
      const DeepCollectionEquality().hash(_weakSubjects),
      currentStreak,
      longestStreak,
      lastStudyDate,
      const DeepCollectionEquality().hash(_insights));

  @override
  String toString() {
    return 'PerformanceAnalytics(userId: $userId, averageScore: $averageScore, scoreImprovement: $scoreImprovement, subjectPerformance: $subjectPerformance, topicWeaknesses: $topicWeaknesses, strongSubjects: $strongSubjects, weakSubjects: $weakSubjects, currentStreak: $currentStreak, longestStreak: $longestStreak, lastStudyDate: $lastStudyDate, insights: $insights)';
  }
}

/// @nodoc
abstract mixin class _$PerformanceAnalyticsCopyWith<$Res>
    implements $PerformanceAnalyticsCopyWith<$Res> {
  factory _$PerformanceAnalyticsCopyWith(_PerformanceAnalytics value,
          $Res Function(_PerformanceAnalytics) _then) =
      __$PerformanceAnalyticsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      double averageScore,
      double scoreImprovement,
      Map<String, double> subjectPerformance,
      Map<String, int> topicWeaknesses,
      List<String> strongSubjects,
      List<String> weakSubjects,
      int currentStreak,
      int longestStreak,
      DateTime? lastStudyDate,
      Map<String, dynamic> insights});
}

/// @nodoc
class __$PerformanceAnalyticsCopyWithImpl<$Res>
    implements _$PerformanceAnalyticsCopyWith<$Res> {
  __$PerformanceAnalyticsCopyWithImpl(this._self, this._then);

  final _PerformanceAnalytics _self;
  final $Res Function(_PerformanceAnalytics) _then;

  /// Create a copy of PerformanceAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? averageScore = null,
    Object? scoreImprovement = null,
    Object? subjectPerformance = null,
    Object? topicWeaknesses = null,
    Object? strongSubjects = null,
    Object? weakSubjects = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastStudyDate = freezed,
    Object? insights = null,
  }) {
    return _then(_PerformanceAnalytics(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      averageScore: null == averageScore
          ? _self.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double,
      scoreImprovement: null == scoreImprovement
          ? _self.scoreImprovement
          : scoreImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      subjectPerformance: null == subjectPerformance
          ? _self._subjectPerformance
          : subjectPerformance // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      topicWeaknesses: null == topicWeaknesses
          ? _self._topicWeaknesses
          : topicWeaknesses // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      strongSubjects: null == strongSubjects
          ? _self._strongSubjects
          : strongSubjects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      weakSubjects: null == weakSubjects
          ? _self._weakSubjects
          : weakSubjects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentStreak: null == currentStreak
          ? _self.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _self.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      lastStudyDate: freezed == lastStudyDate
          ? _self.lastStudyDate
          : lastStudyDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      insights: null == insights
          ? _self._insights
          : insights // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
mixin _$TimeStatistics {
  int get totalMinutes;
  double get averageMinutesPerSession;
  Map<String, int> get subjectTimeDistribution;
  List<StudyTimeEntry> get dailyStudyTime;
  String? get mostProductiveHour;

  /// Create a copy of TimeStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimeStatisticsCopyWith<TimeStatistics> get copyWith =>
      _$TimeStatisticsCopyWithImpl<TimeStatistics>(
          this as TimeStatistics, _$identity);

  /// Serializes this TimeStatistics to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TimeStatistics &&
            (identical(other.totalMinutes, totalMinutes) ||
                other.totalMinutes == totalMinutes) &&
            (identical(
                    other.averageMinutesPerSession, averageMinutesPerSession) ||
                other.averageMinutesPerSession == averageMinutesPerSession) &&
            const DeepCollectionEquality().equals(
                other.subjectTimeDistribution, subjectTimeDistribution) &&
            const DeepCollectionEquality()
                .equals(other.dailyStudyTime, dailyStudyTime) &&
            (identical(other.mostProductiveHour, mostProductiveHour) ||
                other.mostProductiveHour == mostProductiveHour));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalMinutes,
      averageMinutesPerSession,
      const DeepCollectionEquality().hash(subjectTimeDistribution),
      const DeepCollectionEquality().hash(dailyStudyTime),
      mostProductiveHour);

  @override
  String toString() {
    return 'TimeStatistics(totalMinutes: $totalMinutes, averageMinutesPerSession: $averageMinutesPerSession, subjectTimeDistribution: $subjectTimeDistribution, dailyStudyTime: $dailyStudyTime, mostProductiveHour: $mostProductiveHour)';
  }
}

/// @nodoc
abstract mixin class $TimeStatisticsCopyWith<$Res> {
  factory $TimeStatisticsCopyWith(
          TimeStatistics value, $Res Function(TimeStatistics) _then) =
      _$TimeStatisticsCopyWithImpl;
  @useResult
  $Res call(
      {int totalMinutes,
      double averageMinutesPerSession,
      Map<String, int> subjectTimeDistribution,
      List<StudyTimeEntry> dailyStudyTime,
      String? mostProductiveHour});
}

/// @nodoc
class _$TimeStatisticsCopyWithImpl<$Res>
    implements $TimeStatisticsCopyWith<$Res> {
  _$TimeStatisticsCopyWithImpl(this._self, this._then);

  final TimeStatistics _self;
  final $Res Function(TimeStatistics) _then;

  /// Create a copy of TimeStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalMinutes = null,
    Object? averageMinutesPerSession = null,
    Object? subjectTimeDistribution = null,
    Object? dailyStudyTime = null,
    Object? mostProductiveHour = freezed,
  }) {
    return _then(_self.copyWith(
      totalMinutes: null == totalMinutes
          ? _self.totalMinutes
          : totalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      averageMinutesPerSession: null == averageMinutesPerSession
          ? _self.averageMinutesPerSession
          : averageMinutesPerSession // ignore: cast_nullable_to_non_nullable
              as double,
      subjectTimeDistribution: null == subjectTimeDistribution
          ? _self.subjectTimeDistribution
          : subjectTimeDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      dailyStudyTime: null == dailyStudyTime
          ? _self.dailyStudyTime
          : dailyStudyTime // ignore: cast_nullable_to_non_nullable
              as List<StudyTimeEntry>,
      mostProductiveHour: freezed == mostProductiveHour
          ? _self.mostProductiveHour
          : mostProductiveHour // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TimeStatistics].
extension TimeStatisticsPatterns on TimeStatistics {
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
    TResult Function(_TimeStatistics value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimeStatistics() when $default != null:
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
    TResult Function(_TimeStatistics value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeStatistics():
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
    TResult? Function(_TimeStatistics value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeStatistics() when $default != null:
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
    TResult Function(
            int totalMinutes,
            double averageMinutesPerSession,
            Map<String, int> subjectTimeDistribution,
            List<StudyTimeEntry> dailyStudyTime,
            String? mostProductiveHour)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimeStatistics() when $default != null:
        return $default(
            _that.totalMinutes,
            _that.averageMinutesPerSession,
            _that.subjectTimeDistribution,
            _that.dailyStudyTime,
            _that.mostProductiveHour);
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
    TResult Function(
            int totalMinutes,
            double averageMinutesPerSession,
            Map<String, int> subjectTimeDistribution,
            List<StudyTimeEntry> dailyStudyTime,
            String? mostProductiveHour)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeStatistics():
        return $default(
            _that.totalMinutes,
            _that.averageMinutesPerSession,
            _that.subjectTimeDistribution,
            _that.dailyStudyTime,
            _that.mostProductiveHour);
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
    TResult? Function(
            int totalMinutes,
            double averageMinutesPerSession,
            Map<String, int> subjectTimeDistribution,
            List<StudyTimeEntry> dailyStudyTime,
            String? mostProductiveHour)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimeStatistics() when $default != null:
        return $default(
            _that.totalMinutes,
            _that.averageMinutesPerSession,
            _that.subjectTimeDistribution,
            _that.dailyStudyTime,
            _that.mostProductiveHour);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TimeStatistics extends TimeStatistics {
  const _TimeStatistics(
      {required this.totalMinutes,
      required this.averageMinutesPerSession,
      required final Map<String, int> subjectTimeDistribution,
      required final List<StudyTimeEntry> dailyStudyTime,
      this.mostProductiveHour})
      : _subjectTimeDistribution = subjectTimeDistribution,
        _dailyStudyTime = dailyStudyTime,
        super._();
  factory _TimeStatistics.fromJson(Map<String, dynamic> json) =>
      _$TimeStatisticsFromJson(json);

  @override
  final int totalMinutes;
  @override
  final double averageMinutesPerSession;
  final Map<String, int> _subjectTimeDistribution;
  @override
  Map<String, int> get subjectTimeDistribution {
    if (_subjectTimeDistribution is EqualUnmodifiableMapView)
      return _subjectTimeDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_subjectTimeDistribution);
  }

  final List<StudyTimeEntry> _dailyStudyTime;
  @override
  List<StudyTimeEntry> get dailyStudyTime {
    if (_dailyStudyTime is EqualUnmodifiableListView) return _dailyStudyTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyStudyTime);
  }

  @override
  final String? mostProductiveHour;

  /// Create a copy of TimeStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimeStatisticsCopyWith<_TimeStatistics> get copyWith =>
      __$TimeStatisticsCopyWithImpl<_TimeStatistics>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TimeStatisticsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimeStatistics &&
            (identical(other.totalMinutes, totalMinutes) ||
                other.totalMinutes == totalMinutes) &&
            (identical(
                    other.averageMinutesPerSession, averageMinutesPerSession) ||
                other.averageMinutesPerSession == averageMinutesPerSession) &&
            const DeepCollectionEquality().equals(
                other._subjectTimeDistribution, _subjectTimeDistribution) &&
            const DeepCollectionEquality()
                .equals(other._dailyStudyTime, _dailyStudyTime) &&
            (identical(other.mostProductiveHour, mostProductiveHour) ||
                other.mostProductiveHour == mostProductiveHour));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalMinutes,
      averageMinutesPerSession,
      const DeepCollectionEquality().hash(_subjectTimeDistribution),
      const DeepCollectionEquality().hash(_dailyStudyTime),
      mostProductiveHour);

  @override
  String toString() {
    return 'TimeStatistics(totalMinutes: $totalMinutes, averageMinutesPerSession: $averageMinutesPerSession, subjectTimeDistribution: $subjectTimeDistribution, dailyStudyTime: $dailyStudyTime, mostProductiveHour: $mostProductiveHour)';
  }
}

/// @nodoc
abstract mixin class _$TimeStatisticsCopyWith<$Res>
    implements $TimeStatisticsCopyWith<$Res> {
  factory _$TimeStatisticsCopyWith(
          _TimeStatistics value, $Res Function(_TimeStatistics) _then) =
      __$TimeStatisticsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int totalMinutes,
      double averageMinutesPerSession,
      Map<String, int> subjectTimeDistribution,
      List<StudyTimeEntry> dailyStudyTime,
      String? mostProductiveHour});
}

/// @nodoc
class __$TimeStatisticsCopyWithImpl<$Res>
    implements _$TimeStatisticsCopyWith<$Res> {
  __$TimeStatisticsCopyWithImpl(this._self, this._then);

  final _TimeStatistics _self;
  final $Res Function(_TimeStatistics) _then;

  /// Create a copy of TimeStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalMinutes = null,
    Object? averageMinutesPerSession = null,
    Object? subjectTimeDistribution = null,
    Object? dailyStudyTime = null,
    Object? mostProductiveHour = freezed,
  }) {
    return _then(_TimeStatistics(
      totalMinutes: null == totalMinutes
          ? _self.totalMinutes
          : totalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      averageMinutesPerSession: null == averageMinutesPerSession
          ? _self.averageMinutesPerSession
          : averageMinutesPerSession // ignore: cast_nullable_to_non_nullable
              as double,
      subjectTimeDistribution: null == subjectTimeDistribution
          ? _self._subjectTimeDistribution
          : subjectTimeDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      dailyStudyTime: null == dailyStudyTime
          ? _self._dailyStudyTime
          : dailyStudyTime // ignore: cast_nullable_to_non_nullable
              as List<StudyTimeEntry>,
      mostProductiveHour: freezed == mostProductiveHour
          ? _self.mostProductiveHour
          : mostProductiveHour // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$StudyTimeEntry {
  DateTime get date;
  int get minutes;
  int get sessionsCount;

  /// Create a copy of StudyTimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StudyTimeEntryCopyWith<StudyTimeEntry> get copyWith =>
      _$StudyTimeEntryCopyWithImpl<StudyTimeEntry>(
          this as StudyTimeEntry, _$identity);

  /// Serializes this StudyTimeEntry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StudyTimeEntry &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.sessionsCount, sessionsCount) ||
                other.sessionsCount == sessionsCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, minutes, sessionsCount);

  @override
  String toString() {
    return 'StudyTimeEntry(date: $date, minutes: $minutes, sessionsCount: $sessionsCount)';
  }
}

/// @nodoc
abstract mixin class $StudyTimeEntryCopyWith<$Res> {
  factory $StudyTimeEntryCopyWith(
          StudyTimeEntry value, $Res Function(StudyTimeEntry) _then) =
      _$StudyTimeEntryCopyWithImpl;
  @useResult
  $Res call({DateTime date, int minutes, int sessionsCount});
}

/// @nodoc
class _$StudyTimeEntryCopyWithImpl<$Res>
    implements $StudyTimeEntryCopyWith<$Res> {
  _$StudyTimeEntryCopyWithImpl(this._self, this._then);

  final StudyTimeEntry _self;
  final $Res Function(StudyTimeEntry) _then;

  /// Create a copy of StudyTimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? minutes = null,
    Object? sessionsCount = null,
  }) {
    return _then(_self.copyWith(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      minutes: null == minutes
          ? _self.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      sessionsCount: null == sessionsCount
          ? _self.sessionsCount
          : sessionsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [StudyTimeEntry].
extension StudyTimeEntryPatterns on StudyTimeEntry {
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
    TResult Function(_StudyTimeEntry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StudyTimeEntry() when $default != null:
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
    TResult Function(_StudyTimeEntry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudyTimeEntry():
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
    TResult? Function(_StudyTimeEntry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudyTimeEntry() when $default != null:
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
    TResult Function(DateTime date, int minutes, int sessionsCount)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StudyTimeEntry() when $default != null:
        return $default(_that.date, _that.minutes, _that.sessionsCount);
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
    TResult Function(DateTime date, int minutes, int sessionsCount) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudyTimeEntry():
        return $default(_that.date, _that.minutes, _that.sessionsCount);
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
    TResult? Function(DateTime date, int minutes, int sessionsCount)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudyTimeEntry() when $default != null:
        return $default(_that.date, _that.minutes, _that.sessionsCount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StudyTimeEntry extends StudyTimeEntry {
  const _StudyTimeEntry(
      {required this.date, required this.minutes, required this.sessionsCount})
      : super._();
  factory _StudyTimeEntry.fromJson(Map<String, dynamic> json) =>
      _$StudyTimeEntryFromJson(json);

  @override
  final DateTime date;
  @override
  final int minutes;
  @override
  final int sessionsCount;

  /// Create a copy of StudyTimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StudyTimeEntryCopyWith<_StudyTimeEntry> get copyWith =>
      __$StudyTimeEntryCopyWithImpl<_StudyTimeEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StudyTimeEntryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StudyTimeEntry &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.sessionsCount, sessionsCount) ||
                other.sessionsCount == sessionsCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, minutes, sessionsCount);

  @override
  String toString() {
    return 'StudyTimeEntry(date: $date, minutes: $minutes, sessionsCount: $sessionsCount)';
  }
}

/// @nodoc
abstract mixin class _$StudyTimeEntryCopyWith<$Res>
    implements $StudyTimeEntryCopyWith<$Res> {
  factory _$StudyTimeEntryCopyWith(
          _StudyTimeEntry value, $Res Function(_StudyTimeEntry) _then) =
      __$StudyTimeEntryCopyWithImpl;
  @override
  @useResult
  $Res call({DateTime date, int minutes, int sessionsCount});
}

/// @nodoc
class __$StudyTimeEntryCopyWithImpl<$Res>
    implements _$StudyTimeEntryCopyWith<$Res> {
  __$StudyTimeEntryCopyWithImpl(this._self, this._then);

  final _StudyTimeEntry _self;
  final $Res Function(_StudyTimeEntry) _then;

  /// Create a copy of StudyTimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
    Object? minutes = null,
    Object? sessionsCount = null,
  }) {
    return _then(_StudyTimeEntry(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      minutes: null == minutes
          ? _self.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      sessionsCount: null == sessionsCount
          ? _self.sessionsCount
          : sessionsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$ExamNotification {
  String get id;
  String get userId;
  NotificationType get type;
  String get title;
  String get body;
  Map<String, dynamic>? get data;
  DateTime get createdAt;
  bool get isRead;
  DateTime? get scheduledFor;
  NotificationPriority get priority;

  /// Create a copy of ExamNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExamNotificationCopyWith<ExamNotification> get copyWith =>
      _$ExamNotificationCopyWithImpl<ExamNotification>(
          this as ExamNotification, _$identity);

  /// Serializes this ExamNotification to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExamNotification &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      type,
      title,
      body,
      const DeepCollectionEquality().hash(data),
      createdAt,
      isRead,
      scheduledFor,
      priority);

  @override
  String toString() {
    return 'ExamNotification(id: $id, userId: $userId, type: $type, title: $title, body: $body, data: $data, createdAt: $createdAt, isRead: $isRead, scheduledFor: $scheduledFor, priority: $priority)';
  }
}

/// @nodoc
abstract mixin class $ExamNotificationCopyWith<$Res> {
  factory $ExamNotificationCopyWith(
          ExamNotification value, $Res Function(ExamNotification) _then) =
      _$ExamNotificationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      NotificationType type,
      String title,
      String body,
      Map<String, dynamic>? data,
      DateTime createdAt,
      bool isRead,
      DateTime? scheduledFor,
      NotificationPriority priority});
}

/// @nodoc
class _$ExamNotificationCopyWithImpl<$Res>
    implements $ExamNotificationCopyWith<$Res> {
  _$ExamNotificationCopyWithImpl(this._self, this._then);

  final ExamNotification _self;
  final $Res Function(ExamNotification) _then;

  /// Create a copy of ExamNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? data = freezed,
    Object? createdAt = null,
    Object? isRead = null,
    Object? scheduledFor = freezed,
    Object? priority = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      scheduledFor: freezed == scheduledFor
          ? _self.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NotificationPriority,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExamNotification].
extension ExamNotificationPatterns on ExamNotification {
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
    TResult Function(_ExamNotification value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamNotification() when $default != null:
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
    TResult Function(_ExamNotification value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamNotification():
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
    TResult? Function(_ExamNotification value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamNotification() when $default != null:
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
    TResult Function(
            String id,
            String userId,
            NotificationType type,
            String title,
            String body,
            Map<String, dynamic>? data,
            DateTime createdAt,
            bool isRead,
            DateTime? scheduledFor,
            NotificationPriority priority)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamNotification() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.type,
            _that.title,
            _that.body,
            _that.data,
            _that.createdAt,
            _that.isRead,
            _that.scheduledFor,
            _that.priority);
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
    TResult Function(
            String id,
            String userId,
            NotificationType type,
            String title,
            String body,
            Map<String, dynamic>? data,
            DateTime createdAt,
            bool isRead,
            DateTime? scheduledFor,
            NotificationPriority priority)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamNotification():
        return $default(
            _that.id,
            _that.userId,
            _that.type,
            _that.title,
            _that.body,
            _that.data,
            _that.createdAt,
            _that.isRead,
            _that.scheduledFor,
            _that.priority);
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
    TResult? Function(
            String id,
            String userId,
            NotificationType type,
            String title,
            String body,
            Map<String, dynamic>? data,
            DateTime createdAt,
            bool isRead,
            DateTime? scheduledFor,
            NotificationPriority priority)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamNotification() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.type,
            _that.title,
            _that.body,
            _that.data,
            _that.createdAt,
            _that.isRead,
            _that.scheduledFor,
            _that.priority);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExamNotification extends ExamNotification {
  const _ExamNotification(
      {required this.id,
      required this.userId,
      required this.type,
      required this.title,
      required this.body,
      final Map<String, dynamic>? data,
      required this.createdAt,
      this.isRead = false,
      this.scheduledFor,
      this.priority = NotificationPriority.normal})
      : _data = data,
        super._();
  factory _ExamNotification.fromJson(Map<String, dynamic> json) =>
      _$ExamNotificationFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final NotificationType type;
  @override
  final String title;
  @override
  final String body;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isRead;
  @override
  final DateTime? scheduledFor;
  @override
  @JsonKey()
  final NotificationPriority priority;

  /// Create a copy of ExamNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExamNotificationCopyWith<_ExamNotification> get copyWith =>
      __$ExamNotificationCopyWithImpl<_ExamNotification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExamNotificationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExamNotification &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      type,
      title,
      body,
      const DeepCollectionEquality().hash(_data),
      createdAt,
      isRead,
      scheduledFor,
      priority);

  @override
  String toString() {
    return 'ExamNotification(id: $id, userId: $userId, type: $type, title: $title, body: $body, data: $data, createdAt: $createdAt, isRead: $isRead, scheduledFor: $scheduledFor, priority: $priority)';
  }
}

/// @nodoc
abstract mixin class _$ExamNotificationCopyWith<$Res>
    implements $ExamNotificationCopyWith<$Res> {
  factory _$ExamNotificationCopyWith(
          _ExamNotification value, $Res Function(_ExamNotification) _then) =
      __$ExamNotificationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      NotificationType type,
      String title,
      String body,
      Map<String, dynamic>? data,
      DateTime createdAt,
      bool isRead,
      DateTime? scheduledFor,
      NotificationPriority priority});
}

/// @nodoc
class __$ExamNotificationCopyWithImpl<$Res>
    implements _$ExamNotificationCopyWith<$Res> {
  __$ExamNotificationCopyWithImpl(this._self, this._then);

  final _ExamNotification _self;
  final $Res Function(_ExamNotification) _then;

  /// Create a copy of ExamNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? data = freezed,
    Object? createdAt = null,
    Object? isRead = null,
    Object? scheduledFor = freezed,
    Object? priority = null,
  }) {
    return _then(_ExamNotification(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      scheduledFor: freezed == scheduledFor
          ? _self.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NotificationPriority,
    ));
  }
}

/// @nodoc
mixin _$NotificationPreferences {
  bool get sessionReminders;
  bool get achievementNotifications;
  bool get leaderboardUpdates;
  bool get streakReminders;
  bool get dailyGoals;
  bool get weeklyReports;
  bool get examTips;
  bool get aiInsights;
  bool get appUpdates;
  bool get settingsNotifications;
  bool get featureAnnouncements;
  bool get motivationalMessages;
  bool get studyTips;
  bool get communityUpdates;
  NotificationFrequency get frequency;
  List<int> get quietHours;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationPreferencesCopyWith<NotificationPreferences> get copyWith =>
      _$NotificationPreferencesCopyWithImpl<NotificationPreferences>(
          this as NotificationPreferences, _$identity);

  /// Serializes this NotificationPreferences to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationPreferences &&
            (identical(other.sessionReminders, sessionReminders) ||
                other.sessionReminders == sessionReminders) &&
            (identical(
                    other.achievementNotifications, achievementNotifications) ||
                other.achievementNotifications == achievementNotifications) &&
            (identical(other.leaderboardUpdates, leaderboardUpdates) ||
                other.leaderboardUpdates == leaderboardUpdates) &&
            (identical(other.streakReminders, streakReminders) ||
                other.streakReminders == streakReminders) &&
            (identical(other.dailyGoals, dailyGoals) ||
                other.dailyGoals == dailyGoals) &&
            (identical(other.weeklyReports, weeklyReports) ||
                other.weeklyReports == weeklyReports) &&
            (identical(other.examTips, examTips) ||
                other.examTips == examTips) &&
            (identical(other.aiInsights, aiInsights) ||
                other.aiInsights == aiInsights) &&
            (identical(other.appUpdates, appUpdates) ||
                other.appUpdates == appUpdates) &&
            (identical(other.settingsNotifications, settingsNotifications) ||
                other.settingsNotifications == settingsNotifications) &&
            (identical(other.featureAnnouncements, featureAnnouncements) ||
                other.featureAnnouncements == featureAnnouncements) &&
            (identical(other.motivationalMessages, motivationalMessages) ||
                other.motivationalMessages == motivationalMessages) &&
            (identical(other.studyTips, studyTips) ||
                other.studyTips == studyTips) &&
            (identical(other.communityUpdates, communityUpdates) ||
                other.communityUpdates == communityUpdates) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality()
                .equals(other.quietHours, quietHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sessionReminders,
      achievementNotifications,
      leaderboardUpdates,
      streakReminders,
      dailyGoals,
      weeklyReports,
      examTips,
      aiInsights,
      appUpdates,
      settingsNotifications,
      featureAnnouncements,
      motivationalMessages,
      studyTips,
      communityUpdates,
      frequency,
      const DeepCollectionEquality().hash(quietHours));

  @override
  String toString() {
    return 'NotificationPreferences(sessionReminders: $sessionReminders, achievementNotifications: $achievementNotifications, leaderboardUpdates: $leaderboardUpdates, streakReminders: $streakReminders, dailyGoals: $dailyGoals, weeklyReports: $weeklyReports, examTips: $examTips, aiInsights: $aiInsights, appUpdates: $appUpdates, settingsNotifications: $settingsNotifications, featureAnnouncements: $featureAnnouncements, motivationalMessages: $motivationalMessages, studyTips: $studyTips, communityUpdates: $communityUpdates, frequency: $frequency, quietHours: $quietHours)';
  }
}

/// @nodoc
abstract mixin class $NotificationPreferencesCopyWith<$Res> {
  factory $NotificationPreferencesCopyWith(NotificationPreferences value,
          $Res Function(NotificationPreferences) _then) =
      _$NotificationPreferencesCopyWithImpl;
  @useResult
  $Res call(
      {bool sessionReminders,
      bool achievementNotifications,
      bool leaderboardUpdates,
      bool streakReminders,
      bool dailyGoals,
      bool weeklyReports,
      bool examTips,
      bool aiInsights,
      bool appUpdates,
      bool settingsNotifications,
      bool featureAnnouncements,
      bool motivationalMessages,
      bool studyTips,
      bool communityUpdates,
      NotificationFrequency frequency,
      List<int> quietHours});
}

/// @nodoc
class _$NotificationPreferencesCopyWithImpl<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  _$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final NotificationPreferences _self;
  final $Res Function(NotificationPreferences) _then;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionReminders = null,
    Object? achievementNotifications = null,
    Object? leaderboardUpdates = null,
    Object? streakReminders = null,
    Object? dailyGoals = null,
    Object? weeklyReports = null,
    Object? examTips = null,
    Object? aiInsights = null,
    Object? appUpdates = null,
    Object? settingsNotifications = null,
    Object? featureAnnouncements = null,
    Object? motivationalMessages = null,
    Object? studyTips = null,
    Object? communityUpdates = null,
    Object? frequency = null,
    Object? quietHours = null,
  }) {
    return _then(_self.copyWith(
      sessionReminders: null == sessionReminders
          ? _self.sessionReminders
          : sessionReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      achievementNotifications: null == achievementNotifications
          ? _self.achievementNotifications
          : achievementNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      leaderboardUpdates: null == leaderboardUpdates
          ? _self.leaderboardUpdates
          : leaderboardUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      streakReminders: null == streakReminders
          ? _self.streakReminders
          : streakReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyGoals: null == dailyGoals
          ? _self.dailyGoals
          : dailyGoals // ignore: cast_nullable_to_non_nullable
              as bool,
      weeklyReports: null == weeklyReports
          ? _self.weeklyReports
          : weeklyReports // ignore: cast_nullable_to_non_nullable
              as bool,
      examTips: null == examTips
          ? _self.examTips
          : examTips // ignore: cast_nullable_to_non_nullable
              as bool,
      aiInsights: null == aiInsights
          ? _self.aiInsights
          : aiInsights // ignore: cast_nullable_to_non_nullable
              as bool,
      appUpdates: null == appUpdates
          ? _self.appUpdates
          : appUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      settingsNotifications: null == settingsNotifications
          ? _self.settingsNotifications
          : settingsNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      featureAnnouncements: null == featureAnnouncements
          ? _self.featureAnnouncements
          : featureAnnouncements // ignore: cast_nullable_to_non_nullable
              as bool,
      motivationalMessages: null == motivationalMessages
          ? _self.motivationalMessages
          : motivationalMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      studyTips: null == studyTips
          ? _self.studyTips
          : studyTips // ignore: cast_nullable_to_non_nullable
              as bool,
      communityUpdates: null == communityUpdates
          ? _self.communityUpdates
          : communityUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as NotificationFrequency,
      quietHours: null == quietHours
          ? _self.quietHours
          : quietHours // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [NotificationPreferences].
extension NotificationPreferencesPatterns on NotificationPreferences {
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
    TResult Function(_NotificationPreferences value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences() when $default != null:
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
    TResult Function(_NotificationPreferences value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences():
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
    TResult? Function(_NotificationPreferences value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences() when $default != null:
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
    TResult Function(
            bool sessionReminders,
            bool achievementNotifications,
            bool leaderboardUpdates,
            bool streakReminders,
            bool dailyGoals,
            bool weeklyReports,
            bool examTips,
            bool aiInsights,
            bool appUpdates,
            bool settingsNotifications,
            bool featureAnnouncements,
            bool motivationalMessages,
            bool studyTips,
            bool communityUpdates,
            NotificationFrequency frequency,
            List<int> quietHours)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences() when $default != null:
        return $default(
            _that.sessionReminders,
            _that.achievementNotifications,
            _that.leaderboardUpdates,
            _that.streakReminders,
            _that.dailyGoals,
            _that.weeklyReports,
            _that.examTips,
            _that.aiInsights,
            _that.appUpdates,
            _that.settingsNotifications,
            _that.featureAnnouncements,
            _that.motivationalMessages,
            _that.studyTips,
            _that.communityUpdates,
            _that.frequency,
            _that.quietHours);
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
    TResult Function(
            bool sessionReminders,
            bool achievementNotifications,
            bool leaderboardUpdates,
            bool streakReminders,
            bool dailyGoals,
            bool weeklyReports,
            bool examTips,
            bool aiInsights,
            bool appUpdates,
            bool settingsNotifications,
            bool featureAnnouncements,
            bool motivationalMessages,
            bool studyTips,
            bool communityUpdates,
            NotificationFrequency frequency,
            List<int> quietHours)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences():
        return $default(
            _that.sessionReminders,
            _that.achievementNotifications,
            _that.leaderboardUpdates,
            _that.streakReminders,
            _that.dailyGoals,
            _that.weeklyReports,
            _that.examTips,
            _that.aiInsights,
            _that.appUpdates,
            _that.settingsNotifications,
            _that.featureAnnouncements,
            _that.motivationalMessages,
            _that.studyTips,
            _that.communityUpdates,
            _that.frequency,
            _that.quietHours);
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
    TResult? Function(
            bool sessionReminders,
            bool achievementNotifications,
            bool leaderboardUpdates,
            bool streakReminders,
            bool dailyGoals,
            bool weeklyReports,
            bool examTips,
            bool aiInsights,
            bool appUpdates,
            bool settingsNotifications,
            bool featureAnnouncements,
            bool motivationalMessages,
            bool studyTips,
            bool communityUpdates,
            NotificationFrequency frequency,
            List<int> quietHours)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences() when $default != null:
        return $default(
            _that.sessionReminders,
            _that.achievementNotifications,
            _that.leaderboardUpdates,
            _that.streakReminders,
            _that.dailyGoals,
            _that.weeklyReports,
            _that.examTips,
            _that.aiInsights,
            _that.appUpdates,
            _that.settingsNotifications,
            _that.featureAnnouncements,
            _that.motivationalMessages,
            _that.studyTips,
            _that.communityUpdates,
            _that.frequency,
            _that.quietHours);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NotificationPreferences extends NotificationPreferences {
  const _NotificationPreferences(
      {this.sessionReminders = true,
      this.achievementNotifications = true,
      this.leaderboardUpdates = true,
      this.streakReminders = true,
      this.dailyGoals = false,
      this.weeklyReports = true,
      this.examTips = true,
      this.aiInsights = true,
      this.appUpdates = true,
      this.settingsNotifications = true,
      this.featureAnnouncements = true,
      this.motivationalMessages = false,
      this.studyTips = true,
      this.communityUpdates = true,
      this.frequency = NotificationFrequency.normal,
      final List<int> quietHours = const []})
      : _quietHours = quietHours,
        super._();
  factory _NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesFromJson(json);

  @override
  @JsonKey()
  final bool sessionReminders;
  @override
  @JsonKey()
  final bool achievementNotifications;
  @override
  @JsonKey()
  final bool leaderboardUpdates;
  @override
  @JsonKey()
  final bool streakReminders;
  @override
  @JsonKey()
  final bool dailyGoals;
  @override
  @JsonKey()
  final bool weeklyReports;
  @override
  @JsonKey()
  final bool examTips;
  @override
  @JsonKey()
  final bool aiInsights;
  @override
  @JsonKey()
  final bool appUpdates;
  @override
  @JsonKey()
  final bool settingsNotifications;
  @override
  @JsonKey()
  final bool featureAnnouncements;
  @override
  @JsonKey()
  final bool motivationalMessages;
  @override
  @JsonKey()
  final bool studyTips;
  @override
  @JsonKey()
  final bool communityUpdates;
  @override
  @JsonKey()
  final NotificationFrequency frequency;
  final List<int> _quietHours;
  @override
  @JsonKey()
  List<int> get quietHours {
    if (_quietHours is EqualUnmodifiableListView) return _quietHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quietHours);
  }

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationPreferencesCopyWith<_NotificationPreferences> get copyWith =>
      __$NotificationPreferencesCopyWithImpl<_NotificationPreferences>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NotificationPreferencesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationPreferences &&
            (identical(other.sessionReminders, sessionReminders) ||
                other.sessionReminders == sessionReminders) &&
            (identical(
                    other.achievementNotifications, achievementNotifications) ||
                other.achievementNotifications == achievementNotifications) &&
            (identical(other.leaderboardUpdates, leaderboardUpdates) ||
                other.leaderboardUpdates == leaderboardUpdates) &&
            (identical(other.streakReminders, streakReminders) ||
                other.streakReminders == streakReminders) &&
            (identical(other.dailyGoals, dailyGoals) ||
                other.dailyGoals == dailyGoals) &&
            (identical(other.weeklyReports, weeklyReports) ||
                other.weeklyReports == weeklyReports) &&
            (identical(other.examTips, examTips) ||
                other.examTips == examTips) &&
            (identical(other.aiInsights, aiInsights) ||
                other.aiInsights == aiInsights) &&
            (identical(other.appUpdates, appUpdates) ||
                other.appUpdates == appUpdates) &&
            (identical(other.settingsNotifications, settingsNotifications) ||
                other.settingsNotifications == settingsNotifications) &&
            (identical(other.featureAnnouncements, featureAnnouncements) ||
                other.featureAnnouncements == featureAnnouncements) &&
            (identical(other.motivationalMessages, motivationalMessages) ||
                other.motivationalMessages == motivationalMessages) &&
            (identical(other.studyTips, studyTips) ||
                other.studyTips == studyTips) &&
            (identical(other.communityUpdates, communityUpdates) ||
                other.communityUpdates == communityUpdates) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality()
                .equals(other._quietHours, _quietHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sessionReminders,
      achievementNotifications,
      leaderboardUpdates,
      streakReminders,
      dailyGoals,
      weeklyReports,
      examTips,
      aiInsights,
      appUpdates,
      settingsNotifications,
      featureAnnouncements,
      motivationalMessages,
      studyTips,
      communityUpdates,
      frequency,
      const DeepCollectionEquality().hash(_quietHours));

  @override
  String toString() {
    return 'NotificationPreferences(sessionReminders: $sessionReminders, achievementNotifications: $achievementNotifications, leaderboardUpdates: $leaderboardUpdates, streakReminders: $streakReminders, dailyGoals: $dailyGoals, weeklyReports: $weeklyReports, examTips: $examTips, aiInsights: $aiInsights, appUpdates: $appUpdates, settingsNotifications: $settingsNotifications, featureAnnouncements: $featureAnnouncements, motivationalMessages: $motivationalMessages, studyTips: $studyTips, communityUpdates: $communityUpdates, frequency: $frequency, quietHours: $quietHours)';
  }
}

/// @nodoc
abstract mixin class _$NotificationPreferencesCopyWith<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  factory _$NotificationPreferencesCopyWith(_NotificationPreferences value,
          $Res Function(_NotificationPreferences) _then) =
      __$NotificationPreferencesCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool sessionReminders,
      bool achievementNotifications,
      bool leaderboardUpdates,
      bool streakReminders,
      bool dailyGoals,
      bool weeklyReports,
      bool examTips,
      bool aiInsights,
      bool appUpdates,
      bool settingsNotifications,
      bool featureAnnouncements,
      bool motivationalMessages,
      bool studyTips,
      bool communityUpdates,
      NotificationFrequency frequency,
      List<int> quietHours});
}

/// @nodoc
class __$NotificationPreferencesCopyWithImpl<$Res>
    implements _$NotificationPreferencesCopyWith<$Res> {
  __$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final _NotificationPreferences _self;
  final $Res Function(_NotificationPreferences) _then;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sessionReminders = null,
    Object? achievementNotifications = null,
    Object? leaderboardUpdates = null,
    Object? streakReminders = null,
    Object? dailyGoals = null,
    Object? weeklyReports = null,
    Object? examTips = null,
    Object? aiInsights = null,
    Object? appUpdates = null,
    Object? settingsNotifications = null,
    Object? featureAnnouncements = null,
    Object? motivationalMessages = null,
    Object? studyTips = null,
    Object? communityUpdates = null,
    Object? frequency = null,
    Object? quietHours = null,
  }) {
    return _then(_NotificationPreferences(
      sessionReminders: null == sessionReminders
          ? _self.sessionReminders
          : sessionReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      achievementNotifications: null == achievementNotifications
          ? _self.achievementNotifications
          : achievementNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      leaderboardUpdates: null == leaderboardUpdates
          ? _self.leaderboardUpdates
          : leaderboardUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      streakReminders: null == streakReminders
          ? _self.streakReminders
          : streakReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyGoals: null == dailyGoals
          ? _self.dailyGoals
          : dailyGoals // ignore: cast_nullable_to_non_nullable
              as bool,
      weeklyReports: null == weeklyReports
          ? _self.weeklyReports
          : weeklyReports // ignore: cast_nullable_to_non_nullable
              as bool,
      examTips: null == examTips
          ? _self.examTips
          : examTips // ignore: cast_nullable_to_non_nullable
              as bool,
      aiInsights: null == aiInsights
          ? _self.aiInsights
          : aiInsights // ignore: cast_nullable_to_non_nullable
              as bool,
      appUpdates: null == appUpdates
          ? _self.appUpdates
          : appUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      settingsNotifications: null == settingsNotifications
          ? _self.settingsNotifications
          : settingsNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      featureAnnouncements: null == featureAnnouncements
          ? _self.featureAnnouncements
          : featureAnnouncements // ignore: cast_nullable_to_non_nullable
              as bool,
      motivationalMessages: null == motivationalMessages
          ? _self.motivationalMessages
          : motivationalMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      studyTips: null == studyTips
          ? _self.studyTips
          : studyTips // ignore: cast_nullable_to_non_nullable
              as bool,
      communityUpdates: null == communityUpdates
          ? _self.communityUpdates
          : communityUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as NotificationFrequency,
      quietHours: null == quietHours
          ? _self._quietHours
          : quietHours // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
mixin _$Achievement {
  String get id;
  String get title;
  String get description;
  AchievementCategory get category;
  int get points;
  String? get iconUrl;
  DateTime get unlockedAt;
  Map<String, dynamic>? get metadata;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AchievementCopyWith<Achievement> get copyWith =>
      _$AchievementCopyWithImpl<Achievement>(this as Achievement, _$identity);

  /// Serializes this Achievement to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Achievement &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      category,
      points,
      iconUrl,
      unlockedAt,
      const DeepCollectionEquality().hash(metadata));

  @override
  String toString() {
    return 'Achievement(id: $id, title: $title, description: $description, category: $category, points: $points, iconUrl: $iconUrl, unlockedAt: $unlockedAt, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $AchievementCopyWith<$Res> {
  factory $AchievementCopyWith(
          Achievement value, $Res Function(Achievement) _then) =
      _$AchievementCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      AchievementCategory category,
      int points,
      String? iconUrl,
      DateTime unlockedAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$AchievementCopyWithImpl<$Res> implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._self, this._then);

  final Achievement _self;
  final $Res Function(Achievement) _then;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? points = null,
    Object? iconUrl = freezed,
    Object? unlockedAt = null,
    Object? metadata = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as AchievementCategory,
      points: null == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      iconUrl: freezed == iconUrl
          ? _self.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      unlockedAt: null == unlockedAt
          ? _self.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Achievement].
extension AchievementPatterns on Achievement {
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
    TResult Function(_Achievement value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Achievement() when $default != null:
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
    TResult Function(_Achievement value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Achievement():
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
    TResult? Function(_Achievement value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Achievement() when $default != null:
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
    TResult Function(
            String id,
            String title,
            String description,
            AchievementCategory category,
            int points,
            String? iconUrl,
            DateTime unlockedAt,
            Map<String, dynamic>? metadata)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Achievement() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.category,
            _that.points,
            _that.iconUrl,
            _that.unlockedAt,
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
    TResult Function(
            String id,
            String title,
            String description,
            AchievementCategory category,
            int points,
            String? iconUrl,
            DateTime unlockedAt,
            Map<String, dynamic>? metadata)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Achievement():
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.category,
            _that.points,
            _that.iconUrl,
            _that.unlockedAt,
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
    TResult? Function(
            String id,
            String title,
            String description,
            AchievementCategory category,
            int points,
            String? iconUrl,
            DateTime unlockedAt,
            Map<String, dynamic>? metadata)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Achievement() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.category,
            _that.points,
            _that.iconUrl,
            _that.unlockedAt,
            _that.metadata);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Achievement extends Achievement {
  const _Achievement(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.points,
      this.iconUrl,
      required this.unlockedAt,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata,
        super._();
  factory _Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final AchievementCategory category;
  @override
  final int points;
  @override
  final String? iconUrl;
  @override
  final DateTime unlockedAt;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AchievementCopyWith<_Achievement> get copyWith =>
      __$AchievementCopyWithImpl<_Achievement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AchievementToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Achievement &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      category,
      points,
      iconUrl,
      unlockedAt,
      const DeepCollectionEquality().hash(_metadata));

  @override
  String toString() {
    return 'Achievement(id: $id, title: $title, description: $description, category: $category, points: $points, iconUrl: $iconUrl, unlockedAt: $unlockedAt, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$AchievementCopyWith<$Res>
    implements $AchievementCopyWith<$Res> {
  factory _$AchievementCopyWith(
          _Achievement value, $Res Function(_Achievement) _then) =
      __$AchievementCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      AchievementCategory category,
      int points,
      String? iconUrl,
      DateTime unlockedAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$AchievementCopyWithImpl<$Res> implements _$AchievementCopyWith<$Res> {
  __$AchievementCopyWithImpl(this._self, this._then);

  final _Achievement _self;
  final $Res Function(_Achievement) _then;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? points = null,
    Object? iconUrl = freezed,
    Object? unlockedAt = null,
    Object? metadata = freezed,
  }) {
    return _then(_Achievement(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as AchievementCategory,
      points: null == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      iconUrl: freezed == iconUrl
          ? _self.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      unlockedAt: null == unlockedAt
          ? _self.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$AchievementProgress {
  String get achievementId;
  int get current;
  int get target;
  bool get isUnlocked;

  /// Create a copy of AchievementProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AchievementProgressCopyWith<AchievementProgress> get copyWith =>
      _$AchievementProgressCopyWithImpl<AchievementProgress>(
          this as AchievementProgress, _$identity);

  /// Serializes this AchievementProgress to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AchievementProgress &&
            (identical(other.achievementId, achievementId) ||
                other.achievementId == achievementId) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, achievementId, current, target, isUnlocked);

  @override
  String toString() {
    return 'AchievementProgress(achievementId: $achievementId, current: $current, target: $target, isUnlocked: $isUnlocked)';
  }
}

/// @nodoc
abstract mixin class $AchievementProgressCopyWith<$Res> {
  factory $AchievementProgressCopyWith(
          AchievementProgress value, $Res Function(AchievementProgress) _then) =
      _$AchievementProgressCopyWithImpl;
  @useResult
  $Res call({String achievementId, int current, int target, bool isUnlocked});
}

/// @nodoc
class _$AchievementProgressCopyWithImpl<$Res>
    implements $AchievementProgressCopyWith<$Res> {
  _$AchievementProgressCopyWithImpl(this._self, this._then);

  final AchievementProgress _self;
  final $Res Function(AchievementProgress) _then;

  /// Create a copy of AchievementProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievementId = null,
    Object? current = null,
    Object? target = null,
    Object? isUnlocked = null,
  }) {
    return _then(_self.copyWith(
      achievementId: null == achievementId
          ? _self.achievementId
          : achievementId // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _self.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as int,
      isUnlocked: null == isUnlocked
          ? _self.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [AchievementProgress].
extension AchievementProgressPatterns on AchievementProgress {
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
    TResult Function(_AchievementProgress value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AchievementProgress() when $default != null:
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
    TResult Function(_AchievementProgress value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AchievementProgress():
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
    TResult? Function(_AchievementProgress value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AchievementProgress() when $default != null:
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
    TResult Function(
            String achievementId, int current, int target, bool isUnlocked)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AchievementProgress() when $default != null:
        return $default(
            _that.achievementId, _that.current, _that.target, _that.isUnlocked);
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
    TResult Function(
            String achievementId, int current, int target, bool isUnlocked)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AchievementProgress():
        return $default(
            _that.achievementId, _that.current, _that.target, _that.isUnlocked);
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
    TResult? Function(
            String achievementId, int current, int target, bool isUnlocked)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AchievementProgress() when $default != null:
        return $default(
            _that.achievementId, _that.current, _that.target, _that.isUnlocked);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AchievementProgress extends AchievementProgress {
  const _AchievementProgress(
      {required this.achievementId,
      required this.current,
      required this.target,
      this.isUnlocked = false})
      : super._();
  factory _AchievementProgress.fromJson(Map<String, dynamic> json) =>
      _$AchievementProgressFromJson(json);

  @override
  final String achievementId;
  @override
  final int current;
  @override
  final int target;
  @override
  @JsonKey()
  final bool isUnlocked;

  /// Create a copy of AchievementProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AchievementProgressCopyWith<_AchievementProgress> get copyWith =>
      __$AchievementProgressCopyWithImpl<_AchievementProgress>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AchievementProgressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AchievementProgress &&
            (identical(other.achievementId, achievementId) ||
                other.achievementId == achievementId) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, achievementId, current, target, isUnlocked);

  @override
  String toString() {
    return 'AchievementProgress(achievementId: $achievementId, current: $current, target: $target, isUnlocked: $isUnlocked)';
  }
}

/// @nodoc
abstract mixin class _$AchievementProgressCopyWith<$Res>
    implements $AchievementProgressCopyWith<$Res> {
  factory _$AchievementProgressCopyWith(_AchievementProgress value,
          $Res Function(_AchievementProgress) _then) =
      __$AchievementProgressCopyWithImpl;
  @override
  @useResult
  $Res call({String achievementId, int current, int target, bool isUnlocked});
}

/// @nodoc
class __$AchievementProgressCopyWithImpl<$Res>
    implements _$AchievementProgressCopyWith<$Res> {
  __$AchievementProgressCopyWithImpl(this._self, this._then);

  final _AchievementProgress _self;
  final $Res Function(_AchievementProgress) _then;

  /// Create a copy of AchievementProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? achievementId = null,
    Object? current = null,
    Object? target = null,
    Object? isUnlocked = null,
  }) {
    return _then(_AchievementProgress(
      achievementId: null == achievementId
          ? _self.achievementId
          : achievementId // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _self.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as int,
      isUnlocked: null == isUnlocked
          ? _self.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
