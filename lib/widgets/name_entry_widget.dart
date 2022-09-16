import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/controllers/snackbar_controller.dart';
import 'package:flutter/material.dart';

class NameEntryWidget extends StatefulWidget {
  @override
  _NameEntryWidgetState createState() => _NameEntryWidgetState();
}

class _NameEntryWidgetState extends State<NameEntryWidget> {
  @override
  Widget build(BuildContext context) {
    Color accent = Singleton().model.color;
    var controller = TextEditingController();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'NAME',
          style: TextStyle(color: accent),
        ),
        Container(
          width: 200,
          child: TextField(
            cursorColor: accent,
            style: TextStyle(fontSize: 35),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Singleton().model.color)),
              hintText: Singleton().user.name,
            ),
            controller: controller,
            onChanged: (value) {
              controller.value = TextEditingValue(
                  text: value.toUpperCase(), selection: controller.selection);
            },
            onSubmitted: (String value) {
              //TODO: actually update username in WordPress
              Singleton().user.name = value;
              SnackBarController.show('Name changed to $value', context, 3);
            },
          ),
        )
      ],
    );
  }
}
