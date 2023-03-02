import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vita_client_app/domain/impl/logout_impl.dart';
import 'package:vita_client_app/domain/logout.dart';
import 'package:vita_client_app/repository/image_repository.dart';
import 'package:vita_client_app/repository/message_repository.dart';
import 'package:vita_client_app/repository/user_repository.dart';

import 'logout_test.mocks.dart';

@GenerateMocks([UserRepository, MessageRepository, ImageRepository])
void main() {
  late UserRepository mockUserRepository;
  late MessageRepository mockMessageRepository;
  late ImageRepository mockImageRepository;
  late Logout logout;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockMessageRepository = MockMessageRepository();
    mockImageRepository = MockImageRepository();
    logout = LogoutImpl(
        mockUserRepository, mockMessageRepository, mockImageRepository);
  });

  test("Logout success", () {
    when(mockUserRepository.clear()).thenReturn(() {});
    when(mockMessageRepository.clear()).thenReturn(() {});
    when(mockImageRepository.clear()).thenReturn(() {});
    logout.call();
    verify(mockUserRepository.clear());
    verify(mockMessageRepository.clear());
    verify(mockImageRepository.clear());
  });
}
