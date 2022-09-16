import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/presentation/bright_fit_icons.dart';
import 'package:flutter/material.dart';

///Used as a loading icon
class Weighter extends StatefulWidget {
  @override
  _WeighterState createState() => _WeighterState();
}

class _WeighterState extends State<Weighter>
    with SingleTickerProviderStateMixin {
  AnimationController riseController;
  Animation<double> animationRiseFall;
  Animation<double> animationGrowShrink;
  Animation<double> animationRotate;

  double initOffset = 100.0;
  double offset = 0;
  double initScale = 150;
  double scale = 100;
  double factor = 50;

  @override
  void initState() {
    super.initState();

    riseController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animationRiseFall = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: riseController, curve: Curves.easeInOutQuart));
    animationGrowShrink = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: riseController, curve: Curves.easeInOutCubic));
    animationRotate = Tween<double>(begin: 0.0, end: -0.50).animate(
        CurvedAnimation(parent: riseController, curve: Curves.easeInOutQuart));
    riseController.addListener(() {
      setState(() {
        if (riseController.value >= 0.0 && riseController.value <= 0.5) {
          offset = initOffset * animationRiseFall.value;
          scale = initScale + animationGrowShrink.value * factor;
        } else if (riseController.value > 0.5 && riseController.value <= 1.0) {
          offset = initOffset * animationRiseFall.value;
          scale = initScale - (animationGrowShrink.value - .5) * factor;
        }
      });
    });
    riseController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 200.0,
//      color: Colors.grey.shade200,
      child: Transform.translate(
          offset: Offset(0, offset - 50),
          child: RotationTransition(
            turns: animationRotate,
            child: Icon(
              BrightFitIcons.workout,
              color: Singleton().model.color,
              size: scale,
            ),
          )),
    );
  }

  @override
  void dispose() {
    riseController.dispose();
    super.dispose();
  }
}
