import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectbox/objectbox.dart';
import 'package:random_string/random_string.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/reply_message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/data/source/local/message_dao.dart';
import 'package:vita_client_app/data/source/network/message_service.dart';
import 'package:vita_client_app/repository/impl/message_repository_impl.dart';
import 'package:vita_client_app/repository/message_repository.dart';

import '../util/dummy_builder.dart';
import 'message_repository_test.mocks.dart';

@GenerateMocks([MessageDao, MessageService])
void main() {
  late MessageDao mockMessageDao;
  late MessageService mockMessageService;
  late MessageRepository messageRepository;

  setUp(() {
    mockMessageDao = MockMessageDao();
    mockMessageService = MockMessageService();
    messageRepository =
        MessageRepositoryImpl(mockMessageDao, mockMessageService);
  });

  test("Insert messages success", () {
    var expectedMessages = createListMessage();
    when(mockMessageDao.inserts(expectedMessages)).thenReturn(() {});
    messageRepository.inserts(expectedMessages);
    verify(mockMessageDao.inserts(expectedMessages));
  });

  test("Insert message error should throw error", () {
    var expectedMessages = createListMessage();
    var expectedError = ObjectBoxException("Wrong data");
    when(mockMessageDao.inserts(expectedMessages)).thenThrow(expectedError);
    verifyNever(mockMessageDao.inserts(expectedMessages));
    expect(
      () => messageRepository.inserts(expectedMessages),
      throwsA(const TypeMatcher<ObjectBoxException>()),
    );
  });

  test("Read message success", () async {
    var expectedMessages = createListMessage();
    when(mockMessageDao.get())
        .thenAnswer((_) => Future.value(expectedMessages));
    var messages = await messageRepository.read();
    expect(messages, expectedMessages);
  });

  test("Read message error should throw error", () {
    var expectedException = ObjectBoxException("Data error");
    when(mockMessageDao.get()).thenThrow(expectedException);
    verifyNever(mockMessageDao.get());
    expect(() => messageRepository.read(),
        throwsA(const TypeMatcher<ObjectBoxException>()));
  });

  test("Get message success", () async {
    List<Message> expectedMessages = createListMessage();
    var expectedResponse = Response(
        http.Response(
            jsonEncode(expectedMessages.map((e) => e.toJson()).toList()), 200),
        expectedMessages);
    when(mockMessageService.getMessage())
        .thenAnswer((_) => Future.value(expectedResponse));
    var response = await messageRepository.getMessage();
    verify(mockMessageService.getMessage());
    expect(response, expectedResponse);
  });

  test("Get message failed should return response error", () async {
    ResponseError expectedResponseError = ResponseError(randomString(5));
    var expectedResponse = Response<List<Message>>(
        http.Response(jsonEncode(expectedResponseError.toJson()), 401), null,
        error: expectedResponseError);
    when(mockMessageService.getMessage())
        .thenAnswer((_) => Future.value(expectedResponse));
    verifyNever(mockMessageService.getMessage());
    var response = await messageRepository.getMessage();
    expect(response, expectedResponse);
    expect(response.error, expectedResponse.error);
  });

  test("Get message error should throw an error", () {
    HttpException expectedError = const HttpException("Invalid url");
    when(mockMessageService.getMessage()).thenThrow(expectedError);
    verifyNever(mockMessageService.getMessage());
    expect(() => messageRepository.getMessage(),
        throwsA(const TypeMatcher<HttpException>()));
  });

  group("Send message", () {
    SendMessage request = createSendMessageRequest();

    test("Send message success", () async {
      List<Message> expectedMessages = createListMessage();
      var expectedResponse = Response(
          http.Response(
              jsonEncode(expectedMessages.map((e) => e.toJson()).toList()),
              200),
          expectedMessages);
      when(mockMessageService.sendMessage(request))
          .thenAnswer((_) => Future.value(expectedResponse));
      var response = await messageRepository.sendMessage(request);
      verify(mockMessageService.sendMessage(request));
      expect(response, expectedResponse);
    });

    test("Send message failed should return response error", () async {
      ResponseError expectedResponseError = ResponseError(randomString(5));
      var expectedResponse = Response<List<Message>>(
          http.Response(jsonEncode(expectedResponseError.toJson()), 401), null,
          error: expectedResponseError);
      when(mockMessageService.sendMessage(request))
          .thenAnswer((_) => Future.value(expectedResponse));
      verifyNever(mockMessageService.sendMessage(request));
      var response = await messageRepository.sendMessage(request);
      expect(response, expectedResponse);
      expect(response.error, expectedResponse.error);
    });

    test("Send message error should throw an error", () {
      HttpException expectedError = const HttpException("Invalid url");
      when(mockMessageService.sendMessage(request)).thenThrow(expectedError);
      verifyNever(mockMessageService.sendMessage(request));
      expect(() => messageRepository.sendMessage(request),
          throwsA(const TypeMatcher<HttpException>()));
    });
  });

  group("Reply message", () {
    ReplyMessage request = createReplyMessageRequest();

    test("Reply message success", () async {
      List<Message> expectedMessages = createListMessage();
      var expectedResponse = Response(
          http.Response(
              jsonEncode(expectedMessages.map((e) => e.toJson()).toList()),
              200),
          expectedMessages);
      when(mockMessageService.replyMessage(request))
          .thenAnswer((_) => Future.value(expectedResponse));
      var response = await messageRepository.replyMessage(request);
      verify(mockMessageService.replyMessage(request));
      expect(response, expectedResponse);
    });

    test("Reply message failed should return response error", () async {
      ResponseError expectedResponseError = ResponseError(randomString(5));
      var expectedResponse = Response<List<Message>>(
          http.Response(jsonEncode(expectedResponseError.toJson()), 401), null,
          error: expectedResponseError);
      when(mockMessageService.replyMessage(request))
          .thenAnswer((_) => Future.value(expectedResponse));
      verifyNever(mockMessageService.replyMessage(request));
      var response = await messageRepository.replyMessage(request);
      expect(response, expectedResponse);
      expect(response.error, expectedResponse.error);
    });

    test("Reply message error should throw an error", () {
      HttpException expectedError = const HttpException("Invalid url");
      when(mockMessageService.replyMessage(request)).thenThrow(expectedError);
      verifyNever(mockMessageService.replyMessage(request));
      expect(() => messageRepository.replyMessage(request),
          throwsA(const TypeMatcher<HttpException>()));
    });
  });
}
