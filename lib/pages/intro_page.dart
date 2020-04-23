import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:ozen_app/components/app_logo.dart';

import 'main_page.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkOnboarding();
    });
  }

  checkOnboarding() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1250),
          pageBuilder: (context, animation, animation2) {
            final _animation =
                CurvedAnimation(curve: Curves.easeInOut, parent: animation);
            return CircularRevealAnimation(
              animation: _animation,
              centerAlignment: Alignment.center,
              child: MainPage(),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AppLogo(
            width: 160.0,
          ),
        ),
      ),
    );
  }
}
