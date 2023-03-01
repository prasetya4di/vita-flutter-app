import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:random_string/random_string.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/source/local/impl/message_dao_impl.dart';
import 'package:vita_client_app/data/source/local/message_dao.dart';

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

  Message createMessage() => Message(
      randomBetween(0, 100),
      randomString(5),
      randomString(5),
      DateTime(2000, randomBetween(1, 12), randomBetween(1, 30)),
      randomString(5),
      randomString(5));

  List<Message> createListMessage() =>
      [createMessage(), createMessage(), createMessage()];

  test("Insert messages sucess", () async {
    List<Message> expectedMessages = createListMessage();
    messageDao.inserts(expectedMessages);
    List<Message> messages = await messageDao.get();
    expect(messages.length, expectedMessages.length);
    expect(messages, expectedMessages.reversed);
  });

  test("Get messages success", () async {
    List<Message> expectedMessages = createListMessage();
    messageDao.inserts(expectedMessages);
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
    messageDao.inserts(expectedMessages);
    List<Message> messages = await messageDao.get();
    expect(messages.length, expectedMessages.length);
    expect(messages, expectedMessages.reversed);
    messageDao.delete();
    messages = await messageDao.get();
    expect(messages.length, 0);
    expect(messages, []);
  });
}
