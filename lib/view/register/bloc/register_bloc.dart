import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/domain/post_register.dart';
import 'package:vita_client_app/view/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState.initial()) {
    on<PostRegisterEvent>((event, emit) async {
      emit(const RegisterState.loading());
      var registerResult = await di<PostRegister>().call(event.request);
      registerResult.fold(
          (failure) => emit(RegisterState.error(failure.message)),
          (data) => emit(const RegisterState.success()));
    });
  }
}
