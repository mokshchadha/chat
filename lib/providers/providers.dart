import 'package:chat/models/contact.dart';
import 'package:chat/models/message.dart';
import 'package:chat/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsProvider =
    StateNotifierProvider<ContactsNotifier, List<Contact>?>(
        (ref) => ContactsNotifier(ref));

class ContactsNotifier extends StateNotifier<List<Contact>?> {
  Ref ref;
  ContactsNotifier(this.ref) : super([]) {
    fetch();
  }

  Future<void> fetch() async {
    final contacts = await fetchContacts();
    state = contacts;
    if (contacts != null) {
      ref.read(filteredContactsProvider.notifier).set(contacts);
    }
  }
}

final filteredContactsProvider =
    StateNotifierProvider<FilteredContactsNotifier, List<Contact>>(
        (ref) => FilteredContactsNotifier(ref));

class FilteredContactsNotifier extends StateNotifier<List<Contact>> {
  Ref ref;
  FilteredContactsNotifier(this.ref) : super([]) {
    // ref.read(contactsProvider.notifier).fetch();
    // final contacts = ref.watch(contactsProvider);
    // if (contacts != null) set(contacts);
  }

  set(List<Contact> filtered) {
    state = [...filtered];
  }
}

final selectedContactProvider =
    StateNotifierProvider<SelectedContactNotifier, Contact?>((ref) {
  return SelectedContactNotifier(ref);
});

class SelectedContactNotifier extends StateNotifier<Contact?> {
  Ref ref;
  SelectedContactNotifier(this.ref) : super(null);

  set(contact) {
    state = contact;
    ref.read(chatsProvider.notifier).fetch(contact);
  }
}

final chatsProvider = StateNotifierProvider<ChatsAsyncNotifier, List<Message>?>(
    (ref) => ChatsAsyncNotifier(ref));

class ChatsAsyncNotifier extends StateNotifier<List<Message>?> {
  List<Message>? _chats;
  Ref ref;

  ChatsAsyncNotifier(this.ref) : super(null) {
    if (_chats == null) _init();
  }

  Future<void> _init() async {}

  fetch(Contact? contact) async {
    if (contact == null) {
      empty();
      return;
    }
    var newChats = await fetchChat(contact, null);
    if (newChats != null) {
      _chats = newChats;
      state = (_chats);
    }
  }

  Future<void> empty() async {
    _chats = null;
    state = (_chats);
  }

  void update(Contact contact, timestamp) async {
    if (_chats == null) return;

    _chats = await fetchChat(contact, timestamp);
    state = (_chats);
  }

  Future<int> loadMore() async {
    if (_chats == null) return 0;
    int len = _chats?.length ?? 0;
    Message lastChat = _chats![len - 1];
    var contact = ref.watch(selectedContactProvider);

    if (contact != null) {
      List<Message>? moreChats = await fetchChat(contact, lastChat.timestamp);
      _chats = moreChats != null ? [..._chats!, ...moreChats] : _chats;
      state = _chats;
      return moreChats!.length;
    }
    return 0;
  }
}
