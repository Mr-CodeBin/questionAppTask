import 'package:firebase_auth/firebase_auth.dart';
import 'package:mcqtest/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user!;

      return UserModel(
        name: user.displayName ?? "",
        email: user.email!,
        phoneNumber: user.phoneNumber ?? "",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  Future<UserModel?> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user!;
      await user.updateDisplayName(name);
      return UserModel(
        name: user.displayName ?? "",
        email: user.email!,
        phoneNumber: user.phoneNumber ?? "",
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(
          (User? user) => user != null
              ? UserModel(
                  name: user.displayName ?? "",
                  email: user.email!,
                  phoneNumber: user.phoneNumber ?? "",
                )
              : null,
        );
  }
}
