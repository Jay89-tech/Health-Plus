// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Services/user_services.dart';
import 'package:health_plus/firebase_options.dart';
import 'package:health_plus/route_manager.dart';
import 'package:provider/provider.dart';

class InitializeApp {
  static initializeApp(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (context.mounted) {
        if (user == null) {
          Navigator.of(context).popAndPushNamed(RoutesGenerator.loginPage);
        } else {
          String progress = await context.read<UserServices>().fetchUserData(
                user.uid,
              );
          if (progress == 'Success') {
            Navigator.of(context).popAndPushNamed(RoutesGenerator.homePage);
          }
        }
      }
    });
  }
}
