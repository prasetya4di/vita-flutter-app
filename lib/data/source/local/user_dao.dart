import 'package:vita_client_app/data/model/entity/user.dart';

abstract class UserDao {
  insert(User user);

  User read();

  String getToken();

  bool isLoggedIn();

  clear();
}
