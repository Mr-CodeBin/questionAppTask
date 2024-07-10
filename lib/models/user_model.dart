import 'package:mcqtest/models/streaks_models.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phoneNumber;
  DateTime? lastLogin;
  int? streakcount;
  StreakModel? streaks;
  int? highestStreak;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.lastLogin,
    this.streakcount = 0,
    this.streaks,
    this.highestStreak = 0,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    lastLogin = json['lastLogin'].toDate();
    streakcount = json['streakcount'];
    streaks = json['streaks'];
    highestStreak = json['highestStreak'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'lastLogin': lastLogin,
      'streakcount': streakcount,
      'streaks': streaks,
      'highestStreak': highestStreak,
    };
  }
}
