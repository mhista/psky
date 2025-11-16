
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/features/coach_kai/data/models/chat.dart';
import 'package:ahiaa_web/features/coach_kai/data/models/message.dart';
import 'package:ahiaa_web/features/coach_kai/message_factory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChatCubit extends Cubit<ChatModel> {
  /// Creates an initial [ChatModel] with an empty list of messages.
  ChatCubit() : super(ChatModel.initial());

  /// Adds a new user message to the chat, with [content] being the text.
  void addUserMessage(String content) {
    final newMessage = MessageFactory.createUserMessage(content);
    emit(state.copyWith(messages: [...state.messages, newMessage]));
  }

  /// Adds a new LLM (Large Language Model) message to the chat and returns
  /// the newly added message. The [content] parameter is the text content of
  /// the LLM's message and the [messageState] parameter indicates the current
  /// state of the message (e.g., complete, streaming).
  void addLlmMessage(String content, MessageState messageState) {
    final newMessage = MessageFactory.createLlmMessage(content, messageState);
    emit(state.copyWith(messages: [...state.messages, newMessage]));
  }

  /// Create a new LLM message to the chat and return the newly created message.
  /// Append content with the [appendToMessage] method, and finalize the message
  /// with [finalizeMessage].
  Message createLlmMessage() {
    addLlmMessage('', MessageState.streaming);
    return state.messages.last;
  }

  /// Appends additional content, as [addContent], to an existing
  /// message identified by [id]. If no message with the given [id]
  /// is found, the current [ChatModel] is returned unchanged.
  void appendToMessage(String id, String addContent) {
    final updatedMessages = state.messages.map((msg) {
      if (msg.id == id) {
        return msg.copyWith(content: msg.content + addContent);
      }
      return msg;
    }).toList();
    emit(state.copyWith(messages: updatedMessages));
  }

  /// Finalizes a message in the chat, identified by [id], marking it as
  /// complete. If no message with the given [id] is found, the current
  /// [ChatModel] is returned unchanged.
  void finalizeMessage(String id) {
    final updatedMessages = state.messages.map((msg) {
      if (msg.id == id) {
        return msg.copyWith(
          state: MessageState.complete,
          content: msg.content.trimRight(),
        );
      }
      return msg;
    }).toList();
    emit(state.copyWith(messages: updatedMessages));
  }

  /// Clears all messages from the chat.
  void clear() => emit(ChatModel.initial());
}
