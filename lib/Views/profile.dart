import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Models/user.dart' as user;
import 'package:health_plus/Services/user_services.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/route_manager.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().blueDark,
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: context
            .read<UserServices>()
            .userStreamer(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          var userData = user.User.fromFirestore(snapshot.data!, null);
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: const Text("Name"),
                  subtitle: Text(userData.firstName),
                ),
                ListTile(
                  title: const Text("Surname"),
                  subtitle: Text(userData.surname),
                ),
                ListTile(
                  title: const Text("Email"),
                  subtitle: Text(userData.emailaddress),
                ),
                ListTile(
                  title: const Text("Id Number"),
                  subtitle: Text(userData.idNumber),
                ),
                ListTile(
                  title: const Text("Contact Number"),
                  subtitle: Text(userData.contactNumber),
                ),
                ListTile(
                  title: const Text("Date of birth"),
                  subtitle: Text(
                      "${userData.dateOfBirth.toDate().day}/${userData.dateOfBirth.toDate().month}/${userData.dateOfBirth.toDate().year}"),
                ),
                ListTile(
                  title: const Text("Account"),
                  subtitle: Text(userData.role),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: const Size(300, 50),
                    foregroundColor: const Color(0xFFFFFFFF),
                    backgroundColor: AppColors().blueDark,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RoutesGenerator.profileEditPage);
                  },
                  child: const Text('Update profile'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
