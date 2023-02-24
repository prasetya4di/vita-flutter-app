import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/domain/fetch_message.dart';
import 'package:vita_client_app/domain/post_login.dart';
import 'package:vita_client_app/view/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState.initial()) {
    on<PostLoginEvent>((event, emit) async {
      emit(const LoginState.loading());
      var loginResult = await di<PostLogin>().call(event.request);
      await loginResult.fold((failure) {
        emit(LoginState.error(failure.message));
      }, (data) async {
        await di<FetchMessage>()
            .call()
            .whenComplete(() => emit(const LoginState.success()));
      });
    });
  }
}
