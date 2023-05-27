import 'package:flostr/data/models/profile.dart';
import 'package:flostr/views/pages/base_scaffold.dart';
import 'package:flostr/views/pages/chats/chat_list.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  static const route = '/home';

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final _profiles = [
    Profile(
      pubkey:
          '2fc2558c53ccce0cbe9a324c5f58041319a4f4888266cae1d8c72e4e6382a72c',
      picture: 'https://robohash.org/theodore?size=128x128',
      name: 'theodore',
      about:
          'Commodo laboris laborum in eiusmod cupidatat nisi veniam eiusmod deserunt ipsum aute in.',
      nip05: 'theodore@iris.to',
      nip05valid: 'true',
      lud16: '',
      username: 'theodore',
      displayName: 'Mr. Theodore Becker',
      website: 'https://flostr.com',
    ),
    Profile(
      pubkey:
          'd6db4d8c53ccce0cbe9a324c5f58041319a4f4888266cae1d8c72e4e6382a72c',
      picture: 'https://robohash.org/chelsea?size=128x128',
      name: 'chelsea',
      about: 'Sint incididunt Lorem non velit elit.',
      nip05: 'chelsea@iris.to',
      nip05valid: 'true',
      lud16: '',
      username: 'chelsea',
      displayName: 'Chelsea Heathcote',
      website: 'https://flostr.com',
    ),
    Profile(
      pubkey:
          '99e7f58c53ccce0cbe9a324c5f58041319a4f4888266cae1d8c72e4e6382a72c',
      picture: 'https://robohash.org/ruth?size=128x128',
      banner:
          'https://nostr.build/i/a43ab8b98565b43216990ae8684670799ae9024d382176d74537a2ca61da4bb1.gif',
      name: 'ruth',
      about: 'Do cillum labore non duis nulla aliquip cillum.',
      nip05: 'ruth@iris.to',
      nip05valid: 'true',
      lud16: '',
      username: 'ruth',
      displayName: 'Ruth DuBuque',
      website: 'https://flostr.com',
    ),
    Profile(
      pubkey: 'f03773c53ccce0cbe9a324c5f58041319a4f4888266cae1d8c72e4e6382a72c',
      picture: 'https://robohash.org/mandy?size=128x128',
      name: 'mandy',
      about: 'Magna duis do magna tempor non amet.',
      nip05: 'mandy@iris.to',
      nip05valid: 'true',
      lud16: '',
      username: 'mandy',
      displayName: 'Mandy Murazik',
      website: 'https://flostr.com',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: ChatList(_profiles),
      fab: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _profiles.add(
              Profile(
                pubkey:
                    '25b08fc53ccce0cbe9a324c5f58041319a4f4888266cae1d8c72e4e6382a72c',
                picture: 'https://robohash.org/potato?size=128x128',
                name: 'potato',
                about: 'Magna duis do magna tempor non amet.',
                nip05: 'potato@iris.to',
                nip05valid: 'true',
                lud16: '',
                username: 'potato',
                displayName: 'Mr. Potato Head',
                website: 'https://flostr.com',
              ),
            );
          });
        },
        icon: const Icon(Icons.add),
        label: const Text('New'),
      ),
    );
  }
}
