import 'package:chopper/chopper.dart';
import 'package:either_dart/either.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/domain/post_login.dart';
import 'package:vita_client_app/repository/user_repository.dart';

class PostLoginImpl implements PostLogin {
  final UserRepository _repository;

  PostLoginImpl(this._repository);

  @override
  Future<Either<ResponseError, User>> call(LoginRequest request) async {
    Response response = await _repository.login(request);
    if (response.isSuccessful && response.body != null) {
      var data = response.body!;
      await _repository.clear();
      _repository.insert(data.user);
      return Right(data.user);
    } else {
      return Left(response.error as ResponseError);
    }
  }
}
