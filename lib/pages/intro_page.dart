import 'package:flutter/material.dart';
import 'package:ozen_app/components/app_logo.dart';

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
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacementNamed('/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
