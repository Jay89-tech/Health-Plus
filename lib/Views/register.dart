import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Models/user.dart';
import 'package:health_plus/Services/auth_services.dart';
import 'package:health_plus/Services/user_services.dart';
import 'package:health_plus/Views/loading.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/helpers/authentication_helper.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscurePassword = true;
  final TextEditingController _adminFirstnameController =
      TextEditingController();
  final TextEditingController _adminSurnameController = TextEditingController();
  final TextEditingController _adminEmailController = TextEditingController();
  final TextEditingController _adminPasswordController =
      TextEditingController();
  final TextEditingController _adminIdNumberController =
      TextEditingController();
  final TextEditingController _adminDateOfBirthController =
      TextEditingController();
  final TextEditingController _adminContactNumberController =
      TextEditingController();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  bool _patientAccount = false;
  bool _adminAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/Health_Logo.png",
              height: 150,
            ),
          ],
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
                      children: [
                        Text("Register an account", style: TextStyle()),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _registerFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            controller: _adminFirstnameController,
                            validator: (name) {
                              if (name!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "First Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none),
                              fillColor: AppColors().blueDark.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.person_3),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            controller: _adminSurnameController,
                            validator: (surname) {
                              if (surname!.isEmpty) {
                                return 'Please enter your surname';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Surname",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none),
                              fillColor: AppColors().blueDark.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.person_3),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            controller: _adminContactNumberController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your contact number';
                              } else if (value.length < 10) {
                                return 'Please enter valid contact number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Contact Number",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none),
                              fillColor: AppColors().blueDark.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.call),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 13,
                            controller: _adminIdNumberController,
                            validator: (idNumber) {
                              if (idNumber!.isEmpty) {
                                return 'Please enter your id number';
                              } else if (idNumber.length < 13) {
                                return 'Please enter valid id number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "ID Number",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none),
                              fillColor: AppColors().blueDark.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.numbers),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.datetime,
                            controller: _adminDateOfBirthController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your date of birth';
                              } else if (value.length < 10) {
                                return 'Please enter valid date of birth';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Date Of Birth",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none),
                              fillColor: AppColors().blueDark.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.calendar_month),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _adminEmailController,
                            validator: (emailAddress) {
                              if (emailAddress!.isEmpty) {
                                return 'Please enter your email address';
                              } else if (!emailAddress.contains('@')) {
                                return 'Please enter valid email address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Email Address",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none),
                              fillColor: AppColors().blueDark.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _adminPasswordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 8) {
                                return 'Password must must be atleast 8 characters';
                              } else if (!value.contains('@')) {
                                return 'Password must must have @ sign';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none),
                              fillColor: AppColors().blueDark.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.password),
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 18,
                                ),
                              ),
                            ),
                            obscureText: _obscurePassword,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Account Type??"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Patient"),
                              Checkbox(
                                value: _patientAccount,
                                onChanged: (value) {
                                  setState(() {
                                    _patientAccount = !_patientAccount;
                                    _adminAccount = !_patientAccount;
                                  });
                                },
                              ),
                              const Text("Administrator"),
                              Checkbox(
                                value: _adminAccount,
                                onChanged: (value) {
                                  setState(() {
                                    _adminAccount = !_adminAccount;
                                    _patientAccount = !_adminAccount;
                                  });
                                },
                              ),
                            ],
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
                              if (_registerFormKey.currentState!.validate()) {
                                User registerUser = User(
                                  firstName:
                                      _adminFirstnameController.text.trim(),
                                  surname: _adminSurnameController.text.trim(),
                                  idNumber:
                                      _adminIdNumberController.text.trim(),
                                  emailaddress:
                                      _adminEmailController.text.trim(),
                                  dateOfBirth: Timestamp.fromDate(
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
                                  contactNumber:
                                      _adminContactNumberController.text.trim(),
                                  role: _adminAccount == true
                                      ? 'Administrator'
                                      : 'Patient',
                                );
                                registerUserinUI(
                                  context: context,
                                  password:
                                      _adminPasswordController.text.trim(),
                                  registerUser: registerUser,
                                );
                              }
                            },
                            child: const Text("Register"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
        ],
      ),
    );
  }
}
