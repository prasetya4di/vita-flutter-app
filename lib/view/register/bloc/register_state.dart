import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';

part 'register_state.freezed.dart';

@freezed
abstract class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.onRegister(RegisterRequest request) =
      PostRegisterEvent;
}

@freezed
abstract class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = RegisterInitialState;

  const factory RegisterState.loading() = RegisterLoadingState;

  const factory RegisterState.error(String message) = RegisterErrorState;

  const factory RegisterState.success() = RegisterSuccessState;
}
