import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'app-logo-hero',
      child: Image.asset(
        'assets/ozen-logo.png',
        width: 96.0,
      ),
    );
  }
}
