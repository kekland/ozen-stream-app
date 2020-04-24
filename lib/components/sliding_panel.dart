import 'package:flutter/material.dart';

class SlidingPanel extends StatelessWidget {
  final Widget child;
  final String title;
  final bool expandHeight;
  final double maxHeight;

  const SlidingPanel({
    Key key,
    this.child,
    this.title,
    this.expandHeight = true,
    this.maxHeight = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: expandHeight ? (height) * maxHeight : null,
      child: Column(
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
            padding: const EdgeInsets.only(
              top: 24.0,
              left: 24.0,
              right: 24.0,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            ),
          ),
          SizedBox(height: 24.0),
          if (expandHeight)
            Expanded(
              child: child,
            ),
          if (!expandHeight) child
        ],
      ),
    );
  }
}
