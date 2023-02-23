import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:vita_client_app/domain/check_connection.dart';

class CheckConnectionImpl implements CheckConnection {
  final InternetConnectionChecker connectionChecker;

  CheckConnectionImpl(this.connectionChecker);

  @override
  Future<bool> call() {
    return connectionChecker.hasConnection;
  }
}
