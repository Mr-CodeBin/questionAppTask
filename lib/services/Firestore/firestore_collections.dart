import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mcqtest/models/streaks_models.dart';
import 'package:mcqtest/models/user_model.dart';

class FireStoreCollections {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUserData(UserModel user) async {
    await userCollection.doc(user.uid).set(user.toJson());
  }

  static Future<void> updateUserData(UserModel user) async {
    await userCollection.doc(user.uid).update(user.toJson());
  }

  static Future<UserModel> getUserData(String uid) async {
    DocumentSnapshot doc = await userCollection.doc(uid).get();
    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  static Future<void> updateStreakCount(int str, int hstr) async {
    log("updating streak count $str $hstr");
    await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'highestStreak': hstr,
      'streakcount': str,
    });
  }

  static CollectionReference streaksCollection(String uid) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('streaks');

  static Future<void> updateStreak(String uid, StreakModel streak) async {
    await streaksCollection(uid).doc(streak.formattedDate).set(streak.toJson());
  }

  static Future<List<StreakModel>> getStreaks(String uid) async {
    QuerySnapshot querySnapshot = await streaksCollection(uid).get();
    return querySnapshot.docs
        .map((doc) => StreakModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<List<String>> getStreakDates(String uid) async {
    QuerySnapshot querySnapshot = await streaksCollection(uid).get();
    return querySnapshot.docs.map((doc) => doc.id).toList();
  }

  // get today's streak
  static Future<StreakModel?> getTodayStreak(DateTime dateTime) {
    return streaksCollection(FirebaseAuth.instance.currentUser!.uid)
        .doc(DateFormat(StreakModel.streakDateFormat).format(dateTime))
        .get()
        .then((doc) {
      if (doc.exists) {
        return StreakModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  //
}
