// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:health_plus/Models/user.dart';
import 'package:health_plus/Services/auth_services.dart';
import 'package:health_plus/Services/user_services.dart';
import 'package:health_plus/app_snackbars.dart';
import 'package:health_plus/route_manager.dart';
import 'package:provider/provider.dart';

void loginUserinUI({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  String progress = await context.read<AuthServices>().login(password, email);
  if (progress == 'Success') {
    String progress = await context.read<UserServices>().fetchUserData(
          context.read<AuthServices>().currentUser!.uid,
        );
    if (progress == 'Success') {
      Navigator.of(context).popAndPushNamed(RoutesGenerator.homePage);
      AppSnackbars().greenSnackbar("Welcome", context);
    } else {
      AppSnackbars().redSnackbar(progress, context);
    }
  } else {
    AppSnackbars().redSnackbar(progress, context);
  }
}

void resetPasswordinUI({
  required BuildContext context,
  required String email,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  String progress =
      await context.read<AuthServices>().sendPasswordResetEmail(email);
  if (progress == 'Success') {
    AppSnackbars()
        .greenSnackbar("Password reset sent to the email provided", context);
  } else {
    AppSnackbars().redSnackbar(progress, context);
  }
}

void logoutUserinUI({
  required BuildContext context,
}) async {
  String progress = await context.read<AuthServices>().logoutUser();

  if (progress == 'Success') {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesGenerator.loginPage, (route) => false);
  } else {
    AppSnackbars().redSnackbar(progress, context);
  }
}

void registerUserinUI(
    {required BuildContext context,
    required String password,
    required User registerUser}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  String progress = await context.read<AuthServices>().register(
        password,
        registerUser,
      );
  if (progress == 'Success') {
    String progress = await context.read<UserServices>().fetchUserData(
          context.read<AuthServices>().currentUser!.uid,
        );
    if (progress == 'Success') {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(RoutesGenerator.homePage, (route) => false);
      AppSnackbars().greenSnackbar("Welcome", context);
    } else {}
  } else {
    AppSnackbars().redSnackbar(progress, context);
  }
}
