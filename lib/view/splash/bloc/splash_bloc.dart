import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/domain/check_login.dart';
import 'package:vita_client_app/domain/fetch_message.dart';
import 'package:vita_client_app/util/extension/either_extension.dart';
import 'package:vita_client_app/view/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckLogin _checkLogin;
  final FetchMessage _fetchMessage;

  SplashBloc(this._checkLogin, this._fetchMessage)
      : super(const SplashInitialState()) {
    on<SplashEvent>((event, emit) async {
      await event.when(onGetMessage: () {
        emit(const SplashState.loading());
        var isLoggedIn = _checkLogin.call();
        emit(SplashState.checkLoginState(isLoggedIn));
      }, onCheckLogin: () async {
        emit(const SplashState.loading());
        await Task(() => _fetchMessage.call())
            .attempt()
            .mapLeftToFailure()
            .run()
            .then((value) => value.fold(
                (l) => emit(SplashState.error(l.failure.toString())),
                (r) => emit(const SplashState.loadedState())))
            .catchError((error) => emit(SplashState.error(error.toString())));
      });
    });
  }
}
