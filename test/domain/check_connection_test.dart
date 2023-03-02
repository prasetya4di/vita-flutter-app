import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:random_string/random_string.dart';
import 'package:vita_client_app/domain/check_connection.dart';
import 'package:vita_client_app/domain/impl/check_connection_impl.dart';

import 'check_connection_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late InternetConnectionChecker mock;
  late CheckConnection checkConnection;

  setUp(() {
    mock = MockInternetConnectionChecker();
    checkConnection = CheckConnectionImpl(mock);
  });

  test("Check connection should return boolean", () async {
    bool expectedConnectionStatus = randomBetween(0, 1) == 1;
    when(mock.hasConnection)
        .thenAnswer((_) => Future.value(expectedConnectionStatus));
    bool connectionStatus = await checkConnection.call();
    verify(mock.hasConnection);
    expect(connectionStatus, expectedConnectionStatus);
  });
}
