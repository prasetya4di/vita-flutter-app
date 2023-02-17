import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/domain/load_possibility.dart';
import 'package:vita_client_app/repository/image_repository.dart';

class LoadPossibilityImpl implements LoadPossibility {
  final ImageRepository _repository;

  LoadPossibilityImpl(this._repository);

  @override
  Future<List<ImagePossibility>> call() {
    return _repository.read();
  }
}
