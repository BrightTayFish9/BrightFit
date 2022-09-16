import 'package:bright_fit/controllers/snackbar_controller.dart';
import 'package:flutter/material.dart';

///Contains the actual work out portion of the app
class Workout extends StatefulWidget {
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            SnackBarController.show('not even close', context, 3);
          },
          child: Text(
            'Is this page done yet?'.toUpperCase(),
            style: TextStyle(fontSize: 40),
          ),
        ),
      ],
    );
  }
}
