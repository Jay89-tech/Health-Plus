import 'package:flutter/material.dart';
import 'package:health_plus/Services/auth_services.dart';
import 'package:health_plus/Views/loading.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/helpers/authentication_helper.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
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
            child: Container(
              margin: const EdgeInsets.all(35),
              child: Column(
                children: [
                  const Text(
                    "Forgotten password?",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text("Enter your email to reset password"),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _usernameController,
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
                            prefixIcon: const Icon(Icons.mail),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fixedSize: const Size(300, 50),
                            foregroundColor: const Color(0xFFFFFFFF),
                            backgroundColor: AppColors().blueDark,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              resetPasswordinUI(
                                  context: context,
                                  email: _usernameController.text.trim());
                            }
                          },
                          child: const Text("Reset Password"),
                        ),
                      ],
                    ),
                  ),
                ],
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
        ],
      ),
    );
  }
}
