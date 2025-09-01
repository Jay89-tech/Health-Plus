// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Services/user_services.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_snackbars.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _adminFirstnameController =
      TextEditingController();
  final TextEditingController _adminSurnameController = TextEditingController();
  final TextEditingController _adminIdNumberController =
      TextEditingController();
  final TextEditingController _adminDateOfBirthController =
      TextEditingController();
  final TextEditingController _adminContactNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFF2C3847),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [],
        ),
        toolbarHeight: 150,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(
                  35,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          controller: _adminFirstnameController,
                          decoration: InputDecoration(
                            hintText: "First Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: AppColors().blueDark.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.password),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          controller: _adminSurnameController,
                          decoration: InputDecoration(
                            hintText: "Surname",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: AppColors().blueDark.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.password),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          controller: _adminContactNumberController,
                          decoration: InputDecoration(
                            hintText: "Contact Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: AppColors().blueDark.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.password),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 13,
                          controller: _adminIdNumberController,
                          decoration: InputDecoration(
                            hintText: "ID Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: AppColors().blueDark.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.password),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.datetime,
                          controller: _adminDateOfBirthController,
                          decoration: InputDecoration(
                            hintText: "Date Of Birth",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: AppColors().blueDark.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.password),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 30,
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
                            var user = context.read<UserServices>().user!;
                            try {
                              await FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                'FirstName':
                                    _adminFirstnameController.text.isEmpty
                                        ? user.firstName
                                        : _adminFirstnameController.text.trim(),
                                'Surname': _adminSurnameController.text.isEmpty
                                    ? user.surname
                                    : _adminSurnameController.text.trim(),
                                'ContactNumber': _adminContactNumberController
                                        .text.isEmpty
                                    ? user.contactNumber
                                    : _adminContactNumberController.text.trim(),
                                'IdNumber':
                                    _adminIdNumberController.text.isEmpty
                                        ? user.idNumber
                                        : _adminIdNumberController.text.trim(),
                                'DateOfBirth':
                                    _adminDateOfBirthController.text.isEmpty
                                        ? user.dateOfBirth
                                        : Timestamp.fromDate(
                                            DateTime(
                                              int.parse(
                                                _adminDateOfBirthController.text
                                                    .trim()
                                                    .substring(6, 10),
                                              ),
                                              int.parse(
                                                _adminDateOfBirthController.text
                                                    .trim()
                                                    .substring(3, 5),
                                              ),
                                              int.parse(
                                                _adminDateOfBirthController.text
                                                    .trim()
                                                    .substring(0, 2),
                                              ),
                                            ),
                                          ),
                              }).then((value) {
                                Navigator.of(context).pop();
                                AppSnackbars()
                                    .greenSnackbar("Profile Updated", context);
                              });
                            } catch (e) {
                              AppSnackbars().redSnackbar(e.toString(), context);
                            }
                          },
                          child: const Text("Save Changes"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
