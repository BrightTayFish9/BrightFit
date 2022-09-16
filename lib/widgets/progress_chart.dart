import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/models/progress_series.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

///Wrapper class containing the TimeSeriesChart for Progress page
class ProgressChart extends StatefulWidget {
  final List<ProgressSeries> data;
  final String title;

  ProgressChart(this.data, this.title);

  @override
  _ProgressChartState createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<ProgressSeries, DateTime>> series = [
      charts.Series(
        id: widget.title.toUpperCase(),
        data: widget.data,
        domainFn: (ProgressSeries series, _) => series.time,
        measureFn: (ProgressSeries series, _) => series.value,
        colorFn: (ProgressSeries series, _) =>
            charts.ColorUtil.fromDartColor(Singleton().model.color),
      )
    ];
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 20 / 100,
      child: charts.TimeSeriesChart(
        series,
        animate: false,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        domainAxis: charts.DateTimeAxisSpec(
            renderSpec: charts.SmallTickRendererSpec(
                labelStyle: charts.TextStyleSpec(
                    fontSize: 20, color: charts.MaterialPalette.black),
                lineStyle:
                    charts.LineStyleSpec(color: charts.MaterialPalette.black))),
        primaryMeasureAxis: charts.NumericAxisSpec(
            renderSpec: charts.SmallTickRendererSpec(
                labelStyle: charts.TextStyleSpec(
                    fontSize: 20, // size in Pts.
                    color: charts.MaterialPalette.black),
                lineStyle:
                    charts.LineStyleSpec(color: charts.MaterialPalette.black))),
      ),
    );
  }
}
