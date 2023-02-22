import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/domain/check_login.dart';
import 'package:vita_client_app/domain/fetch_message.dart';
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
      var getMessage = await di<FetchMessage>().call();
      getMessage.fold((failure) => emit(SplashState.error(failure.toString())),
          (data) => emit(const SplashState.loadedState()));
    });
  }
}
