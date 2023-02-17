import 'package:vita_client_app/data/model/entity/image_possibility.dart';

abstract class LoadPossibility {
  Future<List<ImagePossibility>> call();
}
