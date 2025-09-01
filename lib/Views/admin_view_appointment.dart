// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:health_plus/Models/appointment.dart';
import 'package:health_plus/Services/appointment_services.dart';
import 'package:health_plus/Services/review_services.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_snackbars.dart';
import 'package:provider/provider.dart';

class AdminAppointmentView extends StatefulWidget {
  const AdminAppointmentView({super.key});

  @override
  State<AdminAppointmentView> createState() => _AdminAppointmentViewState();
}

class _AdminAppointmentViewState extends State<AdminAppointmentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().blueDark,
        title: const Text("Health Plus"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
            top: 25,
          ),
          child: Selector<AppointmentServices, Appointment>(
            selector: (p0, p1) => p1.allAppointments[
                context.read<AppointmentServices>().appointmentClicked!],
            builder: (context, appointment, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Text("Appointment Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        thickness: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Time:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              appointment.time.toDate().hour > 11
                                  ? "${appointment.time.toDate().hour}:${appointment.time.toDate().minute} PM"
                                  : "${appointment.time.toDate().hour}:${appointment.time.toDate().minute} AM",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16)),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Date:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              "${appointment.time.toDate().day}/${appointment.time.toDate().month}/${appointment.time.toDate().year}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Reason for visit:",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(appointment.reason,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14)),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Review Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        thickness: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Hospital",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.read<ReviewServices>().userReview == null
                              ? "Not provided"
                              : context
                                  .read<ReviewServices>()
                                  .userReview!
                                  .hospital),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                          context.read<ReviewServices>().userReview == null
                              ? "Feedback:"
                              : "Feedback:",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.read<ReviewServices>().userReview != null
                              ? context
                                  .read<ReviewServices>()
                                  .userReview!
                                  .feedback
                              : "No feedback provided"),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      context.read<ReviewServices>().userReview == null
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fixedSize: const Size(300, 50),
                                    foregroundColor: const Color(0xFFFFFFFF),
                                    backgroundColor: AppColors().red,
                                  ),
                                  onPressed: () async {
                                    String progress = await context
                                        .read<ReviewServices>()
                                        .deleteReview(context
                                            .read<ReviewServices>()
                                            .userReview!
                                            .reviewId!);
                                    if (progress == 'Success') {
                                      AppSnackbars().greenSnackbar(
                                          "Review has been deleted successfully",
                                          context);
                                    } else {
                                      AppSnackbars()
                                          .redSnackbar(progress, context);
                                    }
                                  },
                                  child: const Text("Delete Review"),
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fixedSize: const Size(300, 50),
                              foregroundColor: const Color(0xFFFFFFFF),
                              backgroundColor: AppColors().red,
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              String progress = await context
                                  .read<AppointmentServices>()
                                  .deleteAppointment(
                                      appointment.appointmentId!);
                              if (progress == 'Success') {
                                AppSnackbars().greenSnackbar(
                                    "The appointment has been deleted successfully",
                                    context);
                              } else {
                                AppSnackbars().redSnackbar(progress, context);
                              }
                            },
                            child: const Text("Delete Appointment"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
