import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectbox/objectbox.dart';
import 'package:random_string/random_string.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';
import 'package:vita_client_app/data/model/response/login_response.dart';
import 'package:vita_client_app/data/model/response/register_response.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/data/source/local/user_dao.dart';
import 'package:vita_client_app/data/source/network/user_service.dart';
import 'package:vita_client_app/repository/impl/user_repository_impl.dart';
import 'package:vita_client_app/repository/user_repository.dart';

import '../util/dummy_builder.dart';
import 'user_repository_test.mocks.dart';

@GenerateMocks([UserService, UserDao])
void main() {
  late UserService mockUserService;
  late UserDao mockUserDao;
  late UserRepository userRepository;

  setUp(() {
    mockUserService = MockUserService();
    mockUserDao = MockUserDao();
    userRepository = UserRepositoryImpl(mockUserDao, mockUserService);
  });

  test("Insert user success", () {
    var expectedUser = createUser();
    when(mockUserDao.insert(expectedUser)).thenReturn(() {});
    userRepository.insert(expectedUser);
    verify(mockUserDao.insert(expectedUser));
  });

  test("Insert user error should throw error", () {
    var expectedUser = createUser();
    var expectedError = ObjectBoxException("Wrong data");
    when(mockUserDao.insert(expectedUser)).thenThrow(expectedError);
    verifyNever(mockUserDao.insert(expectedUser));
    expect(
      () => userRepository.insert(expectedUser),
      throwsA(const TypeMatcher<ObjectBoxException>()),
    );
  });

  test("Read user success", () {
    var expectedUser = createUser();
    when(mockUserDao.read()).thenReturn(expectedUser);
    var user = userRepository.read();
    expect(user, expectedUser);
  });

  test("Read user error should throw error", () {
    var expectedError = ObjectBoxException("Data not found");
    when(mockUserDao.read()).thenThrow(expectedError);
    verifyNever(mockUserDao.read());
    expect(
      () => userRepository.read(),
      throwsA(const TypeMatcher<ObjectBoxException>()),
    );
  });

  test("Is logged in should return boolean when success", () {
    var expectedLoggedIn = randomBetween(0, 1) == 1;
    when(mockUserDao.isLoggedIn()).thenReturn(expectedLoggedIn);
    var user = userRepository.isLoggedIn();
    expect(user, expectedLoggedIn);
  });

  test("Clear should delete all data in object box", () {
    when(mockUserDao.clear()).thenReturn(() {});
    userRepository.clear();
    verify(mockUserDao.clear());
  });

  test("Get token success", () {
    var expectedToken = createUser().token;
    when(mockUserDao.getToken()).thenReturn(expectedToken);
    var token = userRepository.getToken();
    verify(mockUserDao.getToken());
    expect(token, expectedToken);
  });

  test("Get token null should return empty string", () {
    when(mockUserDao.getToken()).thenReturn("");
    var token = userRepository.getToken();
    verify(mockUserDao.getToken());
    expect(token, "");
  });

  test("Get token should throw error if an error happen", () {
    var expectedError = ObjectBoxException("Wrong data");
    when(mockUserDao.getToken()).thenThrow(expectedError);
    verifyNever(mockUserDao.getToken());
    expect(() => userRepository.getToken(),
        throwsA(const TypeMatcher<ObjectBoxException>()));
  });

  test("Login success", () async {
    LoginRequest request = createLoginRequest();
    LoginResponse expectedLoginResponse = LoginResponse(createUser());
    var expectedResponse = Response(
        http.Response(jsonEncode(expectedLoginResponse.toJson()), 200),
        expectedLoginResponse);
    when(mockUserService.login(request))
        .thenAnswer((_) => Future.value(expectedResponse));
    var response = await userRepository.login(request);
    verify(mockUserService.login(request));
    expect(response, expectedResponse);
  });

  test("Login failed should return response error", () async {
    LoginRequest request = createLoginRequest();
    ResponseError expectedResponseError = createResponseError();
    var expectedResponse = Response<LoginResponse>(
        http.Response(jsonEncode(expectedResponseError.toJson()), 401), null,
        error: expectedResponseError);
    when(mockUserService.login(request))
        .thenAnswer((_) => Future.value(expectedResponse));
    verifyNever(mockUserService.login(request));
    var response = await userRepository.login(request);
    expect(response, expectedResponse);
    expect(response.error, expectedResponse.error);
  });

  test("Login error should throw an error", () {
    LoginRequest request = createLoginRequest();
    HttpException expectedError = const HttpException("Invalid url");
    when(mockUserService.login(request)).thenThrow(expectedError);
    verifyNever(mockUserService.login(request));
    expect(() => userRepository.login(request),
        throwsA(const TypeMatcher<HttpException>()));
  });

  test("Register success", () async {
    RegisterRequest request = createRegisterRequest();
    RegisterResponse expectedRegisterResponse =
        RegisterResponse(createUser(), createMessage());
    var expectedResponse = Response(
        http.Response(jsonEncode(expectedRegisterResponse.toJson()), 200),
        expectedRegisterResponse);
    when(mockUserService.register(request))
        .thenAnswer((_) => Future.value(expectedResponse));
    var response = await userRepository.register(request);
    verify(mockUserService.register(request));
    expect(response, expectedResponse);
  });

  test("Register failed should return response error", () async {
    RegisterRequest request = createRegisterRequest();
    ResponseError expectedResponseError = createResponseError();
    var expectedResponse = Response<RegisterResponse>(
        http.Response(jsonEncode(expectedResponseError.toJson()), 401), null,
        error: expectedResponseError);
    when(mockUserService.register(request))
        .thenAnswer((_) => Future.value(expectedResponse));
    verifyNever(mockUserService.register(request));
    var response = await userRepository.register(request);
    expect(response, expectedResponse);
    expect(response.error, expectedResponse.error);
  });

  test("Register error should throw an error", () {
    RegisterRequest request = createRegisterRequest();
    HttpException expectedError = const HttpException("Invalid url");
    when(mockUserService.register(request)).thenThrow(expectedError);
    verifyNever(mockUserService.register(request));
    expect(() => userRepository.register(request),
        throwsA(const TypeMatcher<HttpException>()));
  });
}
