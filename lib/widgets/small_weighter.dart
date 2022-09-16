import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/presentation/bright_fit_icons.dart';
import 'package:flutter/material.dart';

///Used as a small loading icon
class SmallWeighter extends StatefulWidget {
  @override
  _SmallWeighterState createState() => _SmallWeighterState();
}

class _SmallWeighterState extends State<SmallWeighter>
    with SingleTickerProviderStateMixin {
  AnimationController riseController;
  Animation<double> animationGrowShrink;
  Animation<double> animationRotate;

  double initScale = 100;
  double scale = 100;
  double factor = 50;

  @override
  void initState() {
    super.initState();

    riseController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animationGrowShrink = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: riseController, curve: Curves.easeInOutCubic));
    animationRotate = Tween<double>(begin: 0.0, end: -0.50).animate(
        CurvedAnimation(parent: riseController, curve: Curves.easeInOutQuart));
    riseController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: animationRotate,
      child: Icon(
        BrightFitIcons.workout,
        color: Singleton().model.color,
        size: scale,
      ),
    );
  }

  @override
  void dispose() {
    riseController.dispose();
    super.dispose();
  }
}
