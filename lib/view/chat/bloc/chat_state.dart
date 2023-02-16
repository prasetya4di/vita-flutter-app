import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.freezed.dart';

@freezed
abstract class ChatEvent with _$ChatEvent {
  const factory ChatEvent.onLoadMessage() = LoadMessageEvent;

  const factory ChatEvent.onSendMessage(String message) = SendMessageEvent;
}

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState.initial() = ChatInitialState;

  const factory ChatState.loading() = ChatLoadingState;

  const factory ChatState.error(String message) = ChatErrorState;

  const factory ChatState.loadedState() = ChatLoadedState;

  const factory ChatState.messageSendingState() = ChatSendingState;

  const factory ChatState.messageSendedState() = ChatSendedState;
}
