import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectbox/objectbox.dart';
import 'package:random_string/random_string.dart';
import 'package:vita_client_app/domain/check_login.dart';
import 'package:vita_client_app/domain/impl/check_login_impl.dart';
import 'package:vita_client_app/repository/user_repository.dart';

import 'check_login_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late UserRepository mockUserRepository;
  late CheckLogin checkLogin;

  setUp(() {
    mockUserRepository = MockUserRepository();
    checkLogin = CheckLoginImpl(mockUserRepository);
  });

  group("Check login", () {
    bool expectedLoginStatus = randomBetween(0, 1) == 1;

    test("Check login success should return boolean", () {
      when(mockUserRepository.isLoggedIn()).thenReturn(expectedLoginStatus);
      bool isLoggedIn = checkLogin.call();
      verify(mockUserRepository.isLoggedIn());
      expect(isLoggedIn, expectedLoginStatus);
    });

    test("Check login error should throw error", () {
      var expectedException = ObjectBoxException("Wrong data");
      when(mockUserRepository.isLoggedIn()).thenThrow(expectedException);
      verifyNever(mockUserRepository.isLoggedIn());
      expect(() => checkLogin.call(),
          throwsA(const TypeMatcher<ObjectBoxException>()));
    });
  });
}
