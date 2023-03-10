import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vita_client_app/data/model/response/scanned_image.dart';
import 'package:vita_client_app/domain/impl/scan_image_impl.dart';
import 'package:vita_client_app/domain/scan_image.dart';
import 'package:vita_client_app/repository/image_repository.dart';
import 'package:vita_client_app/repository/message_repository.dart';

import '../util/dummy_builder.dart';
import 'scan_image_test.mocks.dart';

@GenerateMocks([ImageRepository, MessageRepository])
void main() {
  late ImageRepository mockImageRepository;
  late MessageRepository mockMessageRepository;
  late ScanImage scanImage;

  setUp(() {
    mockImageRepository = MockImageRepository();
    mockMessageRepository = MockMessageRepository();
    scanImage = ScanImageImpl(mockImageRepository, mockMessageRepository);
  });

  group("Scan image test", () {
    XFile expectedFile = createXFile();
    ScannedImage expectedScannedImage = createScannedImageResponse();

    test("Scan image success", () async {
      Response<ScannedImage> expectedResponse = Response(
          http.Response(
              jsonEncode(expectedScannedImage.toJson()), HttpStatus.created),
          expectedScannedImage);

      when(mockImageRepository.clear()).thenReturn(() {});
      when(mockImageRepository.inserts(expectedScannedImage.possibilities))
          .thenReturn(() {});
      when(mockImageRepository.scanImage(expectedFile))
          .thenAnswer((_) => Future.value(expectedResponse));
      when(mockMessageRepository.inserts(expectedScannedImage.messages))
          .thenReturn(() {});

      var response = await scanImage.call(expectedFile);

      verify(mockImageRepository.clear());
      verify(mockImageRepository.inserts(expectedScannedImage.possibilities));
      verify(mockImageRepository.scanImage(expectedFile));
      verify(mockMessageRepository.inserts(expectedScannedImage.messages));

      expect(response, expectedScannedImage);
    });

    test("Scan image error should throw an error", () {
      HttpException expectedError = const HttpException("Invalid url");
      when(mockImageRepository.scanImage(expectedFile))
          .thenThrow(expectedError);
      verifyNever(mockImageRepository.scanImage(expectedFile));
      expect(() => scanImage.call(expectedFile),
          throwsA(const TypeMatcher<HttpException>()));
    });
  });
}
