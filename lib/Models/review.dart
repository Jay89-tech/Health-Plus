import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String? reviewId;
  final String hospital;
  final String feedback;
  final String appointmentId;

  Review({
    required this.appointmentId,
    this.reviewId,
    required this.hospital,
    required this.feedback,
  });

  factory Review.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Review(
      appointmentId: data!['AppointmentId'],
      reviewId: data['ReviewId'],
      hospital: data['Hospital'],
      feedback: data['Feedback'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'AppointmentId': appointmentId,
      'Hospital': hospital,
      'Feedback': feedback,
    };
  }
}
