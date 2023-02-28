import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/domain/check_login.dart';
import 'package:vita_client_app/domain/fetch_message.dart';
import 'package:vita_client_app/util/extension/either_extension.dart';
import 'package:vita_client_app/view/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitialState()) {
    on<CheckLoginEvent>((event, emit) async {
      emit(const SplashState.loading());
      var isLoggedIn = di<CheckLogin>().call();
      emit(SplashState.checkLoginState(isLoggedIn));
    });

    on<GetMessageEvent>((event, emit) async {
      emit(const SplashState.loading());
      await Task(() => di<FetchMessage>().call())
          .attempt()
          .mapLeftToFailure()
          .run()
          .then((value) => value.fold(
              (l) => emit(SplashState.error(l.failure.toString())),
              (r) => emit(const SplashState.loadedState())))
          .catchError((error) => emit(SplashState.error(error.toString())));
    });
  }
}
