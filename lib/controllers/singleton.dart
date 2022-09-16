import 'package:bright_fit/models/exercise_model.dart';
import 'package:bright_fit/models/goal_radio_model.dart';
import 'package:bright_fit/models/post_skel.dart';
import 'package:bright_fit/models/progress_series.dart';
import 'package:bright_fit/presentation/bright_fit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/schemas/user.dart';

///Singleton datacache used to share user information with various parts of the app
class Singleton {
  ///Singleton Structure
  static final Singleton _inst = Singleton._internal();
  Singleton._internal();
  factory Singleton() => _inst;

  ///The logged user
  User user;
  ///The user's saved posts, as well as home page and library posts
  Map<String, List<PostSkel>> cachedPosts = new Map();
  ///Once and exercise has been loaded from the web, it's cached here
  Map<String, List<ExerciseModel>> cachedExercises = new Map();
  ///The user's measurements are cached here
  Map<String, List<ProgressSeries>> cachedProgress = new Map();

  //TODO: get the user's actual goal from the backend, this was hardcoded for testing
  GoalRadioModel model = GoalRadioModel(
      0,
      'STRENGTH',
      'THIS IS THE DESCRIPTION FOR THE STRENGTH GOAL',
      true,
      Icon(BrightFitIcons.strength),
      Colors.red.shade700);
}
