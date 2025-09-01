// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Services/appointment_services.dart';
import 'package:health_plus/Services/auth_services.dart';
import 'package:health_plus/Services/bottom_navbar_services.dart';
import 'package:health_plus/Services/user_services.dart';
import 'package:health_plus/Views/admin_panel.dart';
import 'package:health_plus/Views/appointments.dart';
import 'package:health_plus/Views/home.dart';
import 'package:health_plus/Views/loading.dart';
import 'package:health_plus/Views/profile.dart';
import 'package:health_plus/helpers/authentication_helper.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  final _views = [
    const Home(),
    const Appointments(),
    const Profile(),
    const AdminPanel(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Selector<BottomNavBarServices, int>(
        selector: (p0, p1) => p1.pageView,
        builder: (context, view, child) {
          return BottomNavigationBar(
            currentIndex: view,
            onTap: (value) async {
              if (value == 1) {
                await context.read<AppointmentServices>().getUserAppointments(
                    FirebaseAuth.instance.currentUser!.uid);
                context.read<BottomNavBarServices>().setIndex(value);
              } else if (value == 2 || value == 0) {
                context.read<BottomNavBarServices>().setIndex(value);
              } else if (value == 3 &&
                  context.read<UserServices>().user!.role == 'Administrator') {
                await context.read<AppointmentServices>().fetchAppointments();
                context.read<BottomNavBarServices>().setIndex(value);
              } else if (value == 4) {
                context.read<BottomNavBarServices>().setIndex(0);
                logoutUserinUI(context: context);
              } else if (value == 3 &&
                  context.read<UserServices>().user!.role != 'Administrator') {
                context.read<BottomNavBarServices>().setIndex(0);
                logoutUserinUI(context: context);
              }
            },
            elevation: 100,
            selectedFontSize: MediaQuery.of(context).size.width / 32,
            unselectedFontSize: MediaQuery.of(context).size.width / 35,
            type: BottomNavigationBarType.fixed,
            items: context.read<UserServices>().user!.role == 'Administrator'
                ? List.from(
                    [
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home'),
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.airplane_ticket),
                          label: 'Appointments'),
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.person_4), label: 'Profile'),

                      const BottomNavigationBarItem(
                          icon: Icon(Icons.settings), label: 'Admin Panel'),
                      // },
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.logout), label: 'Logout'),
                    ],
                  )
                : List.from(
                    [
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.abc), label: 'Home'),
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.abc), label: 'Appointments'),
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.abc), label: 'Profile'),
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.abc), label: 'Logout'),
                    ],
                  ),
          );
        },
      ),
      body: Selector<BottomNavBarServices, int>(
          selector: (p0, p1) => p1.pageView,
          builder: (context, value, child) {
            return Stack(
              children: [
                _views[context.read<BottomNavBarServices>().pageView],
                Selector<AuthServices, Tuple2>(
                  selector: (context, value) =>
                      Tuple2(value.isLoading, value.loadingText),
                  builder: (context, value, child) {
                    return value.item1
                        ? Loading(text: "${value.item2}")
                        : Container();
                  },
                ),
                Selector<UserServices, Tuple2>(
                  selector: (context, value) =>
                      Tuple2(value.isLoading, value.loadingText),
                  builder: (context, value, child) {
                    return value.item1
                        ? Loading(text: "${value.item2}")
                        : Container();
                  },
                ),
                Selector<AppointmentServices, Tuple2>(
                  selector: (context, value) =>
                      Tuple2(value.isLoading, value.loadingText),
                  builder: (context, value, child) {
                    return value.item1
                        ? Loading(text: "${value.item2}")
                        : Container();
                  },
                ),
                Selector<UserServices, Tuple2>(
                  selector: (context, value) =>
                      Tuple2(value.isLoading, value.loadingText),
                  builder: (context, value, child) {
                    return value.item1
                        ? Loading(text: "${value.item2}")
                        : Container();
                  },
                ),
              ],
            );
          }),
    );
  }
}
