import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/source/local/impl/message_dao_impl.dart';
import 'package:vita_client_app/data/source/local/message_dao.dart';

import '../../../util/dummy_builder.dart';
import 'objectbox_test.dart';

void main() {
  late ObjectBoxTest objectBoxTest;
  late Box<Message> messageBox;
  late MessageDao messageDao;

  setUp(() async {
    objectBoxTest = await ObjectBoxTest.create();
    messageBox = objectBoxTest.store.box<Message>();
    messageDao = MessageDaoImpl(messageBox);
  });

  tearDown(() async {
    messageBox.removeAll();
    await objectBoxTest.delete();
  });

  test("Insert messages sucess", () async {
    List<Message> expectedMessages = createListMessage();
    messageDao.inserts(expectedMessages);
    List<Message> messages = messageBox.getAll();
    expect(messages.length, expectedMessages.length);
    expect(messages, expectedMessages);
  });

  test("Get messages success", () async {
    List<Message> expectedMessages = createListMessage();
    messageBox.putMany(expectedMessages);
    List<Message> messages = await messageDao.get();
    expect(messages.length, expectedMessages.length);
    expect(messages, expectedMessages.reversed);
  });

  test("Get messages empty should return empty list", () async {
    List<Message> messages = await messageDao.get();
    expect(messages.length, 0);
    expect(messages, []);
  });

  test("Delete messages success", () async {
    List<Message> expectedMessages = createListMessage();
    messageBox.putMany(expectedMessages);
    List<Message> messages = messageBox.getAll();
    expect(messages.length, expectedMessages.length);
    expect(messages, expectedMessages);
    messageDao.delete();
    messages = messageBox.getAll();
    expect(messages.length, 0);
    expect(messages, []);
  });
}
