import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:paysa/Models/chat_session.dart';
import 'package:paysa/Models/user_model.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:uuid/uuid.dart';

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

  static Future<UserModel> getUser({String? uid}) async {
    uid ??= FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot doc = await users.doc(uid).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  static Future<Map<String, dynamic>> getCurrencyRates() async {
    Map<String, dynamic>? data = await FirebaseFirestore.instance
        .collection('global-data')
        .doc('country-data')
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
      await users.doc(uid).update({'token': token});
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
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

  static Future<List<UserModel>> getUsersByEmailOrUsername(
      String emailOrUsername) async {
    List<UserModel> users = [];
    await FirebaseFirestore.instance
        .collection('user')
        .where('email', isGreaterThanOrEqualTo: emailOrUsername)
        .where('email', isLessThanOrEqualTo: '$emailOrUsername\uf8ff')
        .get()
        .then((value) {
      for (var element in value.docs) {
        users.add(UserModel.fromMap(element.data()));
      }
    });

    await FirebaseFirestore.instance
        .collection('user')
        .where('username', isGreaterThanOrEqualTo: emailOrUsername)
        .where('username', isLessThanOrEqualTo: '$emailOrUsername\uf8ff')
        .get()
        .then((value) {
      for (var element in value.docs) {
        users.add(UserModel.fromMap(element.data()));
      }
    });
    await FirebaseFirestore.instance
        .collection('user')
        .where('firstname', isGreaterThanOrEqualTo: emailOrUsername)
        .where(
          'firstname',
          isLessThanOrEqualTo: '$emailOrUsername\uf8ff',
        )
        .get()
        .then((value) {
      for (var element in value.docs) {
        users.add(UserModel.fromMap(element.data()));
      }
    });

    // remove duplicates withouth using toSet()
    users = users.fold([], (prev, elem) {
      if (!prev.contains(elem)) prev.add(elem);
      return prev;
    });

    // check if it is the current userth
    users.removeWhere(
        (element) => element.uid == FirebaseAuth.instance.currentUser!.uid);
    log(users.length.toString());

    return users;
  }

  static Future<List<SpendingModel>> getSpendings(int? range) async {
    List<SpendingModel> spendings = [];
    await FirebaseFirestore.instance
        .collection('spendings')
        .where('users', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('createdAt', descending: true)
        .limit(range ?? 10)
        .get()
        .then((value) {
      for (var element in value.docs) {
        spendings.add(SpendingModel.fromJson(element.data()));
      }
    });
    return spendings;
  }

  static Future<void> updateUserName(
      double totatBalance, String userName, String uid) async {
    try {
      await users
          .doc(uid)
          .update({'balance': totatBalance, 'username': userName});
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> deleteSpendings(List<String> spendingIds) async {
    for (var spendingId in spendingIds) {
      await FirebaseFirestore.instance
          .collection('spendings')
          .doc(spendingId)
          .delete();
    }
  }

  static Future<void> upadteSpending(
      String spendingId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('spendings')
        .doc(spendingId)
        .update(data);
  }

  static Future<void> deleteSpending(String spendingId) async {
    await FirebaseFirestore.instance
        .collection('spendings')
        .doc(spendingId)
        .delete();
  }

  static Future<SpendingModel> getSpendingById(String spendingId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('spendings')
        .doc(spendingId)
        .get();
    return SpendingModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  static Future<void> checkAndCreateChatSession(ChatSession sessionData) async {
    // Check if the chat session already exists
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chat-sessions')
        .where('users', isEqualTo: sessionData.users)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // Create a new chat session if it doesn't exist
      String sessionId = const Uuid().v4();

      await FirebaseFirestore.instance
          .collection('chat-sessions')
          .doc(sessionId)
          .set(
            sessionData.toJson(),
          );
    } else {
      // If the chat session already exists, you can handle it as needed
      // For example, you can return the existing session ID or update it
      String existingSessionId = querySnapshot.docs.first.id;
      log('Chat session already exists with ID: $existingSessionId');

      // append chatmessage to existing session and update last message
      await FirebaseFirestore.instance
          .collection('chat-sessions')
          .doc(existingSessionId)
          .update({
        'lastMessage': sessionData.lastMessage,
      });
      await FirebaseFirestore.instance
          .collection('chat-sessions')
          .doc(existingSessionId)
          .update({
        'messages': FieldValue.arrayUnion([sessionData.messages.last.toJson()])
      });
    }
  }

  // Get chat sessions for a user
  static Stream<QuerySnapshot<Map<String, dynamic>>> getChatSessions() async* {
    List<ChatSession> chatSessions = [];
    // Listen for changes in the chat sessions collection
    yield* FirebaseFirestore.instance
        .collection('chat-sessions')
        .where('users', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('lastUpdateTime', descending: true)
        .snapshots();
  }
}
