import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';

part 'login_state.freezed.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.onLogin(LoginRequest request) = PostLoginEvent;

  const factory LoginEvent.onFetchMessage() = FetchMessageEvent;
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitialState;

  const factory LoginState.loading() = LoginLoadingState;

  const factory LoginState.error(String message) = LoginErrorState;

  const factory LoginState.success() = LoginSuccessState;

  const factory LoginState.fetchMessageLoading() =
      LoginFetchMessageLoadingState;

  const factory LoginState.fetchMessageSuccess() =
      LoginFetchMessageSuccessState;

  const factory LoginState.fetchMessageError(String message) =
      LoginFetchMessageErrorState;
}
