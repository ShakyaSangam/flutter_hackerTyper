import 'package:flutter/material.dart';

class Dialogs {
  void getDialogs(BuildContext context) {
    showDialog(
        context: context,
        child: AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.5),
          title: Center(
            child: Text(
              "Access Granted",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ));
  }
}
