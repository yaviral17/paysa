import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paysa/Models/GroupModel.dart';

class FireStoreRef {
  static String users = 'users';
  static String groups = 'groups';

  static FirebaseFirestore db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> get userCollection =>
      db.collection(users);
  static CollectionReference<Map<String, dynamic>> get groupCollection =>
      db.collection(groups);
  static addGroup(Group group) async {
    await groupCollection.doc(group.id).set(group.toJson());
    await userCollection.doc(group.createdBy).update({
      'groups': FieldValue.arrayUnion([group.id])
    });
  }

  static getUserGroupList() async {
    return userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.data()!['groups']);
  }

  static uploadUser(User user) {
    userCollection.doc().set({
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
    return await userCollection
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) => value.docs.first.data());
  }

  static createGroup(Group group) async {
    await groupCollection.doc(group.id).set(group.toJson());
    await userCollection.where('uid', isEqualTo: group.createdBy).get().then(
      (value) {
        userCollection.doc(value.docs.first.id).update({
          'groups': FieldValue.arrayUnion([group.id])
        });
      },
    );
  }
}
