part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.started() = Started;
  const factory ChatEvent.sendMessage({required String message}) = SendMessage;
}
