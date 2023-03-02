import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/domain/impl/load_possibility_impl.dart';
import 'package:vita_client_app/domain/load_possibility.dart';
import 'package:vita_client_app/repository/image_repository.dart';

import '../util/dummy_builder.dart';
import 'load_possibility_test.mocks.dart';

@GenerateMocks([ImageRepository])
void main() {
  late ImageRepository mockRepository;
  late LoadPossibility loadPossibility;

  setUp(() {
    mockRepository = MockImageRepository();
    loadPossibility = LoadPossibilityImpl(mockRepository);
  });

  group("Load possibility", () {
    List<ImagePossibility> expectedPossibilities = createPossibilities();

    test("Load possibility success", () async {
      when(mockRepository.read())
          .thenAnswer((_) => Future.value(expectedPossibilities));
      List<ImagePossibility> messages = await loadPossibility.call();
      verify(mockRepository.read());
      expect(messages, expectedPossibilities);
    });

    test("Load possibility error should throw an error", () {
      when(mockRepository.read()).thenThrow(ObjectBoxException("Wrong data"));
      verifyNever(mockRepository.read());
      expect(() => loadPossibility.call(),
          throwsA(const TypeMatcher<ObjectBoxException>()));
    });
  });
}
