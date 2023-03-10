import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/domain/get_user.dart';
import 'package:vita_client_app/domain/logout.dart';
import 'package:vita_client_app/view/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUser _getUser;
  final Logout _logout;

  User? user;

  ProfileBloc(this._getUser, this._logout)
      : super(const ProfileState.initial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(const ProfileState.loading());
      user = _getUser.call();
      emit(const ProfileState.success());
    });

    on<LogoutEvent>((event, emit) async {
      emit(const ProfileState.loading());
      _logout.call();
      emit(const ProfileState.logout());
    });
  }
}
