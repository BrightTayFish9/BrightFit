import 'package:bright_fit/models/glossary_radio_model.dart';
import 'package:flutter/material.dart';

///Displays the various muscle groups exercises will be grouped by
class GlossaryRadioWidget extends StatelessWidget {
  final GlossaryRadioModel _model;

  GlossaryRadioWidget(this._model);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: _model.isSelected ? _model.color : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        _model.title,
        style: TextStyle(
            color: _model.isSelected ? Colors.white : Colors.grey.shade700),
      ),
    );
  }
}
