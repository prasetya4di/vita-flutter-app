import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/domain/get_user.dart';
import 'package:vita_client_app/view/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  User? user;

  ProfileBloc() : super(const ProfileState.initial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(const ProfileState.loading());
      user = di<GetUser>().call();
      emit(const ProfileState.success());
    });
  }
}
