import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String? appointmentId;
  final String userId;
  final Timestamp time;
  final String reason;

  Appointment({
    required this.userId,
    this.appointmentId,
    required this.time,
    required this.reason,
  });
  factory Appointment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Appointment(
      userId: data!['UserId'],
      appointmentId: data['AppointmentId'],
      time: data['Time'],
      reason: data['Reason'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'UserId': userId,
      'Time': time,
      'Reason': reason,
    };
  }
}
