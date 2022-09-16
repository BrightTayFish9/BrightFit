import 'package:bright_fit/models/exercise_model.dart';
import 'package:bright_fit/views/quick_video.dart';
import 'package:flutter/material.dart';

///Shows video and description of selected exercise
class ExerciseView extends StatelessWidget {
  final ExerciseModel _model;

  ExerciseView(this._model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _model.title.toUpperCase(),
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline2.fontSize),
        ),
      ),
      body: ListView(
        children: <Widget>[
          QuickVideo(_model.link, true),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Text(_model.description.toUpperCase())),
          )
        ],
      ),
    );
  }
}
