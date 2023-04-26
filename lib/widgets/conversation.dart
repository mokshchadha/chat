import 'package:chat/models/contact.dart';
import 'package:chat/models/message.dart';
import 'package:chat/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Conversation extends ConsumerStatefulWidget {
  const Conversation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConversationState();
}

class _ConversationState extends ConsumerState<Conversation> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      Contact? selected = ref.watch(selectedContactProvider);
      int newMessages = await ref.read(chatsProvider.notifier).loadMore();
      if (newMessages == 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: selected != null
              ? Text('No further chats available for  ${selected.name}')
              : const Text('No further chats available for '),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Message>? chats = ref.watch(chatsProvider);
    return (chats == null)
        ? const SizedBox()
        : Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount:
                  chats.length, // replace with the actual number of messages
              itemBuilder: (context, index) {
                Message msg = chats[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: msg.eventDirection == 'incoming'
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: msg.eventDirection == 'incoming'
                            ? Colors.grey[100]
                            : Colors.green[100],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                          bottomLeft: msg.eventDirection == 'incoming'
                              ? const Radius.circular(20.0)
                              : const Radius.circular(0.0),
                          bottomRight: msg.eventDirection == 'incoming'
                              ? const Radius.circular(0.0)
                              : const Radius.circular(20.0),
                        ),
                      ),
                      child: Text(msg.text),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
