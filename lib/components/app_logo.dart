import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double width;

  const AppLogo({Key key, this.width = 96.0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'app-logo-hero',
      child: Image.asset(
        'assets/ozen-logo.png',
        width: width,
      ),
    );
  }
}
