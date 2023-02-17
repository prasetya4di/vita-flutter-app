import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/data/source/local/image_dao.dart';

class ImageDaoImpl implements ImageDao {
  final ImagePicker _imgPicker;

  ImageDaoImpl(this._imgPicker);

  @override
  Future<XFile?> pickImage(ImageSource source) async {
    XFile? pickedFile = await _imgPicker.pickImage(
      source: source,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    return pickedFile;
  }
}
