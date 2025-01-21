// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  static Future<void> logIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw Exception("no user found for given email");
      } else if (e.code == "user-disabled") {
        throw Exception("user disabled for given email");
      } else if (e.code == "wrong-password") {
        throw Exception("wrong password provided for given email");
      } else {
        throw Exception("some problem occured, with error: $e");
      }
    }
  }

  static Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        throw Exception("password provided is too weak");
      } else if (e.code == "email-already-in-use") {
        throw Exception("the account already exists for given email");
      } else {
        throw Exception("some problem occured, with error: $e");
      }
    }
  }

  static Future<void> sendResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception("some problem occured, with error: $e");
    }
  }
}
