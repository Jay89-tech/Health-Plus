// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:health_plus/Models/appointment.dart';
import 'package:health_plus/Models/review.dart';
import 'package:health_plus/Services/appointment_services.dart';
import 'package:health_plus/Services/review_services.dart';
import 'package:health_plus/Services/user_services.dart';
import 'package:health_plus/Views/loading.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_snackbars.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final GlobalKey<FormState> _bookingFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().blueDark,
        title: const Text("Health Plus"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 25,
                top: 25,
              ),
              child: Selector<AppointmentServices, Appointment>(
                selector: (p0, p1) => p1.userAppointments[
                    context.read<AppointmentServices>().appointmentClicked!],
                builder: (context, appointment, child) {
                  return Form(
                    key: _bookingFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        context.read<ReviewServices>().userReview != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(context
                                      .read<ReviewServices>()
                                      .userReview!
                                      .hospital),
                                ],
                              )
                            : TextFormField(
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.text,
                                controller: _hospitalController,
                                validator: (hospital) {
                                  if (hospital!.isEmpty) {
                                    return 'Hospital required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Hospital",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none),
                                  fillColor:
                                      AppColors().blueDark.withOpacity(0.1),
                                  filled: true,
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                context.read<ReviewServices>().userReview ==
                                        null
                                    ? "What is your Feedback:"
                                    : "Feedback:",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        context.read<ReviewServices>().userReview != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(context
                                      .read<ReviewServices>()
                                      .userReview!
                                      .feedback),
                                ],
                              )
                            : TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                maxLength: 100,
                                maxLines: 10,
                                keyboardType: TextInputType.multiline,
                                controller: _feedbackController,
                                validator: (feedback) {
                                  if (feedback!.isEmpty) {
                                    return 'Please provide your feedback';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Feedback",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none),
                                  fillColor:
                                      AppColors().blueDark.withOpacity(0.1),
                                  filled: true,
                                ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        context.read<ReviewServices>().userReview != null
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
                                      backgroundColor: AppColors().blueDark,
                                    ),
                                    onPressed: () async {
                                      if (_bookingFormKey.currentState!
                                          .validate()) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Review newReview = Review(
                                            hospital:
                                                _hospitalController.text.trim(),
                                            feedback:
                                                _feedbackController.text.trim(),
                                            appointmentId:
                                                appointment.appointmentId!);
                                        String progress = await context
                                            .read<ReviewServices>()
                                            .saveReview(
                                              newReview,
                                            );
                                        if (progress == 'Success') {
                                          AppSnackbars().greenSnackbar(
                                              "${context.read<UserServices>().user!.firstName}, your review has been recieved",
                                              context);
                                        } else {
                                          AppSnackbars()
                                              .redSnackbar(progress, context);
                                        }
                                      }
                                    },
                                    child: const Text("Save Review"),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  );
                },
              ),
            ),
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
