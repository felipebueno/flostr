import 'package:cached_network_image/cached_network_image.dart';
import 'package:flostr/data/models/profile.dart' as local_profile;
import 'package:flostr/views/base_view.dart';
import 'package:flostr/views/pages/base_scaffold.dart';
import 'package:flostr/views/pages/profile/profile_form.dart';
import 'package:flostr/views/pages/profile/profile_viewmodel.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const route = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      builder: (context, model, __) {
        return BaseScaffold(
          title: 'Profile',
          body: StreamBuilder(
            stream: model.profiles,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final profile = snapshot.data as local_profile.Profile;

              return Column(
                children: [
                  if (profile.picture != null)
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        profile.picture!,
                      ),
                    ),
                  Text(profile.toString()),
                  Expanded(child: ProfileForm(profile)),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
