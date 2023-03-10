import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/reply_message.dart'
    as request;
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/domain/impl/reply_message_impl.dart';
import 'package:vita_client_app/domain/reply_message.dart';
import 'package:vita_client_app/repository/image_repository.dart';
import 'package:vita_client_app/repository/message_repository.dart';

import '../util/dummy_builder.dart';
import 'reply_message_test.mocks.dart';

@GenerateMocks([MessageRepository, ImageRepository])
void main() {
  late MessageRepository mockMessageRepository;
  late ImageRepository mockImageRepository;
  late ReplyMessage replyMessage;

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    mockImageRepository = MockImageRepository();
    replyMessage = ReplyMessageImpl(mockMessageRepository, mockImageRepository);
  });

  group("Test reply message", () {
    request.ReplyMessage req = createReplyMessageRequest();
    List<Message> expectedListMessage = createListMessage();

    test("Reply message success", () async {
      Response<List<Message>> expectedResponse = Response(
          http.Response(
              jsonEncode(expectedListMessage.map((e) => e.toJson()).toList()),
              HttpStatus.ok),
          expectedListMessage);

      when(mockMessageRepository.replyMessage(req))
          .thenAnswer((_) => Future.value(expectedResponse));
      when(mockMessageRepository.inserts(expectedListMessage))
          .thenReturn(() {});
      when(mockImageRepository.clear()).thenReturn(() {});

      var response = await replyMessage.call(req);

      verify(mockMessageRepository.replyMessage(req));
      verify(mockMessageRepository.inserts(expectedListMessage));
      verify(mockImageRepository.clear());

      expect(response, Right(expectedListMessage));
    });

    test("Reply message failed should return response error", () async {
      ResponseError expectedResponseError = createResponseError();
      Response<List<Message>> expectedResponse = Response(
          http.Response(jsonEncode(expectedResponseError.toJson()),
              HttpStatus.unauthorized),
          null,
          error: expectedResponseError);

      when(mockMessageRepository.replyMessage(req))
          .thenAnswer((_) => Future.value(expectedResponse));

      var response = await replyMessage.call(req);

      verify(mockMessageRepository.replyMessage(req));

      expect(response, Left(expectedResponseError));
    });

    test("Reply message error should throw error", () {
      HttpException expectedError = const HttpException("Invalid url");
      when(mockMessageRepository.replyMessage(req)).thenThrow(expectedError);
      verifyNever(mockMessageRepository.replyMessage(req));
      expect(() => replyMessage.call(req),
          throwsA(const TypeMatcher<HttpException>()));
    });
  });
}
