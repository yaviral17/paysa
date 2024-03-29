import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/utils/constants/cherryToast.dart';

class FireStoreRef {
  static String users = 'users';
  static String groups = 'groups';
  static String convo = 'convo';

  static FirebaseFirestore db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> get userCollection =>
      db.collection(users);
  static CollectionReference<Map<String, dynamic>> get groupCollection =>
      db.collection(groups);
  static CollectionReference<Map<String, dynamic>> convoCollection(String id) =>
      db.collection(groups).doc(id).collection(convo);

  static addGroup(Group group) async {
    await groupCollection.doc(group.id).set(group.toJson());

    for (String member in group.members) {
      await userCollection.doc(member).update({
        'groups': FieldValue.arrayUnion([group.id])
      });
    }

    // await userCollection.doc(group.createdBy).update({
    //   'groups': FieldValue.arrayUnion([group.id])
    // });
  }

  static getUserGroupList() async {
    List<Group> groups = [];
    Map<String, dynamic>? data = await userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.data());
    if (data == null) {
      return null;
    }
    for (String groupId in data['groups']) {
      Map<String, dynamic>? groupData = await getGroupById(groupId);
      if (groupData != null) {
        groups.add(Group.fromJson(groupData));
        continue;
      }
      log('Group id not found');
    }
    return groups;
  }

  static getGroupById(String id) async {
    return await groupCollection.doc(id).get().then((value) => value.data());
  }

  static uploadUser(User user) {
    userCollection.doc(user.uid).set({
      "uid": user.uid,
      "name": user.displayName,
      "email": user.email,
      "phone": user.phoneNumber ?? "",
      "profile": user.photoURL,
    });
  }

  static Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    return await userCollection
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        return null;
      }
      return value.docs.first.data();
    });
  }

  static getuserByUid(String uid) async {
    return await userCollection.doc(uid).get().then((value) => value.data());
  }

  static createGroup(Group group) async {
    await groupCollection.doc(group.id).set(group.toJson());
    await userCollection.doc(group.createdBy).update({
      'groups': FieldValue.arrayUnion([group.id]),
    });
  }

  //remove group from user's group list
  static removeGroupFromUser(String groupId, uid) async {
    await userCollection.doc(uid).update({
      'groups': FieldValue.arrayRemove([groupId]),
    });
  }

  static getConvoById(String convoId, String groupId) async {
    return await convoCollection(groupId).doc(convoId).get().then((value) {
      if (value.exists) {
        return value.data();
      }
      return null;
    });
  }

  static Future<List<Map<String, dynamic>>> getConvoList(String groupId) async {
    List<Map<String, dynamic>> convos = [];
    await convoCollection(groupId).get().then((value) {
      // log(value.docs[0].data().toString());
      for (int i = 0; i < value.docs.length; i++) {
        log(value.docs[i].data().toString());
        convos.add(value.docs[i].data());
      }
    });
    // log("hi             " + convos.toString());
    return convos;
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getGroupStream(
      String groupId) {
    return groupCollection.doc(groupId).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getConvoStream(
      String groupId) {
    return convoCollection(groupId).snapshots();
  }

  static createConvo(String groupId, Map<String, dynamic> convo) async {
    await convoCollection(groupId).doc(convo['id']).set(convo);
  }
}
