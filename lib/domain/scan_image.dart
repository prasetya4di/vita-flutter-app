import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';

abstract class ScanImage {
  Future<Either<Error, List<ImagePossibility>>> invoke(XFile image);
}
