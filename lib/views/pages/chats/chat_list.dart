import 'package:flostr/data/models/profile.dart';
import 'package:flostr/views/pages/chats/chat_item.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList(this.profiles, {super.key});

  final List<Profile> profiles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (context, index) => ChatItem(profiles[index]),
    );
  }
}
