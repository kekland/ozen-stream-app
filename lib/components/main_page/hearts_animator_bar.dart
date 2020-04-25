import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    return percentage + 1.0;
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
          size: 32.0,
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

class _HeartsAnimatorBarState extends State<HeartsAnimatorBar>
    with SingleTickerProviderStateMixin {
  List<HeartData> hearts;
  Ticker ticker;

  @override
  void initState() {
    widget.controller.pushHeart = pushHeart;
    hearts = [];
    super.initState();

    ticker = this.createTicker((_) => setState(() => {}));

    ticker.start();
  }

  dispose() {
    ticker.stop();
    ticker.dispose();
    super.dispose();
  }

  double getRandomValue(double amplitude,
      [double minValue = 0.0, bool hasNegatives = false]) {
    double _amplitude = amplitude - minValue;
    double _randValue = random.nextDouble() + ((hasNegatives) ? -0.5 : 0.0);
    double _minValue = (_randValue < 0.0) ? -minValue : minValue;

    return _randValue * _amplitude + _minValue;
  }

  void pushHeart() {
    hearts.add(HeartData(
      initialOffset: Offset(
        getRandomValue(32.0, 0.0, true),
        getRandomValue(32.0, 0.0, true),
      ),
      lifetimeDuration: Duration(
        milliseconds: getRandomValue(2000.0, 1250.0).round(),
      ),
      maxRisingHeight: getRandomValue(270.0, 160.0),
      startTime: DateTime.now(),
      velocityVector: Offset(
        getRandomValue(0.3, 0.3, true),
        getRandomValue(2.0, 1.5, false),
      ),
    ));
  }

  void updateHearts({DateTime now}) {
    hearts = hearts
        .where(
          (h) => (now.difference(h.startTime) <= h.lifetimeDuration),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    updateHearts(now: now);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 104.0, bottom: 16.0),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomLeft,
          children: [
            ...hearts.map(
              (h) => Align(
                alignment: Alignment.bottomLeft,
                child: Transform.translate(
                  offset: Offset(0.0, 72.0),
                  child: h.buildWidget(context: context, now: now),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
