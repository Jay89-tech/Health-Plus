import 'package:flutter/material.dart';
import 'package:health_plus/Services/auth_services.dart';
import 'package:health_plus/Services/user_services.dart';
import 'package:health_plus/Views/loading.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/helpers/authentication_helper.dart';
import 'package:health_plus/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().blueDark,
        title: const Text("Hospital Management"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(35),
              child: Column(
                children: [
                  Image.asset("assets/Health_Logo.png"),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text("Enter your credentials to login"),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _usernameController,
                          validator: (username) {
                            if (username!.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Username",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none),
                              fillColor: AppColors().blueDark.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.person)),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          validator: (password) {
                            if (password!.isEmpty) {
                              return 'Password is required';
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
                          ),
                          obscureText: true,
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
                              loginUserinUI(
                                context: context,
                                email: _usernameController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                          },
                          child: const Text("Log in"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "If you don't have an account register below.",
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors().blueDark,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RoutesGenerator.registerPage);
                    },
                    child: const Text("Register here"),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Forgot Password??",
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors().blueDark,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RoutesGenerator.passwordResetPage);
                        },
                        child: const Text("Reset Password"),
                      ),
                    ],
                  )
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
