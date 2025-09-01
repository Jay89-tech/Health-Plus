import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Models/user.dart' as user;

class AuthServices with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  User? _currentUser;
  User? get currentUser => _currentUser;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _loadingText = "";
  String get loadingText => _loadingText;

  Future<String> register(
    String password,
    user.User newUser,
  ) async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'Registering...Please wait';
    notifyListeners();
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: newUser.emailaddress,
        password: password,
      )
          .then((value) async {
        _currentUser = value.user;
        await db
            .collection("Users")
            .doc(_currentUser!.uid)
            .set(newUser.toFirestore())
            .then((value) async {
          await db
              .collection("Users")
              .doc(_currentUser!.uid)
              .update({"UserId": _currentUser!.uid});
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        progress = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        progress = 'The account already exists for that email.';
      }
    } catch (e) {
      progress = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return progress;
  }

  Future<String> login(String password, String email) async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'Logging you in...Please wait';
    notifyListeners();
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _currentUser = value.user;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        progress = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        progress = 'Wrong password provided for that user.';
      } else {
        progress = e.message.toString();
      }
    } catch (e) {
      progress = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return progress;
  }

  Future<String> sendPasswordResetEmail(String email) async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'Sending email....';
    notifyListeners();
    try {
      await auth
          .sendPasswordResetEmail(email: email)
          .onError((error, stackTrace) {
        progress = error.toString();
      });
    } on FirebaseAuthException catch (error) {
      progress = error.message.toString();
    } catch (error) {
      progress = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return progress;
  }

  Future<String> logoutUser() async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'Logging you out...Please wait';
    notifyListeners();
    try {
      await auth.signOut();
      _currentUser = null;
    } catch (e) {
      progress = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return progress;
  }
}
