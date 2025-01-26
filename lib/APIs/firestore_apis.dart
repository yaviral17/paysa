import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/Models/spending_model.dart';

class FirestoreAPIs {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('user');
  static CollectionReference transactions =
      FirebaseFirestore.instance.collection('device-tokens');
  static CollectionReference globalData =
      FirebaseFirestore.instance.collection('global-data');

  static Future<void> createUser(UserModel user) async {
    await users.doc(user.uid).set(user.toMap());
  }

  static Future<UserModel> getUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot doc = await users.doc(uid).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  static Future<Map<String, dynamic>> getCurrencyRates() async {
    Map<String, dynamic>? data = await FirebaseFirestore.instance
        .collection('global-data')
        .doc('currency-rates')
        .get()
        .then(
      (value) {
        return value.data();
      },
    );
    // log(data.toString());
    return data as Map<String, dynamic>;
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

  static Future<bool> addFcmToken(String uid, String token) async {
    try {
      await users.doc(uid).set({
        'tokens': FieldValue.arrayUnion([token])
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<List<String>> getFcmTokens(String uid) async {
    List<String> tokens = [];
    await users.doc(uid).get().then((value) {
      if (value.exists) {
        tokens = List<String>.from(value.data() as List<String>? ?? []);
      }
    });
    return tokens;
  }

  static Future<void> removeFcmToken(String uid, String token) async {
    await users.doc(uid).set({
      'tokens': FieldValue.arrayRemove([token])
    }, SetOptions(merge: true));
  }

  static Future<void> updateUserData(UserModel user) async {
    await users.doc(user.uid).update(user.toMap());
  }

  static Future<void> addSpendingToUser(String uid, String spendingId) {
    return users.doc(uid).set({
      'spendings': FieldValue.arrayUnion([spendingId])
    }, SetOptions(merge: true));
  }

  static Future<void> addSpending(SpendingModel spending) async {
    await FirebaseFirestore.instance
        .collection('spendings')
        .doc(spending.id)
        .set(spending.toJson());
  }

  static Future<SpendingModel> getSpending(String spendingId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('spendings')
        .doc(spendingId)
        .get();
    return SpendingModel.fromJson(doc.data() as Map<String, dynamic>);
  }
}
