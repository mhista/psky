// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatEvent()';
  }
}

/// @nodoc
class $ChatEventCopyWith<$Res> {
  $ChatEventCopyWith(ChatEvent _, $Res Function(ChatEvent) __);
}

/// Adds pattern-matching-related methods to [ChatEvent].
extension ChatEventPatterns on ChatEvent {
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
    TResult Function(Started value)? started,
    TResult Function(SendMessage value)? sendMessage,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Started() when started != null:
        return started(_that);
      case SendMessage() when sendMessage != null:
        return sendMessage(_that);
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
    required TResult Function(Started value) started,
    required TResult Function(SendMessage value) sendMessage,
  }) {
    final _that = this;
    switch (_that) {
      case Started():
        return started(_that);
      case SendMessage():
        return sendMessage(_that);
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
    TResult? Function(Started value)? started,
    TResult? Function(SendMessage value)? sendMessage,
  }) {
    final _that = this;
    switch (_that) {
      case Started() when started != null:
        return started(_that);
      case SendMessage() when sendMessage != null:
        return sendMessage(_that);
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
    TResult Function()? started,
    TResult Function(String message)? sendMessage,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Started() when started != null:
        return started();
      case SendMessage() when sendMessage != null:
        return sendMessage(_that.message);
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
    required TResult Function() started,
    required TResult Function(String message) sendMessage,
  }) {
    final _that = this;
    switch (_that) {
      case Started():
        return started();
      case SendMessage():
        return sendMessage(_that.message);
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
    TResult? Function()? started,
    TResult? Function(String message)? sendMessage,
  }) {
    final _that = this;
    switch (_that) {
      case Started() when started != null:
        return started();
      case SendMessage() when sendMessage != null:
        return sendMessage(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Started implements ChatEvent {
  const Started();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatEvent.started()';
  }
}

/// @nodoc

class SendMessage implements ChatEvent {
  const SendMessage({required this.message});

  final String message;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SendMessageCopyWith<SendMessage> get copyWith =>
      _$SendMessageCopyWithImpl<SendMessage>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SendMessage &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'ChatEvent.sendMessage(message: $message)';
  }
}

/// @nodoc
abstract mixin class $SendMessageCopyWith<$Res>
    implements $ChatEventCopyWith<$Res> {
  factory $SendMessageCopyWith(
          SendMessage value, $Res Function(SendMessage) _then) =
      _$SendMessageCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$SendMessageCopyWithImpl<$Res> implements $SendMessageCopyWith<$Res> {
  _$SendMessageCopyWithImpl(this._self, this._then);

  final SendMessage _self;
  final $Res Function(SendMessage) _then;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(SendMessage(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ChatState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState()';
  }
}

/// @nodoc
class $ChatStateCopyWith<$Res> {
  $ChatStateCopyWith(ChatState _, $Res Function(ChatState) __);
}

/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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
    TResult Function(ChatSuccess value)? success,
    TResult Function(ChatFailure value)? failure,
    TResult Function(ChatInitial value)? initial,
    TResult Function(ChatLoading value)? loading,
    TResult Function(ChatError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ChatSuccess() when success != null:
        return success(_that);
      case ChatFailure() when failure != null:
        return failure(_that);
      case ChatInitial() when initial != null:
        return initial(_that);
      case ChatLoading() when loading != null:
        return loading(_that);
      case ChatError() when error != null:
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
    required TResult Function(ChatSuccess value) success,
    required TResult Function(ChatFailure value) failure,
    required TResult Function(ChatInitial value) initial,
    required TResult Function(ChatLoading value) loading,
    required TResult Function(ChatError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case ChatSuccess():
        return success(_that);
      case ChatFailure():
        return failure(_that);
      case ChatInitial():
        return initial(_that);
      case ChatLoading():
        return loading(_that);
      case ChatError():
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
    TResult? Function(ChatSuccess value)? success,
    TResult? Function(ChatFailure value)? failure,
    TResult? Function(ChatInitial value)? initial,
    TResult? Function(ChatLoading value)? loading,
    TResult? Function(ChatError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case ChatSuccess() when success != null:
        return success(_that);
      case ChatFailure() when failure != null:
        return failure(_that);
      case ChatInitial() when initial != null:
        return initial(_that);
      case ChatLoading() when loading != null:
        return loading(_that);
      case ChatError() when error != null:
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
    TResult Function()? success,
    TResult Function()? failure,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ChatSuccess() when success != null:
        return success();
      case ChatFailure() when failure != null:
        return failure();
      case ChatInitial() when initial != null:
        return initial();
      case ChatLoading() when loading != null:
        return loading();
      case ChatError() when error != null:
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
    required TResult Function() success,
    required TResult Function() failure,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    final _that = this;
    switch (_that) {
      case ChatSuccess():
        return success();
      case ChatFailure():
        return failure();
      case ChatInitial():
        return initial();
      case ChatLoading():
        return loading();
      case ChatError():
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
    TResult? Function()? success,
    TResult? Function()? failure,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case ChatSuccess() when success != null:
        return success();
      case ChatFailure() when failure != null:
        return failure();
      case ChatInitial() when initial != null:
        return initial();
      case ChatLoading() when loading != null:
        return loading();
      case ChatError() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ChatSuccess implements ChatState {
  const ChatSuccess();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState.success()';
  }
}

/// @nodoc

class ChatFailure implements ChatState {
  const ChatFailure();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState.failure()';
  }
}

/// @nodoc

class ChatInitial implements ChatState {
  const ChatInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState.initial()';
  }
}

/// @nodoc

class ChatLoading implements ChatState {
  const ChatLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState.loading()';
  }
}

/// @nodoc

class ChatError implements ChatState {
  const ChatError({required this.message});

  final String message;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatErrorCopyWith<ChatError> get copyWith =>
      _$ChatErrorCopyWithImpl<ChatError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'ChatState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $ChatErrorCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory $ChatErrorCopyWith(ChatError value, $Res Function(ChatError) _then) =
      _$ChatErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ChatErrorCopyWithImpl<$Res> implements $ChatErrorCopyWith<$Res> {
  _$ChatErrorCopyWithImpl(this._self, this._then);

  final ChatError _self;
  final $Res Function(ChatError) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(ChatError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
