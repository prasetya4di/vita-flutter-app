import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginEvent with _$LoginEvent {
  const factory LoginEvent.onLogin(LoginRequest request) = PostLoginEvent;
}

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitialState;

  const factory LoginState.loading() = LoginLoadingState;

  const factory LoginState.error(String message) = LoginErrorState;

  const factory LoginState.success() = LoginSuccessState;
}
