import 'package:hive/hive.dart';
import 'package:vita_client_app/data/model/entity/message.dart';

@HiveType(typeId: 2)
class Messages extends HiveObject {
  List<Message> data;

  Messages(this.data);
}
