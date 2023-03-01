import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/source/local/impl/user_dao_impl.dart';
import 'package:vita_client_app/data/source/local/user_dao.dart';
import 'package:vita_client_app/objectbox.g.dart';

import '../../../util/dummy_builder.dart';
import 'objectbox_test.dart';

void main() {
  late ObjectBoxTest objectBoxTest;
  late Box<User> userBox;
  late UserDao userDao;

  setUp(() async {
    objectBoxTest = await ObjectBoxTest.create();
    userBox = objectBoxTest.store.box<User>();
    userDao = UserDaoImpl(userBox);
  });

  tearDown(() async {
    userBox.removeAll();
    await objectBoxTest.delete();
  });

  test("Insert user success", () {
    User expectedUser = createUser();
    userDao.insert(expectedUser);
    var user = userBox.getAll().first;
    expect(user, expectedUser);
  });

  test("Read user success", () {
    User expectedUser = createUser();
    userBox.put(expectedUser);
    var user = userDao.read();
    expect(user, expectedUser);
  });

  test("Get token success", () {
    User expectedUser = createUser();
    userBox.put(expectedUser);
    var user = userDao.getToken();
    expect(user, expectedUser.token);
  });

  test("Get token empty should return empty string", () {
    var expectedToken = "";
    var user = userDao.getToken();
    expect(user, expectedToken);
  });

  test("Check user logged in true", () {
    User expectedUser = createUser();
    userBox.put(expectedUser);
    var isLoggedIn = userDao.isLoggedIn();
    expect(isLoggedIn, true);
  });

  test("Check user logged in true", () {
    User expectedUser = createUser();
    userBox.put(expectedUser);
    var isLoggedIn = userDao.isLoggedIn();
    expect(isLoggedIn, true);
  });

  test("Check user logged in false", () {
    var isLoggedIn = userDao.isLoggedIn();
    expect(isLoggedIn, false);
  });

  test("Clear all user success", () {
    User expectedUser = createUser();
    userBox.put(expectedUser);
    var isLoggedIn = userBox.getAll().isNotEmpty;
    expect(isLoggedIn, true);
    userDao.clear();
    isLoggedIn = userBox.getAll().isNotEmpty;
    expect(isLoggedIn, false);
  });
}
