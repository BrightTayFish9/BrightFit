///HTTP response received after asking for exercises
class ExerciseModel {
  String title;
  String description;
  bool atHome;
  String link;

  ExerciseModel(
      {this.title, this.description, this.atHome, this.link});

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    bool home = json['at_home'] == '1' ? true : false;
    return ExerciseModel(
        title: json['title'],
        description: json['description'],
        atHome: home,
        link: json['link']);
  }
}
