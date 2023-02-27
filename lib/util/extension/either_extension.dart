import 'package:dartz/dartz.dart';

extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Fail, U>> mapLeftToFailure() {
    return map(
      (either) => either.leftMap((obj) {
        try {
          return obj as Fail;
        } catch (e) {
          throw obj;
        }
      }),
    );
  }
}
