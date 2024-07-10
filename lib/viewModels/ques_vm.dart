import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mcqtest/models/question_model.dart';
import 'package:mcqtest/models/streaks_models.dart';
import 'package:mcqtest/models/user_model.dart';
import 'package:mcqtest/services/Apis/api_service.dart';
import 'package:mcqtest/services/Firestore/firestore_collections.dart';

class QuestionViewModel extends ChangeNotifier {
  List<QuestionModel> _questions = [];
  int _currentQuestionIndex = 0;
  int _testDuration = 5;
  DateTime? _startTime;
  DateTime? _endTime;
  StreakModel? _streakModel;
  int streakCount = 0;
  int allTimeHighestStreak = 0;

  List<QuestionModel> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get testDuration => _testDuration;

  DateTime? get startTime => _startTime;
  DateTime? get endTime => _endTime;

  // init
  QuestionViewModel() {
    initializeQuestion();
    syncStreak();
  }

  void setQuestions(List<QuestionModel> questions) {
    _questions.clear();

    _questions = questions;
    _startTime = DateTime.now();
    _endTime = _startTime!.add(Duration(minutes: testDuration));
    _currentQuestionIndex = 0;
    notifyListeners();
  }

  void setCurrentQuestionIndex(int index) {
    _currentQuestionIndex = index;
    notifyListeners();
  }
  // void setIsLoading(bool isLoading) {
  //   _isLoading = isLoading;
  //   notifyListeners();
  // }

  void setStartTime(DateTime time) {
    _startTime = time;
    notifyListeners();
  }

  void setEndTime(DateTime time) {
    _endTime = time;
    notifyListeners();
  }

  Future<void> selectOption(String option) async {
    _questions[_currentQuestionIndex].selectedAnswer = option;
    await updateStreak(_questions[_currentQuestionIndex]);
    notifyListeners();
  }

  void addQuestion(QuestionModel question) {
    _questions.add(question);
    notifyListeners();
  }

  void removeQuestion(QuestionModel question) {
    _questions.remove(question);
    notifyListeners();
  }

  void updateQuestion(QuestionModel question) {
    int index = _questions.indexWhere((element) => element.id == question.id);
    _questions[index] = question;
    notifyListeners();
  }

  void clearQuestions() {
    _questions.clear();
    notifyListeners();
  }

  Future<void> updateStreak(QuestionModel questionModel) async {
    if (_streakModel == null) {
      _streakModel = StreakModel(
        timestamp: DateTime.now(),
        questions: [],
      );
    } else {
      _streakModel!.timestamp = DateTime.now();
    }

    if (_streakModel!.questions.isEmpty) streakCount++;
    if (streakCount > allTimeHighestStreak) {
      allTimeHighestStreak = streakCount;
    }
    await FireStoreCollections.updateStreakCount(
        streakCount, allTimeHighestStreak);
    _streakModel!.questions.add(questionModel.id);
    await FireStoreCollections.updateStreak(
        FirebaseAuth.instance.currentUser!.uid, _streakModel!);
    notifyListeners();
  }

  void syncStreak() async {
    _streakModel = await FireStoreCollections.getTodayStreak(DateTime.now());

    UserModel usr = await FireStoreCollections.getUserData(
        FirebaseAuth.instance.currentUser!.uid);
    streakCount = usr.streakcount ?? 0;
    allTimeHighestStreak = usr.highestStreak ?? 0;
    List<String> streaks = await FireStoreCollections.getStreakDates(
        FirebaseAuth.instance.currentUser!.uid);

    List<DateTime> streakDates = streaks
        .map((e) => DateFormat(StreakModel.streakDateFormat).parse(e))
        .toList();

    streakDates.sort((a, b) => b.compareTo(a));
    // log(streakDates.toString());

    if (DateTime.now().difference(streakDates.last).inDays > 1) {
      streakCount = 0;
      await FireStoreCollections.updateStreakCount(
          streakCount, allTimeHighestStreak);
    }

    notifyListeners();
  }

  void initializeQuestion() async {
    if (questions.isEmpty) {
      fetchQuestions();
    }
  }

  void fetchQuestions() async {
    Map<String, dynamic> data = await APIService.getRandomQuestions();

    if (data['status']) {
      List<QuestionModel> questions = [];
      for (var item in data['data']) {
        questions.add(QuestionModel.fromAPIJson(item));
      }
      // log(questions.length.toString());
      setQuestions(questions);
    } else {
      log('Failed to fetch questions');
    }
  }
}
