import 'package:chat/models/contact.dart';
import 'package:chat/providers/providers.dart';
import 'package:chat/widgets/conversation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatWindow extends ConsumerWidget {
  const ChatWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Contact? selected = ref.watch(selectedContactProvider);

    return Scaffold(
      appBar: selected == null
          ? AppBar(
              automaticallyImplyLeading: false,
            )
          : AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                  const SizedBox(width: 10.0),
                  Text('${selected.name} - (${selected.company})'),
                ],
              ),
              actions: selected == null
                  ? []
                  : [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.call),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.videocam),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
                      ),
                    ],
            ),
      body: selected == null
          ? const Center(
              child: Text('Hi, Please select a contact from contacts list'),
            )
          : Column(
              children: [
                const Conversation(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt),
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8.0),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.mic),
                        color: Theme.of(context).primaryColor,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.send),
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
