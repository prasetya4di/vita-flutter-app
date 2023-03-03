import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/domain/fetch_message.dart';
import 'package:vita_client_app/domain/impl/fetch_message_impl.dart';
import 'package:vita_client_app/repository/message_repository.dart';

import '../util/dummy_builder.dart';
import 'fetch_message_test.mocks.dart';

@GenerateMocks([MessageRepository])
void main() {
  late MessageRepository mockRepository;
  late FetchMessage fetchMessage;

  setUp(() {
    mockRepository = MockMessageRepository();
    fetchMessage = FetchMessageImpl(mockRepository);
  });

  group("Test fetch message", () {
    List<Message> expectedMessages = createListMessage();

    test("Fetch message success", () async {
      Response<List<Message>> expectedResponse = Response(
          http.Response(
              jsonEncode(expectedMessages.map((e) => e.toJson()).toList()),
              200),
          expectedMessages);
      when(mockRepository.getMessage())
          .thenAnswer((_) => Future.value(expectedResponse));
      when(mockRepository.clear()).thenReturn(() {});
      when(mockRepository.inserts(expectedMessages)).thenReturn(() {});
      List<Message> messages = await fetchMessage.call();
      verify(mockRepository.clear());
      verify(mockRepository.inserts(expectedMessages));
      verify(mockRepository.getMessage());
      expect(messages, expectedMessages);
    });

    test("Fetch message failed should return empty list", () async {
      ResponseError expectedResponseError = createResponseError();
      var expectedResponse = Response<List<Message>>(
          http.Response(jsonEncode(expectedResponseError.toJson()), 401), null,
          error: expectedResponseError);
      when(mockRepository.getMessage())
          .thenAnswer((_) => Future.value(expectedResponse));
      var response = await fetchMessage.call();
      verify(mockRepository.getMessage());
      expect(response, []);
    });

    test("Fetch message error should throw an error", () async {
      HttpException expectedError = const HttpException("Invalid url");
      when(mockRepository.getMessage()).thenThrow(expectedError);
      verifyNever(mockRepository.getMessage());
      expect(() => fetchMessage.call(),
          throwsA(const TypeMatcher<HttpException>()));
    });
  });
}
