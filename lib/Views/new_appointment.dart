// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Models/appointment.dart';
import 'package:health_plus/Services/appointment_services.dart';
import 'package:health_plus/Services/user_services.dart';
import 'package:health_plus/Views/loading.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_snackbars.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment({super.key});

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  TimeOfDay? time;
  DateTime? date;
  final GlobalKey<FormState> _appointmentkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().blueDark,
        title: const Text("New Appointment"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _appointmentkey,
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: const Size(100, 40),
                          foregroundColor: const Color(0xFFFFFFFF),
                          backgroundColor: AppColors().blueDark,
                        ),
                        onPressed: () async {
                          time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          setState(() {
                            _timeController.text = time != null
                                ? "${time!.hour}:${time!.minute}"
                                : "";
                          });
                        },
                        child: const Text("Set time"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Appointment Time:'),
                          time != null
                              ? Text('${time!.hour}:${time!.minute}')
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: const Size(100, 40),
                          foregroundColor: const Color(0xFFFFFFFF),
                          backgroundColor: AppColors().blueDark,
                        ),
                        onPressed: () async {
                          date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2024, 12),
                          );
                          setState(() {
                            _dateController.text = date != null
                                ? "${date!.month}/${date!.day}/${date!.year}"
                                : "";
                          });
                        },
                        child: const Text("Set date"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Appointment Date:'),
                          date != null
                              ? Text(
                                  '${date!.day}/${date!.month}/${date!.year}')
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        controller: _reasonController,
                        validator: (name) {
                          if (name!.isEmpty) {
                            return 'Please enter your reason';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Reason",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: AppColors().blueDark.withOpacity(0.1),
                          filled: true,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
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
                        onPressed: () async {
                          if (_appointmentkey.currentState!.validate()) {
                            if (date == null || time == null) {
                              AppSnackbars().redSnackbar(
                                'Please provide Appoinment Date/Time',
                                context,
                              );
                            } else {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Appointment newAppointment = Appointment(
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                time: Timestamp.fromDate(
                                  DateTime(
                                    date!.year,
                                    date!.month,
                                    date!.day,
                                    time!.hour,
                                    time!.minute,
                                  ),
                                ),
                                reason: _reasonController.text.trim(),
                              );
                              String progress = await context
                                  .read<AppointmentServices>()
                                  .saveAppointment(newAppointment);
                              if (progress == 'Success') {
                                await context
                                    .read<AppointmentServices>()
                                    .getUserAppointments(
                                        FirebaseAuth.instance.currentUser!.uid);
                                Navigator.of(context).pop();
                                AppSnackbars().greenSnackbar(
                                    "${context.read<UserServices>().user!.firstName}, your appointment has been scheduled",
                                    context);
                              }
                            }
                          }
                        },
                        child: const Text("Set Appointment"),
                      ),
                    ],
                  )),
            ),
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
        ],
      ),
    );
  }
}
