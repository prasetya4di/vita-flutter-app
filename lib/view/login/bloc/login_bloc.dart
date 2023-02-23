import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/domain/post_login.dart';
import 'package:vita_client_app/view/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState.initial()) {
    on<PostLoginEvent>((event, emit) async {
      emit(const LoginState.loading());
      var loginResult = await di<PostLogin>().call(event.request);
      loginResult.fold((failure) {
        if (failure.statusCode == HttpStatus.unauthorized) {
          emit(const LoginState.error("Invalid email or password"));
        } else {
          emit(LoginState.error(failure.body["message"]));
        }
      }, (data) => emit(const LoginState.success()));
    });
  }
}
