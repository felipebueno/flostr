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
