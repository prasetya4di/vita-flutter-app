import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
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

    test("Scan image success", () {
      Response<ScannedImage> expectedResponse = Response(
          http.Response(
              jsonEncode(expectedScannedImage.toJson()), HttpStatus.created),
          expectedScannedImage);
    });
  });
}
