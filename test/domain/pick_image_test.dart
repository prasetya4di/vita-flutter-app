import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vita_client_app/domain/impl/pick_image_impl.dart';
import 'package:vita_client_app/domain/pick_image.dart';
import 'package:vita_client_app/repository/image_repository.dart';

import '../util/dummy_builder.dart';
import 'pick_image_test.mocks.dart';

@GenerateMocks([ImageRepository])
void main() {
  late ImageRepository mockImageRepository;
  late PickImage pickImage;

  setUp(() {
    mockImageRepository = MockImageRepository();
    pickImage = PickImageImpl(mockImageRepository);
  });

  group("Test pick image", () {
    ImageSource expectedImageSource = createImageSource();
    XFile expectedXFile = createXFile();

    test("Pick image success", () async {
      when(mockImageRepository.pickImage(expectedImageSource))
          .thenAnswer((_) => Future.value(expectedXFile));
      XFile? file = await pickImage.call(expectedImageSource);
      verify(mockImageRepository.pickImage(expectedImageSource));
      expect(file, expectedXFile);
    });

    test("Pick image canceled should return null xfile", () async {
      when(mockImageRepository.pickImage(expectedImageSource))
          .thenAnswer((_) => Future.value(null));
      XFile? file = await pickImage.call(expectedImageSource);
      verify(mockImageRepository.pickImage(expectedImageSource));
      expect(file, null);
    });

    test("Pick image error", () {
      var expectedException = const FileSystemException();
      when(mockImageRepository.pickImage(expectedImageSource))
          .thenThrow(expectedException);
      verifyNever(mockImageRepository.pickImage(expectedImageSource));
      expect(() => pickImage.call(expectedImageSource),
          throwsA(const TypeMatcher<FileSystemException>()));
    });
  });
}
