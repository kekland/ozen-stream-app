import 'package:flutter/material.dart';

class SlidingPanel extends StatelessWidget {
  final Widget child;

  const SlidingPanel({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.0),
        Container(
          width: 32.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(height: 12.0),
        child,
      ],
    );
  }
}
