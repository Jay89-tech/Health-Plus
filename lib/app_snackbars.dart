import 'package:flutter/material.dart';

class AppSnackbars {
  void redSnackbar(String text, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void greenSnackbar(String text, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
