import 'package:flutter/material.dart';

class SlidingPanel extends StatelessWidget {
  final Widget child;
  final String title;

  const SlidingPanel({
    Key key,
    this.child,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.0),
        Center(
          heightFactor: 1.0,
          child: Container(
            width: 32.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24.0,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
