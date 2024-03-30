import 'package:paysa/Config/FirestoreRefrence.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String profile;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.profile,
  });
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'profile': profile,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profile: json['profile'],
    );
  }

  static Future<UserModel> getUserbodelById(String id) async {
    Map<String, dynamic> data = await FireStoreRef.getuserByUid(id);
    return UserModel.fromJson(data);
  }
}
