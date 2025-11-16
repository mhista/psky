import 'package:ahiaa_web/features/coach_kai/data/models/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

/// Represents the state of a chat, as the list of messages.
@freezed
abstract class ChatModel with _$ChatModel {
  /// Private constructor for internal use.
  const ChatModel._();

  /// Creates a new [ChatModel] with the given list of messages.
  const factory ChatModel({required List<Message> messages}) = _ChatModel;

  /// Creates an initial [ChatModel] with an empty list of messages.
  factory ChatModel.initial() => const ChatModel(messages: []);

  /// Creates a [ChatModel] instance from a JSON map.
  factory ChatModel.fromJson(Map<String, Object?> json) =>
      _$ChatModelFromJson(json);
}
