import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paysa/new/Models/user_data.dart';

class FirestoreAPIs {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> createUser(UserData user) async {
    await users.doc(user.uid).set(user.toJson());
  }

  // get user by email

  // get user by uid

  // update user
}
