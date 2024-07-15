//import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_flutter_module/ui/utils/theme/app_colors.dart';

class AppToast {
  static void showToast(String message,
      {Toast toastLength = Toast.LENGTH_SHORT,
      ToastGravity? gravity = ToastGravity.CENTER,
      Color? backgroundColor = Colors.red,
      Color? textColor = Colors.white,
      double? fontSize = 16.0}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }

  static void showSnackBar(String message, ScaffoldMessengerState state,
      {Color? backgroundColor = AppColors.primary, Color? textColor = Colors.white, double? fontSize = 16.0}) {
    var snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: TextStyle(color: textColor, fontSize: fontSize),
        textAlign: TextAlign.center,
      ),
      // behavior: SnackBarBehavior.floating,
      // margin: const EdgeInsets.only(bottom: 0, left: 30, right: 30),
    );
    state.showSnackBar(snackBar);
  }

  static void showOk(String message, BuildContext? context) async {
    /*final result = await showOkAlertDialog(
      context: context!,
      message: message,
      okLabel: "ok",
    );*/
    // Create button
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context!).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
