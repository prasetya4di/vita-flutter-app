import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';
import 'package:vita_client_app/data/model/response/register_response.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/domain/impl/post_register_impl.dart';
import 'package:vita_client_app/domain/post_register.dart';
import 'package:vita_client_app/repository/message_repository.dart';
import 'package:vita_client_app/repository/user_repository.dart';

import '../util/dummy_builder.dart';
import 'post_register.mocks.dart';

@GenerateMocks([UserRepository, MessageRepository])
void main() {
  late UserRepository mockUserRepository;
  late MessageRepository mockMessageRepository;
  late PostRegister postRegister;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockMessageRepository = MockMessageRepository();
    postRegister = PostRegisterImpl(mockUserRepository, mockMessageRepository);
  });

  group("test post register", () {
    RegisterRequest request = createRegisterRequest();
    RegisterResponse expectedRegisterResponse =
        RegisterResponse(createUser(), createMessage());

    test("Register success", () async {
      Response<RegisterResponse> expectedResponse = Response(
          http.Response(
              jsonEncode(expectedRegisterResponse.toJson()), HttpStatus.ok),
          expectedRegisterResponse);
      when(mockUserRepository.insert(expectedRegisterResponse.user))
          .thenReturn(() {});
      when(mockUserRepository.clear()).thenReturn(() {});
      when(mockUserRepository.register(request))
          .thenAnswer((_) => Future.value(expectedResponse));
      when(mockMessageRepository.inserts([expectedRegisterResponse.message]))
          .thenReturn(() {});
      when(mockMessageRepository.clear()).thenReturn(() {});
      var response = await postRegister.call(request);
      verify(mockUserRepository.register(request));
      verify(mockUserRepository.insert(expectedRegisterResponse.user));
      verify(mockUserRepository.clear());
      verify(mockMessageRepository.inserts([expectedRegisterResponse.message]));
      verify(mockMessageRepository.clear());
      expect(response, Right(expectedRegisterResponse.user));
    });

    test("Register failed", () async {
      ResponseError expectedResponseError = createResponseError();
      Response<RegisterResponse> expectedResponse = Response(
          http.Response(jsonEncode(expectedResponseError.toJson()),
              HttpStatus.unauthorized),
          null,
          error: expectedResponseError);
      when(mockUserRepository.register(request))
          .thenAnswer((_) => Future.value(expectedResponse));
      var response = await postRegister.call(request);
      verify(mockUserRepository.register(request));
      expect(response, Left(expectedResponseError));
    });

    test("Register error should throw an error", () {
      HttpException expectedError = const HttpException("Invalid url");
      when(mockUserRepository.register(request)).thenThrow(expectedError);
      verifyNever(mockUserRepository.register(request));
      expect(() => postRegister.call(request),
          throwsA(const TypeMatcher<HttpException>()));
    });
  });
}
