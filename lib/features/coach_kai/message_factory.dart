import 'package:ahiaa_web/core/utils/enums/enums.dart';

import 'data/models/message.dart';
import 'package:uuid/uuid.dart';

class MessageFactory {
  static final _uuid = Uuid();

  static Message createUserMessage(String content) {
    return Message(
      id: _uuid.v4(),
      content: content,
      role: MessageRole.user,
      updatedAt: DateTime.now().toUtc(),
      state: MessageState.complete,
    );
  }

  static Message createLlmMessage(String content, MessageState state) {
    return Message(
      id: _uuid.v4(),
      content: content,
      role: MessageRole.llm,
      updatedAt: DateTime.now().toUtc(),
      state: state,
    );
  }
}
