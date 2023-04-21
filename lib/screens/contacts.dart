import 'package:chat/widgets/chatWindow.dart';
import 'package:chat/widgets/contactList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactScreen extends ConsumerWidget {
  String routeName = '/contacts';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
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
