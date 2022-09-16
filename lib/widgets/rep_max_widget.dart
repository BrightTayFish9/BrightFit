import 'dart:convert';

import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/controllers/snackbar_controller.dart';
import 'package:bright_fit/models/progress_series.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///Displays and updates measurements in the Profile Settings page
class RepMaxWidget extends StatefulWidget {
  final String title;

  RepMaxWidget(this.title);

  @override
  _RepMaxWidgetState createState() => _RepMaxWidgetState();
}

class _RepMaxWidgetState extends State<RepMaxWidget> {
  int max = 0;

  @override
  Widget build(BuildContext context) {
    String initValue = Singleton().cachedProgress[widget.title].length == 0
        ? "xxx"
        : Singleton().cachedProgress[widget.title].last.value.toString();
    TextEditingController controller = TextEditingController(text: initValue);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(fontSize: 30),
        ),
        Container(
          width: 100,
          child: TextField(
            controller: controller,
            onSubmitted: (String entry) {
              setState(() {
                int count = int.tryParse(entry);
                if (count == null || count <= 0) {
                  debugPrint('Error parsing value');
                  SnackBarController.show(
                      'Error: invalid ${widget.title} value', context, 3);
                  controller.text = max.toString();
                } else {
                  //TODO: update user's max value
                  SnackBarController.show(
                      'New max ${widget.title}: $count lbs', context, 3);
                  max = count;
                  controller.text = max.toString();

                  http.post(
                      'https://brightontaylorfitness.com/wp-json/bf/v1/post_progress',
                      body: jsonEncode(<String, dynamic>{
                        'userid': Singleton().user.id,
                        'measurement': widget.title,
                        'value': max
                      }));

                  //TODO: figure out why it sometimes goes behind???
                  print(DateTime.now().toUtc());
                  print(DateTime.now());
                  Singleton().cachedProgress[widget.title].add(
                      ProgressSeries(time: DateTime.now().toUtc(), value: max));
                }
              });
            },
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Singleton().model.color)),
                suffix: Text(
                  'lbs',
                  style: TextStyle(color: Singleton().model.color),
                ),
                hintText: '$max'),
            cursorColor: Singleton().model.color,
            style: TextStyle(fontSize: 30, color: Singleton().model.color),
            keyboardType: TextInputType.numberWithOptions(decimal: false),
          ),
        )
      ],
    );
  }
}
