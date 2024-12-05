import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paysa/Models/UserModel.dart';

class PFirestoreAPIs {
  static const String users = 'user';
  static CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(users);

  static Future<UserModel> getUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot doc = await usersCollection.doc(uid).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  static Future<void> createUser(UserModel user) async {
    await usersCollection.doc(user.uid).set(user.toMap());
  }
}
