import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';
import 'package:vita_client_app/data/model/response/login_response.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/domain/impl/post_login_impl.dart';
import 'package:vita_client_app/domain/post_login.dart';
import 'package:vita_client_app/repository/user_repository.dart';

import '../util/dummy_builder.dart';
import 'post_login.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late UserRepository mockUserRepository;
  late PostLogin postLogin;

  setUp(() {
    mockUserRepository = MockUserRepository();
    postLogin = PostLoginImpl(mockUserRepository);
  });

  group("Test post login", () {
    LoginRequest request = createLoginRequest();
    LoginResponse expectedLoginResponse = LoginResponse(createUser());

    test("Login success", () async {
      Response<LoginResponse> expectedResponse = Response(
          http.Response(
              jsonEncode(expectedLoginResponse.toJson()), HttpStatus.ok),
          expectedLoginResponse);
      when(mockUserRepository.login(request))
          .thenAnswer((_) => Future.value(expectedResponse));
      when(mockUserRepository.insert(expectedLoginResponse.user))
          .thenReturn(() {});
      when(mockUserRepository.clear()).thenReturn(() {});
      var response = await postLogin.call(request);
      verify(mockUserRepository.login(request));
      verify(mockUserRepository.insert(expectedLoginResponse.user));
      verify(mockUserRepository.clear());
      expect(response, Right(expectedLoginResponse.user));
    });

    test("Login failed", () async {
      ResponseError expectedResponseError = createResponseError();
      Response<LoginResponse> expectedResponse = Response(
          http.Response(jsonEncode(expectedResponseError.toJson()),
              HttpStatus.unauthorized),
          null,
          error: expectedResponseError);
      when(mockUserRepository.login(request))
          .thenAnswer((_) => Future.value(expectedResponse));
      var response = await postLogin.call(request);
      verify(mockUserRepository.login(request));
      expect(response, Left(expectedResponseError));
    });

    test("Login error should throw an error", () {
      HttpException expectedError = const HttpException("Invalid url");
      when(mockUserRepository.login(request)).thenThrow(expectedError);
      verifyNever(mockUserRepository.login(request));
      expect(() => postLogin.call(request),
          throwsA(const TypeMatcher<HttpException>()));
    });
  });
}
