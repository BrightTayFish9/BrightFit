import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/widgets/name_entry_widget.dart';
import 'package:bright_fit/widgets/rep_max_widget.dart';
import 'package:flutter/material.dart';

///Allows the user to update personal info, measurements, and pay / log out
class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    Color accent = Singleton().model.color;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SETTINGS',
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline2.fontSize),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: <Widget>[
            NameEntryWidget(),
            Divider(color: accent),
            RepMaxWidget('WEIGHT'),
            Divider(color: accent),
            Text('1 REP MAX', style: TextStyle(color: accent)),
            Builder(builder: (context) => RepMaxWidget('BENCH')),
            RepMaxWidget('SHOULDER PRESS'),
            RepMaxWidget('BICEP CURL'),
            RepMaxWidget('BACK SQUAT'),
            RepMaxWidget('FRONT SQUAT'),
            RepMaxWidget('DEAD LIFT'),
            Divider(color: accent),
            ElevatedButton(
              child: Text(
                "PAYMENT OPTIONS",
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                debugPrint('Payment tapped');
                //TODO: implement payment
              },
            ),
            Divider(color: accent),
            ElevatedButton(
              child: Text(
                "LOG OUT",
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                print('Log out tapped');
                //TODO: implement logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
