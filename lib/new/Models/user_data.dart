class UserData {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final bool googleAuth;

  UserData({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.googleAuth,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'googleAuth': googleAuth,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      googleAuth: json['googleAuth'],
    );
  }

  UserData copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      googleAuth: googleAuth,
    );
  }

  @override
  String toString() {
    return 'UserData(uid: $uid, name: $name, email: $email, photoUrl: $photoUrl, googleAuth: $googleAuth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.googleAuth == googleAuth;
  }
}
