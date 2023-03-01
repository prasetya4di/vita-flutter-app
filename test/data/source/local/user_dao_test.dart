import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:random_string/random_string.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/source/local/impl/user_dao_impl.dart';
import 'package:vita_client_app/data/source/local/user_dao.dart';
import 'package:vita_client_app/objectbox.g.dart';

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

  User createUser() => User(
      randomString(5),
      randomString(5),
      randomString(5),
      randomString(5),
      DateTime(2000, randomBetween(1, 12), randomBetween(1, 30)),
      randomString(5));

  test("Insert user success", () {
    User expectedUser = createUser();
    userDao.insert(expectedUser);
    var user = userDao.read();
    expect(user, expectedUser);
  });

  test("Read user success", () {
    User expectedUser = createUser();
    userDao.insert(expectedUser);
    var user = userDao.read();
    expect(user, expectedUser);
  });

  test("Get token success", () {
    User expectedUser = createUser();
    userDao.insert(expectedUser);
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
    userDao.insert(expectedUser);
    var isLoggedIn = userDao.isLoggedIn();
    expect(isLoggedIn, true);
  });

  test("Check user logged in true", () {
    User expectedUser = createUser();
    userDao.insert(expectedUser);
    var isLoggedIn = userDao.isLoggedIn();
    expect(isLoggedIn, true);
  });

  test("Check user logged in false", () {
    var isLoggedIn = userDao.isLoggedIn();
    expect(isLoggedIn, false);
  });

  test("Clear all user success", () {
    User expectedUser = createUser();
    userDao.insert(expectedUser);
    var isLoggedIn = userDao.isLoggedIn();
    expect(isLoggedIn, true);
    userDao.clear();
    isLoggedIn = userDao.isLoggedIn();
    expect(isLoggedIn, false);
  });
}
