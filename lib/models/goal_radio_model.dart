import 'package:flutter/material.dart';

///Represents the exercise goal the user has selected
class GoalRadioModel {
  int index;
  String title;
  String desc;
  bool isSelected;
  final Icon icon;
  Color color;

  GoalRadioModel(this.index, this.title, this.desc, this.isSelected, this.icon,
      this.color);
}
