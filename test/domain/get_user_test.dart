import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectbox/objectbox.dart';
import 'package:random_string/random_string.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/domain/get_user.dart';
import 'package:vita_client_app/domain/impl/get_user_impl.dart';
import 'package:vita_client_app/repository/user_repository.dart';

import '../util/dummy_builder.dart';
import 'check_login_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late UserRepository mockRepository;
  late GetUser getUser;

  setUp(() {
    mockRepository = MockUserRepository();
    getUser = GetUserImpl(mockRepository);
  });

  group("Test get user", () {
    User expectedUser = createUser();

    test("Get user success", () {
      when(mockRepository.read()).thenReturn(expectedUser);
      User user = getUser.call();
      verify(mockRepository.read());
      expect(user, expectedUser);
    });

    test("Get user error should throw an error", () {
      when(mockRepository.read())
          .thenThrow(ObjectBoxException(randomString(5)));
      verifyNever(mockRepository.read());
      expect(() => getUser.call(),
          throwsA(const TypeMatcher<ObjectBoxException>()));
    });
  });
}
