import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:paysa/Models/Convo.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Models/DailySpendingSplitModel.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/Models/SessionsModel.dart';
import 'package:paysa/Models/SplitModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/utils/constants/cherryToast.dart';
import 'package:uuid/uuid.dart';

class FireStoreRef {
  static String users = 'users';
  static String groups = 'groups';
  static String convo = 'convo';
  static String dailySpendings = 'dailySpendings';
  static String sessions = "sessions";
  static String splits = "splits";

  static FirebaseFirestore db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> get userCollection =>
      db.collection(users);
  static CollectionReference<Map<String, dynamic>> get groupCollection =>
      db.collection(groups);
  static CollectionReference<Map<String, dynamic>> convoCollection(String id) =>
      db.collection(groups).doc(id).collection(convo);

  static CollectionReference<Map<String, dynamic>> get sessionsCollection =>
      db.collection(sessions);
  static CollectionReference<Map<String, dynamic>> get splitsCollection =>
      db.collection(splits);

  static CollectionReference<Map<String, dynamic>> dailySpendingsCollection(
          String id) =>
      db.collection(users).doc(id).collection(dailySpendings);

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

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getGroupByIdStream(
      String id) {
    return groupCollection.doc(id).snapshots();
  }

  static uploadUser(User user) {
    UserModel usr = UserModel(
      uid: user.uid,
      name: user.displayName!,
      email: user.email!,
      phone: "",
      profile: user.photoURL!,
    );
    userCollection.doc(user.uid).get().then((value) {
      if (!value.exists) {
        userCollection.doc(user.uid).set(usr.toJson());
      }
    });
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDataByIdStream(
      String id) {
    return userCollection.doc(id).snapshots();
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

  static Future getuserByUid(String uid) async {
    // await Future.delayed(const Duration(seconds: 2));
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

  static Stream<DocumentSnapshot<Map<String, dynamic>>>
      getUserGroupListStream() {
    return userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getConvoStream(
      String groupId) {
    return convoCollection(groupId).snapshots();
  }

  static createConvo(String groupId, Map<String, dynamic> convo) async {
    await convoCollection(groupId).doc(convo['id']).set(convo);
  }

  // get streamed my spendings list
  static Stream<List<Map<String, dynamic>>> getMyDailySpendingsStream() {
    log(FirebaseAuth.instance.currentUser!.uid);
    return dailySpendingsCollection(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  static Future<List<Map<String, dynamic>>> getMyDailySpendings() {
    return dailySpendingsCollection(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  static Future<bool> removeDailySpendingById(String spendingId) async {
    bool result = false;
    await dailySpendingsCollection(FirebaseAuth.instance.currentUser!.uid)
        .doc(spendingId)
        .delete()
        .then((value) => result = true)
        .catchError((error) => result = false);
    return result;
  }

  // add daily spending
  static addDailySpending(DailySpendingModel spending) async {
    await dailySpendingsCollection(FirebaseAuth.instance.currentUser!.uid)
        .doc(spending.id)
        .set(spending.toJson());
  }

  static updateDailySpending(DailySpendingModel spending) async {
    await dailySpendingsCollection(FirebaseAuth.instance.currentUser!.uid)
        .doc(spending.id)
        .update(spending.toJson());
  }

  static addSplitData(DailySpendingModel data) async {
    // create a split
    await splitsCollection.doc(data.id).set(data.toJson());
    // add daily spending data in all users's collection
    for (Split split in data.splits!) {
      await dailySpendingsCollection(split.uid).doc(data.id).set({
        'id': data.id,
        'isSplit': true,
      });
    }
    // storing the split amount of the person who paid the whole split
    double payedPersonBySplitAmount = 0;
    for (Split splt in data.splits ?? []) {
      if (splt.uid == data.paidy!) {
        payedPersonBySplitAmount = splt.amount;
      }
    }

    // now make a sessions if not exists
    List<String> sessionIds = await getSessionIdsList();

    for (Split split in data.splits!) {
      if (split.uid == data.paidy) {
        continue;
      }
      if (sessionIds.contains("${data.paidy}-${split.uid}")) {
        Map<String, dynamic> fetchSessionJson =
            await FireStoreRef.getSessionBySessionId(
                "${data.paidy}-${split.uid}");
        SessionsModel sessionData = SessionsModel.fromJson(fetchSessionJson);
        sessionData.convoAndTags.add(Convo(
          id: data.id,
          sender: data.paidy!,
          message: "",
          timestamp: DateTime.now(),
          type: 'split',
        ));
        if (sessionData.users[0]['id'] == data.paidy) {
          sessionData.users[0]['amount'] += payedPersonBySplitAmount;
          sessionData.users[1]['amount'] += split.amount;
        } else {
          sessionData.users[1]['amount'] += payedPersonBySplitAmount;
          sessionData.users[0]['amount'] += split.amount;
        }
        await FireStoreRef.updateSessionData(sessionData);
        // await sessionsCollection.doc("${data.paidy}-${split.uid}").update({
        //   'convoAndTags': FieldValue.arrayUnion([
        //     Convo(
        //       id: data.id,
        //       sender: FirebaseAuth.instance.currentUser!.uid,
        //       message:
        //           "${FirebaseAuth.instance.currentUser!.displayName!.split(' ').first} added new split",
        //       timestamp: data.timestamp,
        //       type: 'split',
        //     ).toJson()
        //   ]),
        // });
        continue;
      }
      if (sessionIds.contains("${split.uid}-${data.paidy}")) {
        Map<String, dynamic> fetchSessionJson =
            await FireStoreRef.getSessionBySessionId(
                "${split.uid}-${data.paidy}");
        SessionsModel sessionData = SessionsModel.fromJson(fetchSessionJson);
        sessionData.convoAndTags.add(Convo(
          id: data.id,
          sender: data.paidy!,
          message: "",
          timestamp: DateTime.now(),
          type: 'split',
        ));
        if (sessionData.users[0]['id'] == data.paidy) {
          sessionData.users[0]['amount'] += payedPersonBySplitAmount;
          sessionData.users[1]['amount'] += split.amount;
        } else {
          sessionData.users[1]['amount'] += payedPersonBySplitAmount;
          sessionData.users[0]['amount'] += split.amount;
        }
        await FireStoreRef.updateSessionData(sessionData);
        continue;
      }

      List<Map<String, dynamic>> userList = [
        {
          'id': data.paidy!,
          'amount': payedPersonBySplitAmount,
          'lastPaid': DateTime.now().toIso8601String(),
        },
        {
          'id': split.uid,
          'amount': split.amount,
          'lastPaid': DateTime.now().toIso8601String()
        },
      ];

      SessionsModel newSession = SessionsModel(
        id: "${data.paidy}-${split.uid}",
        timestamp: data.timestamp,
        users: userList,
        title: data.title +
            " on " +
            [
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday',
              'Sunday',
            ][data.timestamp.weekday - 1],
        convoAndTags: [
          Convo(
            id: data.id,
            sender: FirebaseAuth.instance.currentUser!.uid,
            message:
                "${FirebaseAuth.instance.currentUser!.displayName!.split(' ').first} added new split",
            timestamp: data.timestamp,
            type: 'split',
          ),
        ],
      );
      await sessionsCollection
          .doc("${data.paidy}-${split.uid}")
          .set(newSession.toJson());
    }
    // if (!sessionExists) {
    //   for (Split split in data.splits!) {
    //     SessionsModel newSession = SessionsModel(
    //         id: data.paidy! + splits.uid,
    //         members: [data.paidy!, splits.uid],
    //         timestamp: data.timestamp,
    //         title: data.title +
    //             " on " +
    //             [
    //               'Monday',
    //               'Tuesday',
    //               'Wednesday',
    //               'Thursday',
    //               'Friday',
    //               'Saturday',
    //               'Sunday',
    //             ][data.timestamp.day],
    //         convoAndTags: [
    //           Convo(
    //             id: Uuid().v1(),
    //             sender: FirebaseAuth.instance.currentUser!.uid,
    //             message:
    //                 "${FirebaseAuth.instance.currentUser!.displayName!.split(' ').first} added new split",
    //             timestamp: data.timestamp,
    //             type: 'split',
    //           ),
    //         ]);
    //   }
    // } else {
    //   for (Split split in data.splits!) {
    //     await sessionsCollection.doc("${data.paidy}-${split.uid}").update({
    //       'splits': FieldValue.arrayUnion([data.id]),
    //     });
    //   }
    // }
  }

  // static Future<void> addNewSplitConvoIntoSession(String sessionid)async{
  //   await sessions.id
  // }

  static Future<List<String>> getSessionIdsList() async {
    QuerySnapshot querySnapshot = await sessionsCollection.get();
    List<String> documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  static checkIfSessionExists(String u1id, String u2id) async {
    List<String> sessionIds = await getUserSessionsList(u1id);
    bool result = false;
    for (String id in sessionIds) {
      log(id);
      log("${id.contains(u2id)} ${id.contains(u1id)}");
      if (id.contains(u2id) && id.contains(u1id)) {
        result = true;
        break;
      }
    }
    return result;
  }

  static Future<Map<String, dynamic>> getSessionBySessionId(String id) async {
    return await sessionsCollection
        .doc(id)
        .get()
        .then((value) => value.data() ?? {});
  }

  static Future<void> updateSessionData(SessionsModel session) async {
    await sessionsCollection.doc(session.id).update(session.toJson());
  }

  static Future<List<String>> getUserSessionsList(String id) async {
    List<String> sessions = [];
    await userCollection.doc(id).get().then((value) {
      if (value.exists) {
        sessions = List.from((value.data() ?? {})['sessions'] ?? []);
      }
    });
    return sessions;
  }

  static Stream<Map<String, dynamic>?> getSplitDataByIdStream(String id) {
    return splitsCollection.doc(id).snapshots().map((event) => event.data());
  }

  static Future<Map<String, dynamic>?> getSplitDataById(String id) async {
    return await splitsCollection.doc(id).get().then((value) => value.data());
  }

  static Future<Map<String, dynamic>?> fetchSplitDataById(String id) async {
    return await splitsCollection.doc(id).get().then((value) => value.data());
  }

  static Future<List<Map<String, dynamic>>> fetchSplitsFromDailySpending(
      bool isSplit) async {
    List<Map<String, dynamic>> lst = [];
    var data =
        await dailySpendingsCollection(FirebaseAuth.instance.currentUser!.uid)
            .where('isSplit', isEqualTo: isSplit)
            .get()
            .then((value) {
      for (var item in value.docs) {
        lst.add(item.data());
        log(item.data().toString());
      }
    });

    return lst;
  }

  static createSessions(SessionsModel sessions) async {
    await sessionsCollection.doc(sessions.id).set(sessions.toJson());
  }

  static getSessions(String id) async {
    return await sessionsCollection.doc(id).get().then((value) => value.data());
  }

  static Stream<List<Map<String, dynamic>>> getSessionsListStream() {
    return sessionsCollection
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  static getUserDataAsStreamByUid(String uid) {
    return userCollection.doc(uid).get().asStream();
  }

  // static Stream<List<Map<String, dynamic>>> getDailySpendingListWithSplits(
  //     String groupId) {
  //   List spendings = [];
  // dailySpendingsCollection(FirebaseAuth.instance.currentUser!.uid)
  //     .where('isSplit', isEqualTo: true)
  //     .snapshots()
  //     .map((event) => event.docs.map((e) => e.data()).toList());
  // }
}
