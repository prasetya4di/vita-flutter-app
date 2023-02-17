import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/domain/scan_image.dart';
import 'package:vita_client_app/repository/image_repository.dart';

class ScanImageImpl implements ScanImage {
  final ImageRepository _repository;

  ScanImageImpl(this._repository);

  @override
  Future<Either<Error, List<ImagePossibility>>> call(XFile image) async {
    var response = await _repository.scanImage(image);
    if (response.isSuccessful && response.body != null) {
      var possibilities = response.body!;
      await _repository.clear();
      _repository.inserts(possibilities);
      return Right(possibilities);
    } else {
      return Left(response.error! as Error);
    }
  }
}
