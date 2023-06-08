final class Profile {
  final String? pubkey;
  final String? picture;
  final String? banner;
  final String? name;
  final String? about;
  final String? nip05;
  final bool? nip05valid;
  final String? lud16;
  final String? username;
  final String? displayName;
  final String? website;

  Profile({
    this.pubkey,
    this.picture,
    this.banner,
    this.name,
    this.about,
    this.nip05,
    this.nip05valid,
    this.lud16,
    this.username,
    this.displayName,
    this.website,
  });

  Profile.fromJson(Map<String, dynamic> json)
      : pubkey = json['pubkey'],
        picture = json['picture'],
        banner = json['banner'],
        name = json['name'],
        about = json['about'],
        nip05 = json['nip05'],
        nip05valid = json['nip05valid'] == true || json['nip05valid'] == 'true',
        lud16 = json['lud16'],
        username = json['username'],
        displayName = json['displayName'] ?? json['display_name'],
        website = json['website'];

  Map<String, dynamic> toJson() {
    final ret = <String, dynamic>{};

    if (name != null) ret['name'] = name;
    if (picture != null) ret['picture'] = picture;
    if (banner != null) ret['banner'] = banner;
    if (about != null) ret['about'] = about;
    if (nip05 != null) ret['nip05'] = nip05;
    if (lud16 != null) ret['lud16'] = lud16;
    if (username != null) ret['username'] = username;
    if (displayName != null) ret['displayName'] = displayName;
    if (website != null) ret['website'] = website;
    if (nip05valid != null) ret['nip05valid'] = nip05valid;

    return ret;
  }

  Map<String, dynamic> toFormMap() {
    return {
      'Picture': picture,
      'Banner': banner,
      'Name': name ?? displayName,
      'About': about,
      'NIP-05': nip05,
      'LN Address': lud16,
      'Username': username,
      'Website': website,
    };
  }

  // copyWith
  Profile copyWith({
    final String? pubkey,
    final String? picture,
    final String? banner,
    final String? name,
    final String? about,
    final String? nip05,
    final bool? nip05valid,
    final String? lud16,
    final String? username,
    final String? displayName,
    final String? website,
  }) {
    return Profile(
      pubkey: pubkey ?? this.pubkey,
      picture: picture ?? this.picture,
      banner: banner ?? this.banner,
      name: name ?? this.name,
      about: about ?? this.about,
      nip05: nip05 ?? this.nip05,
      nip05valid: nip05valid ?? this.nip05valid,
      lud16: lud16 ?? this.lud16,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      website: website ?? this.website,
    );
  }

  @override
  String toString() {
    return '''pubkey: $pubkey
picture: $picture
banner: $banner
name: $name
about: $about
nip05: $nip05
nip05valid: $nip05valid
lud16: $lud16
username: $username
displayName: $displayName
website: $website''';
  }
}
