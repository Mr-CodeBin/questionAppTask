import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StreakModel {
  List<String> questions;
  DateTime timestamp;

  StreakModel({required this.timestamp, required this.questions});

  static String get streakDateFormat => 'yyyy-MM-dd';

  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      questions: List<String>.from(json['questions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'questions': questions,
    };
  }

  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(timestamp);
  }

  static Future<StreakModel> getTodayStreak() async {
    final streaks = await FirebaseFirestore.instance
        .collection('streaks')
        .where('timestamp',
            isGreaterThanOrEqualTo: DateTime.now().subtract(const Duration(days: 1)))
        .get();

    if (streaks.docs.isEmpty) {
      return StreakModel(
        timestamp: DateTime.now(),
        questions: [],
      );
    }

    return StreakModel.fromJson(streaks.docs.first.data());
  }
}
