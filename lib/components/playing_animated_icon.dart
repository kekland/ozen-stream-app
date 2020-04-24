import 'package:flutter/material.dart';
import 'dart:math';

class PlayingAnimatedIcon extends StatefulWidget {
  final Color color;

  const PlayingAnimatedIcon({Key key, this.color}) : super(key: key);

  @override
  _PlayingAnimatedIconState createState() => _PlayingAnimatedIconState();
}

class _PlayingAnimatedIconState extends State<PlayingAnimatedIcon>
    with SingleTickerProviderStateMixin {
  AnimationController animation;

  initState() {
    super.initState();
    animation =
        AnimationController(duration: Duration(milliseconds: 750), vsync: this);

    animation.addListener(() => setState(() {}));

    animation.repeat(reverse: true);
  }

  dispose() {
    animation.dispose();
    super.dispose();
  }

  Widget buildBar(double intensity) {
    return Container(
      width: 3.0,
      height: max(6.0, 24.0 * intensity.abs()),
      margin: EdgeInsets.only(
        right: 1.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.5),
        color: widget.color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildBar(sin(animation.value * pi) * 0.5),
          buildBar(animation.value),
          buildBar(sin(animation.value * pi)),
          buildBar(animation.value),
          buildBar(sin(animation.value * pi) * 0.5),
        ],
      ),
    );
  }
}
