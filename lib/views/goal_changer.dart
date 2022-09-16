import 'package:bright_fit/widgets/goal_selector.dart';
import 'package:flutter/material.dart';

///Allows the user to update their exercise goal
class GoalChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SELECT GOAL',
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline2.fontSize),
        ),
      ),
      body: GoalSelector(),
    );
  }
}
