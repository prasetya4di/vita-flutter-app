import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.onGetProfile() = GetProfileEvent;

  const factory ProfileEvent.onLogout() = LogoutEvent;
}

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitialState;

  const factory ProfileState.loading() = ProfileLoadingState;

  const factory ProfileState.error(String message) = ProfileErrorState;

  const factory ProfileState.success() = ProfileSuccessState;

  const factory ProfileState.logout() = ProfileLogoutState;
}
