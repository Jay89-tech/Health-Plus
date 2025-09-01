import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? userId;
  final String firstName;
  final String surname;
  final String idNumber;
  final String emailaddress;
  final Timestamp dateOfBirth;
  final String contactNumber;
  final String role;

  User({
    this.userId,
    required this.firstName,
    required this.surname,
    required this.idNumber,
    required this.emailaddress,
    required this.dateOfBirth,
    required this.contactNumber,
    required this.role,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      userId: data!['UserId'],
      firstName: data['FirstName'],
      surname: data['Surname'],
      idNumber: data['IdNumber'],
      emailaddress: data['EmailAddress'],
      dateOfBirth: data['DateOfBirth'],
      contactNumber: data['ContactNumber'],
      role: data['Role'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'FirstName': firstName,
      'Surname': surname,
      'IdNumber': idNumber,
      'EmailAddress': emailaddress,
      'DateOfBirth': dateOfBirth,
      'ContactNumber': contactNumber,
      'Role': role,
    };
  }
}
