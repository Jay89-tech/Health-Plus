import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Models/appointment.dart';

class AppointmentServices with ChangeNotifier {
  List<Appointment> _userAppointments = [];
  List<Appointment> get userAppointments => _userAppointments;

  List<Appointment> _allAppointments = [];
  List<Appointment> get allAppointments => _allAppointments;

  int? _viewAppointment;
  int? get appointmentClicked => _viewAppointment;

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _loadingText = "";
  String get loadingText => _loadingText;

  Future<String> saveAppointment(Appointment appointment) async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'Saving appointment...';
    notifyListeners();

    try {
      await db
          .collection("Appointments")
          .add(appointment.toFirestore())
          .then((value) async {
        await db.collection("Appointments").doc(value.id).update({
          'AppointmentId': value.id,
        });
      });
    } catch (error) {
      progress = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return progress;
  }

  Future<String> deleteAppointment(String appointmentId) async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'Deleting Appointment';
    notifyListeners();
    try {
      db.collection("Appointments").doc(appointmentId).delete();
    } catch (error) {
      progress = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return progress;
  }

  Future<String> getUserAppointments(String userId) async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'Getting your appointments...';
    notifyListeners();

    try {
      await db
          .collection("Appointments")
          .where("UserId", isEqualTo: userId)
          .get()
          .then((value) {
        _userAppointments = [];
        for (var appointment in value.docs) {
          _userAppointments.add(
            Appointment.fromFirestore(appointment, null),
          );
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

  Future<String> fetchAppointments() async {
    String progress = 'Success';
    _isLoading = true;
    _loadingText = 'Getting appointments...';
    notifyListeners();

    try {
      await db.collection("Appointments").get().then((value) {
        _allAppointments = [];
        for (var appointment in value.docs) {
          _allAppointments.add(
            Appointment.fromFirestore(appointment, null),
          );
        }
      });
      db.collection("Appointments").snapshots().listen((event) {
        _allAppointments = [];
        for (var appointment in event.docs) {
          _allAppointments.add(
            Appointment.fromFirestore(appointment, null),
          );
        }
        notifyListeners();
      });
    } catch (error) {
      progress = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return progress;
  }

  int viewAppointment(int index) {
    _viewAppointment = index;
    notifyListeners();
    return index;
  }
}
