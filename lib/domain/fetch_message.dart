import 'dart:async';

abstract class FetchMessage {
  Future<void> call();
}
