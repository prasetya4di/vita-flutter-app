import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectbox/objectbox.dart';
import 'package:random_string/random_string.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/data/model/response/scanned_image.dart';
import 'package:vita_client_app/data/source/local/image_dao.dart';
import 'package:vita_client_app/data/source/network/image_service.dart';
import 'package:vita_client_app/repository/image_repository.dart';
import 'package:vita_client_app/repository/impl/image_repository_impl.dart';

import '../util/dummy_builder.dart';
import 'image_repository_test.mocks.dart';

@GenerateMocks([ImageDao, ImageService])
void main() {
  late ImageDao mockImageDao;
  late ImageService mockImageService;
  late ImageRepository imageRepository;

  setUp(() {
    mockImageDao = MockImageDao();
    mockImageService = MockImageService();
    imageRepository = ImageRepositoryImpl(mockImageDao, mockImageService);
  });

  group("Pick image", () {
    XFile expectedFile = createXFile();
    ImageSource expectedImageSource = createImageSource();

    test("Pick image success", () async {
      when(mockImageDao.pickImage(expectedImageSource))
          .thenAnswer((_) => Future.value(expectedFile));
      XFile? pickedFile = await imageRepository.pickImage(expectedImageSource);
      expect(pickedFile, expectedFile);
    });

    test("Pick image success with null data", () async {
      when(mockImageDao.pickImage(expectedImageSource))
          .thenAnswer((_) => Future.value(null));
      XFile? pickedFile = await imageRepository.pickImage(expectedImageSource);
      expect(pickedFile, null);
    });

    test("Pick image error", () {
      var expectedException = const FileSystemException();
      when(mockImageDao.pickImage(expectedImageSource))
          .thenThrow(expectedException);
      verifyNever(mockImageDao.pickImage(expectedImageSource));
      expect(() => imageRepository.pickImage(expectedImageSource),
          throwsA(const TypeMatcher<FileSystemException>()));
    });
  });

  group("Scan image", () {
    XFile expectedFile = createXFile();

    test("Scan image success", () async {
      ScannedImage scannedImage = createScannedImageResponse();
      var expectedResponse = Response(
          http.Response(jsonEncode(scannedImage.toJson()), 200), scannedImage);
      when(mockImageService.scanImage(expectedFile.path))
          .thenAnswer((_) => Future.value(expectedResponse));
      var response = await imageRepository.scanImage(expectedFile);
      verify(mockImageService.scanImage(expectedFile.path));
      expect(response, expectedResponse);
    });

    test("Scan image failed should return response error", () async {
      ResponseError expectedResponseError = ResponseError(randomString(5));
      var expectedResponse = Response<ScannedImage>(
          http.Response(jsonEncode(expectedResponseError.toJson()), 401), null,
          error: expectedResponseError);
      when(mockImageService.scanImage(expectedFile.path))
          .thenAnswer((_) => Future.value(expectedResponse));
      verifyNever(mockImageService.scanImage(expectedFile.path));
      var response = await imageRepository.scanImage(expectedFile);
      expect(response, expectedResponse);
      expect(response.error, expectedResponse.error);
    });

    test("Scan image error should throw an error", () {
      HttpException expectedError = const HttpException("Invalid url");
      when(mockImageService.scanImage(expectedFile.path))
          .thenThrow(expectedError);
      verifyNever(mockImageService.scanImage(expectedFile.path));
      expect(() => imageRepository.scanImage(expectedFile),
          throwsA(const TypeMatcher<HttpException>()));
    });
  });

  group("Insert possibilities", () {
    List<ImagePossibility> expectedPossibilities = createPossibilities();

    test("Insert possibilities success", () {
      when(mockImageDao.inserts(expectedPossibilities)).thenReturn(() {});
      imageRepository.inserts(expectedPossibilities);
      verify(mockImageDao.inserts(expectedPossibilities));
    });

    test("Insert possibilities error", () {
      var expectedException = ObjectBoxException("Data error");
      when(mockImageDao.inserts(expectedPossibilities))
          .thenThrow(expectedException);
      expect(() => imageRepository.inserts(expectedPossibilities),
          throwsA(const TypeMatcher<ObjectBoxException>()));
    });
  });

  group("Read possibilities", () {
    List<ImagePossibility> expectedPossibilities = createPossibilities();

    test("Read possibilities success", () async {
      when(mockImageDao.get())
          .thenAnswer((_) => Future.value(expectedPossibilities));
      var possibilities = await imageRepository.read();
      verify(mockImageDao.get());
      expect(possibilities, expectedPossibilities);
    });

    test("Read possibilities success with empty data", () async {
      when(mockImageDao.get()).thenAnswer((_) => Future.value([]));
      var possibilities = await imageRepository.read();
      verify(mockImageDao.get());
      expect(possibilities, []);
    });

    test("Read possibilities error should throw an error", () {
      var expectedException = ObjectBoxException("Data error");
      when(mockImageDao.get()).thenThrow(expectedException);
      expect(() => imageRepository.read(),
          throwsA(const TypeMatcher<ObjectBoxException>()));
    });
  });

  group("Clear possibilities", () {
    test("Insert possibilities success", () {
      when(mockImageDao.delete()).thenAnswer((_) => Future.value());
      imageRepository.clear();
      verify(mockImageDao.delete());
    });

    test("Insert possibilities error", () {
      var expectedException = ObjectBoxException("Data error");
      when(mockImageDao.delete()).thenThrow(expectedException);
      expect(() => imageRepository.clear(),
          throwsA(const TypeMatcher<ObjectBoxException>()));
    });
  });
}
