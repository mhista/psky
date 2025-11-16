import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
abstract class Message with _$Message {
  /// Private constructor for internal use by Freezed
  const Message._();

  /// Creates a new [Message] object.
  ///
  /// * [id]: A unique identifier for this message.
  /// * [content]: The text content of the message.
  /// * [role]: The role of the sender (user or llm).
  /// * [updatedAt]: The timestamp indicating the last update to the message.
  /// * [state]: The current state of the message (complete or streaming).
  const factory Message({
    required String id,
    required String content,
    required MessageRole role,
    required DateTime updatedAt,
    required MessageState state,
  }) = _Message;

  /// Creates a [Message] instance from a JSON map.
  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}
