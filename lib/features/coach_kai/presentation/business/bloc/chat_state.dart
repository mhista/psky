part of 'chat_bloc.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState.success() = ChatSuccess;

  const factory ChatState.failure() = ChatFailure;
  const factory ChatState.initial() = ChatInitial;
  const factory ChatState.loading() = ChatLoading;
  const factory ChatState.error({required String message}) = ChatError;
}
