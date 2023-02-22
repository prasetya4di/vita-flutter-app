import 'package:objectbox/objectbox.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/source/local/user_dao.dart';

class UserDaoImpl implements UserDao {
  final Box<User> _box;

  UserDaoImpl(this._box);

  @override
  String getToken() {
    return _box.getAll().first.token;
  }

  @override
  insert(User user) {
    _box.put(user);
  }

  @override
  User read() {
    return _box.getAll().first;
  }

  @override
  bool isLoggedIn() {
    return !_box.isEmpty();
  }
}
