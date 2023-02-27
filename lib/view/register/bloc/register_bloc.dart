import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/domain/post_register.dart';
import 'package:vita_client_app/util/extension/either_extension.dart';
import 'package:vita_client_app/view/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState.initial()) {
    on<PostRegisterEvent>((event, emit) async {
      emit(const RegisterState.loading());
      await Task(() => di<PostRegister>().call(event.request))
          .attempt()
          .mapLeftToFailure()
          .run()
          .then((value) {
        value.fold((l) => emit(RegisterState.error(l.failure.toString())),
            (r) => emit(const RegisterState.success()));
      }).catchError((error) {
        if (error is ResponseError) {
          emit(RegisterState.error(error.message));
        } else {
          emit(RegisterState.error(error.toString()));
        }
      });
    });
  }
}
