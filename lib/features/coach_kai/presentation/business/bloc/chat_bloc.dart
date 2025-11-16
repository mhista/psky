import 'package:ahiaa_web/core/services/gemini_chat_service.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState.initial()) {
    on<SendMessage>(_sendMessage);
  }

  void _sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    await getIt<GeminiChatService>().sendMessage(event.message);
    emit(ChatSuccess());
  }
}
