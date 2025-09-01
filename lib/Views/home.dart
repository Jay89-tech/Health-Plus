import 'package:flutter/material.dart';
import 'package:health_plus/Services/user_services.dart';
import 'package:health_plus/app_colors.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().blueDark,
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Welcome ${context.read<UserServices>().user!.firstName}"),
            const Text("Welcome to Hospital Management"),
            Stack(
              children: [
                Image.asset("assets/welcome.jpg"),
              ],
            ),
            const Card(
              child: SizedBox(
                height: 140,
                child: Center(
                  child: ListTile(
                    subtitle: Text(
                        "Navigate to Appointments page to schedule an appointment"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
