import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Utils {
  static toastMassage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 10.0);
  }

  static void flushBarErrorMassage(BuildContext context, String message) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          title: 'Error',
          message: message,
          icon: Icon(
            Icons.error_outline,
            size: 28.0,
            color: Colors.red[300],
          ),
          leftBarIndicatorColor: Colors.red[300],
          duration: const Duration(seconds: 3),
        )..show(context));
  }

  static snackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message.toString()),
      duration: Duration(seconds: 3),
    ));
  }
}
