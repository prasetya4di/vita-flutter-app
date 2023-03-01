import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:vita_client_app/objectbox.g.dart';

class ObjectBoxTest {
  /// The Store of this app.
  late final Store store;

  ObjectBoxTest._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBoxTest> create() async {
    Store.debugLogs = true;
    var directory = File("test/data/source/local");
    final store =
        await openStore(directory: join(directory.path, "vita-obx-test"));
    return ObjectBoxTest._create(store);
  }

  delete() async {
    var file = File(store.directoryPath);
    store.close();
    await file.delete(recursive: true);
  }
}
