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
      if (e.code == "invalid-credential") {
        throw Exception("credential given is incorrect");
      } else {
        throw Exception("some problem occured, with error: ${e.message}");
      }
    }
  }

  static Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception("some problem occured, with error: ${e.message}");
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
        throw Exception("some problem occured, with error: ${e.message}");
      }
    }
  }

  static Future<void> sendResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception("some problem occured, with error: ${e.message}");
    }
  }
}
