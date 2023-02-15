import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
abstract class SplashEvent with _$SplashEvent {
  const factory SplashEvent.onGetMessage() = GetMessageEvent;
}

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState.initial() = SplashInitialState;

  const factory SplashState.loading() = SplashLoadingState;

  const factory SplashState.error(String message) = SplashErrorState;

  const factory SplashState.loadedState() = SplashLoadedState;
}
