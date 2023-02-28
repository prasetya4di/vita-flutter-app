import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/data/model/response/scanned_image.dart';

abstract class ScanImage {
  Future<ScannedImage> call(XFile image);
}
