import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/domain/get_token.dart';
import 'package:vita_client_app/domain/impl/get_token_impl.dart';
import 'package:vita_client_app/repository/user_repository.dart';

import '../util/dummy_builder.dart';
import 'check_login_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late UserRepository mockRepository;
  late GetToken getToken;

  setUp(() {
    mockRepository = MockUserRepository();
    getToken = GetTokenImpl(mockRepository);
  });

  group("Get token", () {
    User expectedUser = createUser();
    String expectedToken = expectedUser.token;

    test("Get token success", () {
      when(mockRepository.getToken()).thenReturn(expectedToken);
      String token = getToken.call();
      verify(mockRepository.getToken());
      expect(token, expectedToken);
    });

    test("Get token success with empty string", () {
      when(mockRepository.getToken()).thenReturn("");
      String token = getToken.call();
      verify(mockRepository.getToken());
      expect(token, "");
    });
  });
}
