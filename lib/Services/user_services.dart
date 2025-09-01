import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Models/user.dart';

class UserServices with ChangeNotifier {
  User? _user;
  User? get user => _user;

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _loadingText = "";
  String get loadingText => _loadingText;

  Stream<DocumentSnapshot<Map<String, dynamic>>> userStreamer(String id) {
    return FirebaseFirestore.instance.collection('Users').doc(id).snapshots();
  }

  Future<String> fetchUserData(String userId) async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'Please wait....';
    notifyListeners();
    try {
      await db.collection("Users").doc(userId).get().then((user) {
        _user = User.fromFirestore(user, null);
      });
    } catch (e) {
      progress = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return progress;
  }
}
