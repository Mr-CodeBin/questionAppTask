import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcqtest/models/user_model.dart';
import 'package:mcqtest/services/Firestore/firestore_collections.dart';
import 'package:mcqtest/services/auth_service.dart';
import 'package:mcqtest/views/Auth/login.dart';
import 'package:mcqtest/views/screens/home_screen.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;

  UserModel? get user => _user;

  AuthViewModel() {
    _authService.user.listen((UserModel? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      return;
    }

    UserModel? user =
        await _authService.signInWithEmailAndPassword(email, password);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HomeScreen(),
    ));
  }

  Future<void> registerWithEmailAndPassword(
      String name, String email, String password, BuildContext context) async {
    await _authService.registerWithEmailAndPassword(name, email, password);

    FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    log("${FirebaseAuth.instance.currentUser!.displayName} ${FirebaseAuth.instance.currentUser!.email} ${FirebaseAuth.instance.currentUser!.uid}");
    await FireStoreCollections.addUserData(UserModel(
      name: name,
      email: email,
      phoneNumber: "",
      uid: FirebaseAuth.instance.currentUser!.uid,
      lastLogin: DateTime.now(),
      streakcount: 0,
      highestStreak: 0,
    ));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
    await FirebaseAuth.instance.signOut();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
