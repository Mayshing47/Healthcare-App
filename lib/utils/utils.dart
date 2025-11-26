import 'package:flutter/material.dart';
import 'package:health_care_application/main.dart';
import 'package:intl/intl.dart';

class Utils {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static void showSnackBar(String? message) {
    if (message == null) return;

    final snackBar = SnackBar(content: Text(message));

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showCircularProgressIndicator(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return Center(child: CircularProgressIndicator(),);
    });
  }


  static String getFormattedDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}
