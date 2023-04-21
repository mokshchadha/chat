import 'package:chat/models/contact.dart';
import 'package:chat/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactList extends ConsumerStatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends ConsumerState<ContactList> {
  final TextEditingController _searchController = TextEditingController();

  void _filterContacts(String query, List<Contact> contacts) {
    final List<Contact> filtered = [];
    contacts.forEach((contact) {
      if (contact.name.toLowerCase().contains(query.toLowerCase()) ||
          contact.company.toLowerCase().contains(query.toLowerCase()) ||
          contact.designation.toLowerCase().contains(query.toLowerCase())) {
        filtered.add(contact);
      }
    });
    ref.read(filteredContactsProvider.notifier).set(filtered);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Contact> filteredContacts = ref.watch(filteredContactsProvider);
    final List<Contact>? allCon = ref.watch(contactsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search Contacts',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) => _filterContacts(query, allCon!),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return InkWell(
                  onTap: () {
                    //=> Navigator.pushNamed(context, '/chat')
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.125, color: Colors.grey)),
                      child: ListTile(
                        title: Text(contact.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(contact.company),
                            Text(contact.designation),
                            Text(contact.phone),
                          ],
                        ),
                        leading: CircleAvatar(
                          child: Text(
                              contact.name.isNotEmpty ? contact.name[0] : 'NA'),
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
