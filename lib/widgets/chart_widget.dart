import 'dart:convert';

import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/models/progress_series.dart';
import 'package:bright_fit/widgets/progress_chart.dart';
import 'package:bright_fit/widgets/small_weighter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///Contains the ProgressChart, displays title / current max, updates max
class ChartWidget extends StatefulWidget {
  final String measurement;
  bool emptyResponse = false;

  ChartWidget(this.measurement);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  @override
  void initState() {
    super.initState();
    if (Singleton().cachedProgress[widget.measurement].length == 0) {
      _fetchProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    var progress = Singleton().cachedProgress[widget.measurement];
    Size size = MediaQuery.of(context).size;
    bool populated = progress.length != 0;

    return Container(
      height: size.height * 35 / 100,
      width: size.width,
      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Card(
        elevation: 8.0,
        margin: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    widget.measurement.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.edit, size: 40, color: Colors.grey.shade600,),
                  Container(
                    height: 30,
                    width: 50,
                    child: TextField(
                      style: TextStyle(fontSize: 30),
                      controller: TextEditingController(),
                      decoration: InputDecoration(hintText: 'EDIT'),
                      keyboardType: TextInputType.numberWithOptions(),
                      onSubmitted: updateMax,
                    ),
                  )
                ],
              ),
            ),
            !populated
                ? widget.emptyResponse ? Container() : SmallWeighter()
                : ProgressChart(progress, widget.measurement),
            Text(!populated
                ? widget.emptyResponse
                    ? 'NO ${widget.measurement} MEASUREMENTS'
                    : ''
                : 'CURRENT MAX: ${progress.last.value.toString()}lbs')
          ],
        ),
      ),
    );
  }

  ///Get previous measurements
  Future _fetchProgress() async {
    var response = await http
        .get('https://brightontaylorfitness.com/wp-json/bf/v1/get_progress'
            '?userid=${Singleton().user.id}'
            '&measurement="${widget.measurement}"');
    var progress = (json.decode(response.body) as List)
        .map((e) => ProgressSeries.fromJson(e))
        .toList();
    if (progress.length == 0) {
      setState(() {
        widget.emptyResponse = true;
      });
    } else {
      setState(() {
        progress.sort((a, b) => a.time.compareTo(b.time));
        Singleton().cachedProgress[widget.measurement] = progress;
      });
    }
  }

  ///Send request to the backend to update the given measurement
  void updateMax(String value) {
    int max = int.parse(value);
    print('updated to $max');
    setState(() {
      Singleton()
          .cachedProgress[widget.measurement]
          .add(ProgressSeries(time: DateTime.now(), value: max));
    });

    http.post('https://brightontaylorfitness.com/wp-json/bf/v1/post_progress',
        body: jsonEncode(<String, dynamic>{
          'userid': Singleton().user.id,
          'measurement': widget.measurement,
          'value': max
        }));
  }
}
