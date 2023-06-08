import 'package:flostr/data/models/profile.dart';
import 'package:flostr/main.dart';
import 'package:flostr/utils/alerts.dart';
import 'package:flostr/views/pages/profile/profile_viewmodel.dart';
import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm(Profile profile, {super.key}) : _profile = profile;

  final Profile _profile;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final model = locator<ProfileViewModel>();
  final _formKey = GlobalKey<FormState>();
  late Profile _profile;

  @override
  void initState() {
    super.initState();
    _profile = widget._profile.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget._profile.picture != null)
            CircleAvatar(
              // backgroundColor: Color(
              //   int.parse('0XFF${profile.pubkey?.substring(0, 6)}'),
              // ),
              backgroundImage: NetworkImage(
                widget._profile.picture!,
              ),
            ),
          Row(
            children: [
              const Text('Name: '),
              Expanded(
                child: TextFormField(
                  controller: TextEditingController(text: widget._profile.name),
                  onChanged: (value) =>
                      _profile = _profile.copyWith(name: value),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('About: '),
              Expanded(
                child: TextFormField(
                  controller:
                      TextEditingController(text: widget._profile.about),
                  onChanged: (value) =>
                      _profile = _profile.copyWith(about: value),
                  minLines: 1,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          // Save button
          ElevatedButton(
            onPressed: () async {
              await model.updateProfile(_profile);
              infoSnack('Profile saved?');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
