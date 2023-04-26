import 'package:chat/constants.dart';
import 'package:chat/models/contact.dart';
import 'package:chat/models/message.dart';
import 'package:dio/dio.dart';

final dio = Dio();

Future<List<Contact>?> fetchContacts() async {
  try {
    Response response = await dio.get(Routes.CONTACTS);
    List<dynamic> contactsData = response.data['WABAContacts'].values.toList();
    List<Contact> contacts =
        contactsData.map((json) => Contact.fromJson(json)).toList();
    return contacts;
  } catch (e) {
    print(e);
  }
  return null;
}

Future<List<Message>?> fetchChat(Contact contact, timestamp) async {
  final t =
      timestamp != null ? timestamp : DateTime.now().millisecondsSinceEpoch;
  final url =
      'https://localhost:6001/api/v1/contact/${contact.phone}/messages/${contact.fromNo}/$t';

  Response response = await dio.get(url);
  List<dynamic> chatData = response.data;

  List<Message> chats = chatData.map((e) => Message.fromJson(e)).toList();
  print(chats.length);
  return chats;
}
