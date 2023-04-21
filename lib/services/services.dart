import 'package:chat/constants.dart';
import 'package:chat/models/contact.dart';
import 'package:chat/models/message.dart';
import 'package:dio/dio.dart';

final dio = Dio();

Future<List<Contact>?> fetchContacts() async {
  try {
    print('fetchContacts is called ');
    Response response = await dio.get(Routes.CONTACTS);
    List<dynamic> contactsData = response.data['WABAContacts'].values.toList();
    print(contactsData.length);
    List<Contact> contacts =
        contactsData.map((json) => Contact.fromJson(json)).toList();
    return contacts;
  } catch (e) {
    print(e);
  }
  return null;
}

Future<List<Message>?> fetchChat() async {}
