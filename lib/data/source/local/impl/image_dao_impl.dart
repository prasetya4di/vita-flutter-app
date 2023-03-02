import 'package:image_picker/image_picker.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/source/local/image_dao.dart';

class ImageDaoImpl implements ImageDao {
  final ImagePicker _imgPicker;
  final Box<ImagePossibility> _box;

  ImageDaoImpl(this._imgPicker, this._box);

  @override
  Future<XFile?> pickImage(ImageSource source) async {
    XFile? pickedFile = await _imgPicker.pickImage(
      source: source,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    return pickedFile;
  }

  @override
  delete() {
    _box.removeAll();
  }

  @override
  Future<List<ImagePossibility>> get() async {
    return _box.getAll();
  }

  @override
  inserts(List<ImagePossibility> possibilities) {
    _box.putMany(possibilities);
  }
}
