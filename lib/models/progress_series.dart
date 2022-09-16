///Used to contain all progress data for user's measurements
class ProgressSeries {
  final DateTime time;
  final int value;

  ProgressSeries({this.time, this.value});

  factory ProgressSeries.fromJson(Map<String, dynamic> json) {
    return ProgressSeries(
      time: DateTime.parse(json['timestamp']),
      value: int.parse(json['value']),
    );
  }
}
