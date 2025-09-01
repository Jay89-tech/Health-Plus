// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:health_plus/Models/appointment.dart';
import 'package:health_plus/Services/appointment_services.dart';
import 'package:health_plus/Services/review_services.dart';
import 'package:health_plus/Views/loading.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().blueDark,
        title: const Text("Admin Panel"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Selector<AppointmentServices, List<Appointment>>(
            selector: (p0, p1) => p1.allAppointments,
            builder: (context, appointments, child) {
              return appointments.isEmpty
                  ? Center(
                      child: Image.asset("assets/no_data.png"),
                    )
                  : ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) => Card(
                        child: SizedBox(
                          height: 200,
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                context
                                    .read<AppointmentServices>()
                                    .viewAppointment(index);
                                await context
                                    .read<ReviewServices>()
                                    .getUserReview(
                                        appointments[index].appointmentId!);

                                Navigator.of(context).pushNamed(
                                    RoutesGenerator.adminAppointmentViewPage);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "${appointments[index].time.toDate().day}/${appointments[index].time.toDate().month}/${appointments[index].time.toDate().year}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Icon(Icons.calendar_month)
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "${appointments[index].time.toDate().hour}:${appointments[index].time.toDate().minute}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Icon(Icons.timelapse)
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      indent: 40,
                                      endIndent: 40,
                                      thickness: 2,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      appointments[index].reason.length > 11
                                          ? "${appointments[index].reason.substring(0, 10)}....."
                                          : appointments[index].reason,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
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
          Selector<ReviewServices, Tuple2>(
            selector: (context, value) =>
                Tuple2(value.isLoading, value.loadingText),
            builder: (context, value, child) {
              return value.item1
                  ? Loading(text: "${value.item2}")
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
