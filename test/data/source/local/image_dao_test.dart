import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectbox/objectbox.dart';
import 'package:random_string/random_string.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/source/local/image_dao.dart';
import 'package:vita_client_app/data/source/local/impl/image_dao_impl.dart';

import 'image_dao_test.mocks.dart';
import 'objectbox_test.dart';

@GenerateMocks([ImagePicker])
void main() {
  late ImagePicker mockImagePicker;
  late ObjectBoxTest objectBoxTest;
  late Box<ImagePossibility> possibilityBox;
  late ImageDao imageDao;

  setUp(() async {
    objectBoxTest = await ObjectBoxTest.create();
    possibilityBox = objectBoxTest.store.box<ImagePossibility>();
    mockImagePicker = MockImagePicker();
    imageDao = ImageDaoImpl(mockImagePicker, possibilityBox);
  });

  tearDown(() async {
    imageDao.delete();
    await objectBoxTest.delete();
  });

  ImagePossibility createImagePossiblity() =>
      ImagePossibility(randomString(5), randomString(5));

  test("Pick image success", () async {
    XFile expectedFile = XFile(randomString(5), name: randomString(5));
    ImageSource expectedImageSource = ImageSource.values[randomBetween(0, 1)];
    when(mockImagePicker.pickImage(
            source: expectedImageSource, maxWidth: 1800, maxHeight: 1800))
        .thenAnswer((_) => Future.value(expectedFile));
    XFile? pickedFile = await imageDao.pickImage(expectedImageSource);
    expect(pickedFile?.path, expectedFile.path);
    expect(pickedFile?.name, expectedFile.name);
  });

  test("Pick image canceled should return null", () async {
    ImageSource expectedImageSource = ImageSource.values[randomBetween(0, 1)];
    when(mockImagePicker.pickImage(
            source: expectedImageSource, maxWidth: 1800, maxHeight: 1800))
        .thenAnswer((_) => Future.value(null));
    XFile? pickedFile = await imageDao.pickImage(expectedImageSource);
    expect(pickedFile?.path, null);
  });

  test("Insert success", () async {
    var expectedPossibilities = [
      createImagePossiblity(),
      createImagePossiblity(),
      createImagePossiblity()
    ];
    imageDao.inserts(expectedPossibilities);
    List<ImagePossibility> possibilities = await imageDao.get();
    expect(possibilities, expectedPossibilities);
  });

  test("Get all possibility success", () async {
    var expectedPossibilities = [
      createImagePossiblity(),
      createImagePossiblity(),
      createImagePossiblity()
    ];
    imageDao.inserts(expectedPossibilities);
    List<ImagePossibility> possibilities = await imageDao.get();
    expect(possibilities, expectedPossibilities);
  });

  test("Get all possibility empty should return empty list", () async {
    List<ImagePossibility> possibilities = await imageDao.get();
    expect(possibilities, []);
  });

  test("Delete success", () async {
    var expectedPossibilities = [
      createImagePossiblity(),
      createImagePossiblity(),
      createImagePossiblity()
    ];
    imageDao.inserts(expectedPossibilities);
    List<ImagePossibility> possibilities = await imageDao.get();
    expect(possibilities, expectedPossibilities);
    imageDao.delete();
    possibilities = await imageDao.get();
    expect(possibilities, []);
  });
}
