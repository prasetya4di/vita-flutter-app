import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart'
    as request;
import 'package:vita_client_app/domain/impl/send_message_impl.dart';
import 'package:vita_client_app/domain/send_message.dart';
import 'package:vita_client_app/repository/message_repository.dart';

import '../util/dummy_builder.dart';
import 'send_image_test.mocks.dart';

@GenerateMocks([MessageRepository])
void main() {
  late MessageRepository mockMessageRepository;
  late SendMessage sendMessage;

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    sendMessage = SendMessageImpl(mockMessageRepository);
  });

  group("Test send message", () {
    request.SendMessage req = createSendMessageRequest();
    List<Message> expectedListMessage = createListMessage();

    test("Send message success", () async {
      Response<List<Message>> expectedResponse = Response(
          http.Response(
              jsonEncode(expectedListMessage.map((e) => e.toJson()).toList()),
              HttpStatus.created),
          expectedListMessage);

      when(mockMessageRepository.sendMessage(req))
          .thenAnswer((_) => Future.value(expectedResponse));
      when(mockMessageRepository.inserts(expectedListMessage))
          .thenReturn(() {});

      var response = await sendMessage.call(req);

      verify(mockMessageRepository.sendMessage(req));
      verify(mockMessageRepository.inserts(expectedListMessage));

      expect(response, expectedListMessage);
    });

    test("Send message error should throw an error", () {
      HttpException expectedError = const HttpException("Invalid url");
      when(mockMessageRepository.sendMessage(req)).thenThrow(expectedError);
      verifyNever(mockMessageRepository.sendMessage(req));
      expect(() => sendMessage.call(req),
          throwsA(const TypeMatcher<HttpException>()));
    });
  });
}
