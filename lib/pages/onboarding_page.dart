import 'package:flutter/material.dart';
import 'package:ozen_app/components/app_logo.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
                left: 32.0,
              ),
              child: AppLogo(),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(32.0),
                scrollDirection: Axis.horizontal,
                children: [
                  Text('a'),
                  Text('b'),
                  Text('c'),
                  Text('d'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
