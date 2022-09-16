import 'package:bright_fit/widgets/chart_widget.dart';
import 'package:flutter/material.dart';

///Displays the user's progress in various measurements
class Progress extends StatefulWidget {
  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [
        ChartWidget('WEIGHT'),
        ChartWidget('BENCH'),
        ChartWidget('SHOULDER PRESS'),
        ChartWidget('BICEP CURL'),
        ChartWidget('BACK SQUAT'),
        ChartWidget('FRONT SQUAT'),
        ChartWidget('DEAD LIFT'),
      ]),
    );
  }
}
