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

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().blueDark,
        title: const Text("My Appointments"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  height: MediaQuery.of(context).size.height / 1.4,
                  child: context
                          .read<AppointmentServices>()
                          .userAppointments
                          .isEmpty
                      ? Image.asset("assets/no_data.png")
                      : Selector<AppointmentServices, List<Appointment>>(
                          selector: (p0, p1) => p1.userAppointments,
                          builder: (context, appointments, child) {
                            return ListView.builder(
                              itemCount: appointments.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: SizedBox(
                                    height: 150,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () async {
                                          context
                                              .read<AppointmentServices>()
                                              .viewAppointment(index);
                                          await context
                                              .read<ReviewServices>()
                                              .getUserReview(appointments[index]
                                                  .appointmentId!);

                                          Navigator.of(context).pushNamed(
                                              RoutesGenerator
                                                  .appointmentViewPage);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "${appointments[index].time.toDate().day}/${appointments[index].time.toDate().month}/${appointments[index].time.toDate().year}",
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const Icon(
                                                          Icons.calendar_month)
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "${appointments[index].time.toDate().hour}:${appointments[index].time.toDate().minute}",
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const Icon(
                                                          Icons.timelapse)
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
                                                appointments[index]
                                                            .reason
                                                            .length >
                                                        11
                                                    ? "${appointments[index].reason.substring(0, 10)}....."
                                                    : appointments[index]
                                                        .reason,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: const Size(300, 50),
                  foregroundColor: const Color(0xFFF3F3F3),
                  backgroundColor: AppColors().blueDark,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RoutesGenerator.newAppointmentPage);
                },
                child: const Text("New Appointment"),
              ),
            ],
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
