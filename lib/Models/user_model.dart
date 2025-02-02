class UserModel {
  String? uid;
  String? username;
  String? email;
  String? firstname;
  String? lastname;
  String? phone;
  String? profile;
  AuthType? authtype;
  String? token;

  UserModel({
    this.uid,
    this.username,
    this.email,
    this.firstname,
    this.lastname,
    this.phone,
    this.profile,
    this.authtype,
    this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      username: data['username'],
      email: data['email'],
      firstname: data['firstname'],
      lastname: data['lastname'],
      phone: data['phone'],
      profile: data['profile'],
      authtype: data['authtype'] == "email" ? AuthType.email : AuthType.google,
      token: data['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'profile': profile,
      'authtype': authtype!.value,
      'token': token,
    };
  }
}

enum AuthType {
  email,
  google,
}

// get string value of AuthType
extension AuthTypeExtension on AuthType {
  String get value {
    switch (this) {
      case AuthType.email:
        return 'email';
      case AuthType.google:
        return 'google';
      default:
        return '';
    }
  }
}

// get AuthType from string
extension AuthTypeFromString on String {
  AuthType get authType {
    switch (this) {
      case 'email':
        return AuthType.email;
      case 'google':
        return AuthType.google;
      default:
        return AuthType.email;
    }
  }
}
