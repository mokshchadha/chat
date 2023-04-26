import 'package:chat/widgets/chatWindow.dart';
import 'package:chat/widgets/contactList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactScreen extends ConsumerWidget {
  final String routeName = '/contacts';

  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: const [
          Expanded(
            flex: 2,
            child: ContactList(),
          ),
          Expanded(
            flex: 4,
            child: ChatWindow(),
          ),
        ],
      ),
    );
  }
}
