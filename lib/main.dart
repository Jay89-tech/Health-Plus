import 'package:flutter/material.dart';
import 'package:health_plus/Services/appointment_services.dart';
import 'package:health_plus/Services/auth_services.dart';
import 'package:health_plus/Services/bottom_navbar_services.dart';
import 'package:health_plus/Services/review_services.dart';
import 'package:health_plus/Services/user_services.dart';
import 'package:health_plus/route_manager.dart';
import 'package:provider/provider.dart';

void main(context) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavBarServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppointmentServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReviewServices(),
        ),
      ],
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hospital Management',
        initialRoute: RoutesGenerator.initialPage,
        onGenerateRoute: RoutesGenerator.generateRoute,
      ),
    );
  }
}
