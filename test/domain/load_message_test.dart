import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/domain/impl/load_message_impl.dart';
import 'package:vita_client_app/domain/load_message.dart';
import 'package:vita_client_app/repository/message_repository.dart';

import '../util/dummy_builder.dart';
import 'fetch_message_test.mocks.dart';

@GenerateMocks([MessageRepository])
void main() {
  late MessageRepository mockRepository;
  late LoadMessage loadMessage;

  setUp(() {
    mockRepository = MockMessageRepository();
    loadMessage = LoadMessageImpl(mockRepository);
  });

  group("Load message", () {
    List<Message> expectedMessages = createListMessage();

    test("Load message success", () async {
      when(mockRepository.read())
          .thenAnswer((_) => Future.value(expectedMessages));
      List<Message> messages = await loadMessage.call();
      verify(mockRepository.read());
      expect(messages, expectedMessages);
    });

    test("Load message error should throw an error", () {
      when(mockRepository.read()).thenThrow(ObjectBoxException("Wrong data"));
      verifyNever(mockRepository.read());
      expect(() => loadMessage.call(),
          throwsA(const TypeMatcher<ObjectBoxException>()));
    });
  });
}
