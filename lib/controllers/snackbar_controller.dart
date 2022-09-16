import 'package:bright_fit/controllers/singleton.dart';
import 'package:flutter/material.dart';

///Used to display a colored SnackBar
class SnackBarController {
  static void show(String msg, BuildContext context, int duration) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Singleton().model.color,
      content: Text(
        msg.toUpperCase(),
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: duration),
    ));
  }
}
