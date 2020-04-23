import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

void pushAnimatedRoute({
  BuildContext context,
  Duration duration = const Duration(milliseconds: 1250),
  Widget Function(BuildContext) builder,
}) {
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
        transitionDuration: duration,
        pageBuilder: (context, animation, animation2) {
          final _animation =
              CurvedAnimation(curve: Curves.easeInOut, parent: animation);
          return CircularRevealAnimation(
            animation: _animation,
            centerAlignment: Alignment.center,
            child: builder(context),
          );
        }),
  );
}
