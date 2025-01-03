class UserModel {
  String? uid;
  String? email;
  String? firstname;
  String? lastname;
  String? phone;
  String? profile;
  AuthType? authtype;

  UserModel({
    this.uid,
    this.email,
    this.firstname,
    this.lastname,
    this.phone,
    this.profile,
    this.authtype,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      firstname: data['firstname'],
      lastname: data['lastname'],
      phone: data['phone'],
      profile: data['profile'],
      authtype: data['authtype'] == "email" ? AuthType.email : AuthType.google,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'profile': profile,
      'authtype': authtype!.value,
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