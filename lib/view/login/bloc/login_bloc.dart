import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/domain/fetch_message.dart';
import 'package:vita_client_app/domain/post_login.dart';
import 'package:vita_client_app/util/extension/either_extension.dart';
import 'package:vita_client_app/view/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostLogin _postLogin;
  final FetchMessage _fetchMessage;

  LoginBloc(this._postLogin, this._fetchMessage)
      : super(const LoginState.initial()) {
    on<LoginEvent>((event, emit) async {
      await event.when(
        onLogin: (request) async {
          emit(const LoginState.loading());
          await Task(
            () => _postLogin.call(request),
          ).run().then((value) {
            value.fold(
              (failure) => emit(LoginState.error(failure.message)),
              (success) => emit(const LoginState.success()),
            );
          }).catchError((error) {
            if (error is ResponseError) {
              emit(LoginState.error(error.message));
            } else {
              emit(LoginState.error(error.toString()));
            }
          });
        },
        onFetchMessage: () async {
          emit(const LoginState.fetchMessageLoading());
          await Task(
            () => _fetchMessage.call(),
          ).attempt().mapLeftToFailure().run().then((value) {
            value.fold(
              (l) => emit(LoginState.error(l.failure.toString())),
              (r) => emit(const LoginState.fetchMessageSuccess()),
            );
          }).catchError((error) {
            if (error is ResponseError) {
              emit(LoginState.error(error.message));
            } else {
              emit(LoginState.error(error.toString()));
            }
          });
        },
      );
    });
  }
}
