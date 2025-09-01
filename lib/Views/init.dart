import 'package:flutter/material.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/init_app.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    InitializeApp.initializeApp(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().blueDark,
    );
  }
}
