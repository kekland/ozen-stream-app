import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ozen_app/extensions.dart';

class HeartsController {
  VoidCallback pushHeart;

  addHeart() {
    if (pushHeart != null) pushHeart();
  }
}

class HeartData {
  final DateTime startTime;
  final Duration lifetimeDuration;
  final Offset initialOffset;
  final double maxRisingHeight;
  final Offset velocityVector;

  HeartData({
    this.startTime,
    this.lifetimeDuration,
    this.initialOffset,
    this.velocityVector,
    this.maxRisingHeight,
  });

  double lifetimePercentage(DateTime now) {
    return (now.difference(startTime)).inMilliseconds /
        lifetimeDuration.inMilliseconds;
  }

  Color color({BuildContext context, DateTime now}) {
    double percentage = lifetimePercentage(now);
    return Color.lerp(context.theme.primaryColor,
        context.theme.primaryColor.withOpacity(0.0), percentage);
  }

  double scale({BuildContext context, DateTime now}) {
    double percentage = lifetimePercentage(now);
    return 1.0 - percentage;
  }

  Offset calculateOffset({BuildContext context, DateTime now}) {
    double percentage = lifetimePercentage(now);

    return initialOffset + velocityVector * (-maxRisingHeight * percentage);
  }

  Widget buildWidget({BuildContext context, DateTime now}) {
    return Transform.translate(
      offset: calculateOffset(context: context, now: now),
      child: Transform.scale(
        scale: scale(context: context, now: now),
        child: Icon(
          Icons.favorite,
          color: color(context: context, now: now),
        ),
      ),
    );
  }
}

class HeartsAnimatorBar extends StatefulWidget {
  final HeartsController controller;

  const HeartsAnimatorBar({Key key, this.controller}) : super(key: key);

  @override
  _HeartsAnimatorBarState createState() => _HeartsAnimatorBarState();
}

Random random = new Random();

class _HeartsAnimatorBarState extends State<HeartsAnimatorBar> {
  List<HeartData> hearts;

  @override
  void initState() {
    widget.controller.pushHeart = pushHeart;
    super.initState();
  }

  double getRandomValue(double amplitude, [bool hasNegatives = false]) {
    if (hasNegatives) {
      return (random.nextDouble() - 0.5) * 2.0 * amplitude;
    } else {
      return random.nextDouble() * amplitude;
    }
  }

  void pushHeart() {
    hearts.add(HeartData(
      initialOffset: Offset(
        getRandomValue(32.0, true),
        getRandomValue(32.0, true),
      ),
      lifetimeDuration: Duration(
        milliseconds: getRandomValue(300.0).round(),
      ),
      maxRisingHeight: getRandomValue(125.0),
      startTime: DateTime.now(),
      velocityVector: Offset(
        getRandomValue(1.0, true),
        getRandomValue(1.0),
      ),
    ));
  }

  void updateHearts({DateTime now}) {
    hearts = hearts.where(
      (h) => (now.difference(h.startTime) <= h.lifetimeDuration),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...hearts.map((h) => h.buildWidget()),
      ],
    );
  }
}
