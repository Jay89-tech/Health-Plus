import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Models/review.dart';

class ReviewServices with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Review? _userReview;
  Review? get userReview => _userReview;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _loadingText = "";
  String get loadingText => _loadingText;
  int? _viewReview;
  int? get appointmentClicked => _viewReview;

  int viewReview(int index) {
    _viewReview = index;
    notifyListeners();
    return index;
  }

  Future<String> deleteReview(String reviewId) async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'Deleting review';
    notifyListeners();
    try {
      await db.collection("Reviews").doc(reviewId).delete();
    } catch (error) {
      progress = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return progress;
  }

  Future<String> getUserReview(String appointmentId) async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'loading...';
    notifyListeners();

    try {
      await db
          .collection("Reviews")
          .where("AppointmentId", isEqualTo: appointmentId)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          _userReview = null;
        } else {
          _userReview = Review.fromFirestore(value.docs.first, null);
        }
      });
    } catch (error) {
      progress = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return progress;
  }

  Future<String> saveReview(Review review) async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'Saving review..';
    notifyListeners();
    try {
      await db
          .collection("Reviews")
          .add(
            review.toFirestore(),
          )
          .then((value) {
        db.collection("Reviews").doc(value.id).update({'ReviewId': value.id});
      });
    } catch (error) {
      progress = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return progress;
  }
}
