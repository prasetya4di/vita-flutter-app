import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:random_string/random_string.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart'
    as request;
import 'package:vita_client_app/domain/load_message.dart';
import 'package:vita_client_app/domain/load_possibility.dart';
import 'package:vita_client_app/domain/pick_image.dart';
import 'package:vita_client_app/domain/reply_message.dart';
import 'package:vita_client_app/domain/scan_image.dart';
import 'package:vita_client_app/domain/send_message.dart';
import 'package:vita_client_app/view/chat/bloc/chat_bloc.dart';
import 'package:vita_client_app/view/chat/bloc/chat_state.dart';

import '../util/dummy_builder.dart';
import 'chat_bloc_test.mocks.dart';

@GenerateMocks([
  LoadMessage,
  LoadPossibility,
  SendMessage,
  PickImage,
  ScanImage,
  ReplyMessage
])
void main() {
  late LoadMessage mockLoadMessage;
  late LoadPossibility mockLoadPossibility;
  late SendMessage mockSendMessage;
  late PickImage mockPickImage;
  late ScanImage mockScanImage;
  late ReplyMessage mockReplyMessage;
  late ChatBloc chatBloc;

  setUp(() {
    mockLoadMessage = MockLoadMessage();
    mockLoadPossibility = MockLoadPossibility();
    mockSendMessage = MockSendMessage();
    mockPickImage = MockPickImage();
    mockScanImage = MockScanImage();
    mockReplyMessage = MockReplyMessage();
    chatBloc = ChatBloc(mockLoadMessage, mockLoadPossibility, mockSendMessage,
        mockPickImage, mockScanImage, mockReplyMessage);
  });

  tearDown(() {
    chatBloc.close();
  });

  blocTest<ChatBloc, ChatState>(
      "emit [LoadingState, LoadedState] states for successful load message",
      build: () => chatBloc,
      act: (bloc) => bloc.add(const LoadMessageEvent()),
      expect: () => [const ChatState.loading(), const ChatState.loadedState()],
      setUp: () {
        List<Message> expectedMessages = createListMessage();
        List<ImagePossibility> expectedPossibilities = createPossibilities();
        when(mockLoadMessage.call())
            .thenAnswer((_) => Future.value(expectedMessages));
        when(mockLoadPossibility.call())
            .thenAnswer((_) => Future.value(expectedPossibilities));
      },
      verify: (bloc) {
        verify(mockLoadMessage.call());
        verify(mockLoadPossibility.call());
      });

  group("Test send message", () {
    Message expectedMessage = createMessage();
    request.SendMessage requestMessage =
        request.SendMessage(expectedMessage.message);
    List<Message> messages = [expectedMessage];
    HttpException expectedError = HttpException(randomString(5));

    blocTest<ChatBloc, ChatState>(
        'Send message success should emit [MessageSendingState, MessageSendedState] and update list message',
        build: () => chatBloc,
        act: (bloc) => bloc.add(SendMessageEvent(expectedMessage.message)),
        expect: () => [
              const ChatState.messageSendingState(),
              const ChatState.messageSendedState()
            ],
        setUp: () {
          when(mockSendMessage.call(requestMessage))
              .thenAnswer((_) => Future.value(messages));
        },
        verify: (bloc) {
          verify(mockSendMessage.call(requestMessage));
          expect(bloc.messages, messages);
        });

    blocTest<ChatBloc, ChatState>(
        "Send message error should store error message in list message and emit [MessageSendingState, MessageErrorState]",
        build: () => chatBloc,
        act: (bloc) => bloc.add(SendMessageEvent(expectedMessage.message)),
        expect: () => [
              const ChatState.messageSendingState(),
              ChatState.error(expectedError.toString())
            ],
        setUp: () {
          when(mockSendMessage.call(requestMessage)).thenThrow(expectedError);
        },
        verify: (bloc) {
          verifyNever(mockSendMessage.call(requestMessage));
          request.SendMessage firstValue = bloc.messages.first;
          expect(firstValue.isError, true);
        });
  });
}
