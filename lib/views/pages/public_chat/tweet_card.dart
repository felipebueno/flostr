import 'package:cached_network_image/cached_network_image.dart';
import 'package:flostr/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TweetCard extends StatelessWidget {
  final String avatar;
  final String pubkey;
  final int timestamp;
  final String text;

  const TweetCard({
    super.key,
    required this.avatar,
    required this.pubkey,
    required this.timestamp,
    required this.text,
  });

  String _formatDate(int secondsUnixTimestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(
      secondsUnixTimestamp * 1000,
      isUtc: true,
    ).toLocal().toString();

    return date.substring(0, date.length - 4);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                margin: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: CircleAvatar(
                    backgroundColor: Color(
                      int.parse('0XFF${pubkey.substring(0, 6)}'),
                    ),
                    backgroundImage: CachedNetworkImageProvider(avatar),
                  ),
                  onTap: () {
                    // print('pubkey: $pubkey');
                  },
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 5.0),
                              child: InkWell(
                                child: Text(
                                  pubkey.substring(0, 8),
                                ),
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(text: pubkey),
                                  );
                                  infoSnack('Copied to clipboard: $pubkey');
                                },
                              ),
                            ),
                            Text(
                              _formatDate(timestamp),
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.sailing,
                            size: 14.0,
                            color: Colors.white70,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SelectableText(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
