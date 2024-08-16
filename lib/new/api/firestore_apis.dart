import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
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

  static Future<Map<String, dynamic>> getCategories() async {
    String jsonUrl;
    jsonUrl = await FirebaseFirestore.instance
        .collection('global-data')
        .doc('categories')
        .get()
        .then((value) {
      return (value.data() as Map<String, dynamic>)['url'] ?? '';
    });

    final response = await http.get(Uri.parse(jsonUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> categories = await jsonDecode(response.body);
      categories['isSuccess'] = true;
      // log(categories.toString(), name: "json");
      return categories;
    } else {
      log('Failed to load categories', name: "json");
      return {'isSuccess': false};
    }
  }
}
