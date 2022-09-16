import 'package:flutter/cupertino.dart';

///Represents the various muscle groups that the glossary organizes exercises into
class GlossaryRadioModel {
  String title;
  bool isSelected = false;
  Color color;

  GlossaryRadioModel(this.title, this.color);
}
