import 'package:chopper/chopper.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';
import 'package:vita_client_app/data/model/response/login_response.dart';
import 'package:vita_client_app/data/model/response/register_response.dart';
import 'package:vita_client_app/data/source/local/user_dao.dart';
import 'package:vita_client_app/data/source/network/user_service.dart';
import 'package:vita_client_app/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDao _userDao;
  final UserService _userService;

  UserRepositoryImpl(this._userDao, this._userService);

  @override
  String getToken() {
    return _userDao.getToken();
  }

  @override
  insert(User user) {
    _userDao.insert(user);
  }

  @override
  Future<Response<LoginResponse>> login(LoginRequest request) async {
    return _userService.login(request);
  }

  @override
  User read() {
    return _userDao.read();
  }

  @override
  Future<Response<RegisterResponse>> register(RegisterRequest request) async {
    return _userService.register(request);
  }

  @override
  bool isLoggedIn() {
    return _userDao.isLoggedIn();
  }

  @override
  clear() {
    _userDao.clear();
  }
}
