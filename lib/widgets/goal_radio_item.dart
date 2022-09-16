import 'package:bright_fit/models/goal_radio_model.dart';
import 'package:flutter/material.dart';

///Displays the various exercise goals a User can have
class GoalRadioItem extends StatelessWidget {
  final GoalRadioModel model;

  GoalRadioItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: Container(
          height: 100,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: !model.isSelected ? Colors.white : model.color,
          ),
          child: Row(
            children: <Widget>[
              IconTheme(
                  data: IconThemeData(
                    size: 60,
                    color: model.isSelected ? Colors.white : model.color,
                  ),
                  child: model.icon),
              Text(
                model.title,
                style: TextStyle(
                  fontSize: 40,
                  color: model.isSelected ? Colors.white : model.color,
                ),
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Text(
                  model.desc,
                  style: TextStyle(
                    fontSize: 23,
                    color: model.isSelected ? Colors.white : Colors.black,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
