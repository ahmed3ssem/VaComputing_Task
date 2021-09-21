import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToastMessage{

  static void showSnackBar(String message , BuildContext context , Duration duration){
    final snackBar = SnackBar(
      content: Text(message),
      duration: duration,
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}