import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/controllers/snackbar_controller.dart';
import 'package:bright_fit/models/goal_model_provider.dart';
import 'package:bright_fit/models/goal_radio_model.dart';
import 'package:flutter/material.dart';
import 'goal_radio_item.dart';

///Updates the User's exercise goal
class GoalSelector extends StatefulWidget {
  @override
  _GoalSelectorState createState() => _GoalSelectorState();
}

class _GoalSelectorState extends State<GoalSelector> {
  List<GoalRadioModel> radioModels = GoalModelProvider.list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: radioModels.length,
      padding: EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (context, index) {
        return buttonInkwell(GoalRadioItem(radioModels[index]));
      },
    );
  }

  InkWell buttonInkwell(GoalRadioItem ri) {
    return InkWell(
      onTap: () {
        setState(() {
          for (GoalRadioModel model in radioModels) model.isSelected = false;
          ri.model.isSelected = true;
          Singleton().model = ri.model;
          SnackBarController.show(
              'Your Current goal: ${ri.model.title}', context, 3);
          //TODO: Update goal in the backend
        });
      },
      child: ri,
    );
  }
}
