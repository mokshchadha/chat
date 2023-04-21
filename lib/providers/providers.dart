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
      print(contacts.length);
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
  return SelectedContactNotifier();
});

class SelectedContactNotifier extends StateNotifier<Contact?> {
  SelectedContactNotifier() : super(null);
}

final chatsProvider =
    StateNotifierProvider<ChatsAsyncNotifier, AsyncValue<List<Message>?>>(
        (ref) => ChatsAsyncNotifier());

class ChatsAsyncNotifier extends StateNotifier<AsyncValue<List<Message>?>> {
  List<Message>? _chats;

  ChatsAsyncNotifier() : super(const AsyncLoading()) {
    if (_chats == null) _init();
  }

  Future<void> _init() async {}

  Future<void> empty() async {
    _chats = null;
    state = AsyncData(_chats);
  }

  void remove(String gradeId) async {
    if (_chats == null) return;
    state =
        const AsyncLoading(); // before we start the removal we make the list loading so that no more changes come from UI
    state = AsyncData(_chats);
  }
}
