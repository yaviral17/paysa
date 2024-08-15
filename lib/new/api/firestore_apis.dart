import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paysa/new/Models/user_data.dart';

class FirestoreAPIs {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference transactions =
      FirebaseFirestore.instance.collection('device-tokens');

  static Future<void> createUser(UserData user) async {
    await users.doc(user.uid).set(user.toJson());
  }

  // get user by email

  // get user by uid

  // update user

  // add device token
  static Future<void> addDeviceToken(String uid, String token) async {
    // add device token into list of tokens device-tokens>uid>tokens[]
    await transactions.doc(uid).set({
      'tokens': FieldValue.arrayUnion([token])
    });
  }

  static Future<void> removeDeviceToken(String uid, String token) async {
    // remove device token from list of tokens device-tokens>uid>tokens[]
    await transactions.doc(uid).set({
      'tokens': FieldValue.arrayRemove([token])
    });
  }

  // get all device tokens of a user
  static Future<List<String>> getDeviceTokens(String uid) async {
    var tokens = [];
    await transactions.doc(uid).get().then((value) {
      if (value.exists) {
        tokens = List<String>.from(value.data() as List<String>? ?? []);
      }
    });
    return tokens as List<String>;
  }
}
