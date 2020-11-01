import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './new_contact_form.dart';
import 'package:hive/hive.dart';
import './models/contact.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Example'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildListView()),
          NewContactForm(),
        ],
      ),
    );
  }

  Widget _buildListView() {
    final contactsBox = Hive.box('contacts');

    return ValueListenableBuilder(
      valueListenable: Hive.box('contacts').listenable(),
      builder: (context, contactsBox, _) {
        return ListView.builder(
          itemCount: contactsBox.length,
          itemBuilder: (context, index) {
            final contact = contactsBox.getAt(index) as Contact;

            return ListTile(
              title: Text(contact.name),
              subtitle: Text(contact.age.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      contactsBox.putAt(
                          index, Contact('${contact.name}*', contact.age + 1));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      contactsBox.deleteAt(
                          index);
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

//   contactsBox.watch().listen((event) {
//   });
//   return ListView.builder(
//     itemCount: contactsBox.length,
//     itemBuilder: (context, index) {
//       final contact = contactsBox.getAt(index) as Contact;
//       return ListTile(
//         title: Text(contact.name),
//         subtitle: Text(contact.age.toString()),
//       );
//     },
//   );
