import 'package:cached_network_image/cached_network_image.dart';
import 'package:flostr/data/models/profile.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(this.profile, {super.key});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        final snackBar = SnackBar(
          content: Text(profile.toString()),
        );

        final messenger = ScaffoldMessenger.of(context);
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(snackBar);
      },
      leading: CircleAvatar(
        backgroundColor: Color(
          int.parse('0XFF${profile.pubkey?.substring(0, 6)}'),
        ),
        backgroundImage: CachedNetworkImageProvider(profile.picture!),
      ),
      title: Text(profile.displayName!),
      subtitle: Text(
        profile.about!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
