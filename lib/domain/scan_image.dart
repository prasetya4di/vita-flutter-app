import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/data/model/response/scanned_image.dart';

abstract class ScanImage {
  Future<Either<ResponseError, ScannedImage>> call(XFile image);
}
