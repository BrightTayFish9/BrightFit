import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/models/goal_radio_model.dart';
import 'package:bright_fit/presentation/bright_fit_icons.dart';
import 'package:flutter/material.dart';

///Holds the static list of all exercise goals
class GoalModelProvider {
  static Singleton singleton = Singleton();
  static String strengthTitle = 'STRENGTH';
  static String intensityTitle = 'H.I.I.T';
  static String enduranceTitle = 'ENDURANCE';
  static String weightLossTitle = 'WEIGHT LOSS';
  static String powerTitle = 'POWER';
  static String hypertrophyTitle = 'SHRED';

  static List<GoalRadioModel> list = [
    GoalRadioModel(
        0,
        strengthTitle,
        'Optimize your 1 Rep Max to increase overall strength'.toUpperCase(),
        singleton.model.title == strengthTitle ? true : false,
        Icon(BrightFitIcons.strength),
        Colors.red.shade700),
    GoalRadioModel(
        1,
        intensityTitle,
        'Boost your metabolism and tone your body with high intensity'
            .toUpperCase(),
        singleton.model.title == intensityTitle ? true : false,
        Icon(BrightFitIcons.intensity),
        Colors.orange.shade600),
    GoalRadioModel(
        2,
        enduranceTitle,
        'Develop greater stamina for sustained muscular output'.toUpperCase(),
        singleton.model.title == enduranceTitle ? true : false,
        Icon(BrightFitIcons.endurance),
        Colors.green.shade600),
    GoalRadioModel(
        3,
        weightLossTitle,
        'Burn unwanted fat and improve heart health'.toUpperCase(),
        singleton.model.title == weightLossTitle ? true : false,
        Icon(BrightFitIcons.weight),
        Colors.blue.shade700),
    GoalRadioModel(
        4,
        powerTitle,
        'Enhance athleticism to maximize speed and agility'.toUpperCase(),
        singleton.model.title == powerTitle ? true : false,
        Icon(BrightFitIcons.flash),
        Colors.yellow.shade700),
    GoalRadioModel(
        5,
        hypertrophyTitle,
        'Maximize muscle mass through precision burnout training'.toUpperCase(),
        singleton.model.title == hypertrophyTitle ? true : false,
        Icon(BrightFitIcons.shred),
        Colors.black),
  ];
}
