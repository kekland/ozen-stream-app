import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:ozen_app/api/auth.dart';
import 'package:ozen_app/components/app_logo.dart';
import 'package:ozen_app/pages/onboarding_page.dart';
import 'package:ozen_app/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = await restoreState(context: context);
    if ((prefs.getBool('onboardingPassed') ?? false) || loggedIn) {
      pushAndReplaceAnimatedRoute(context: context, builder: (_) => MainPage());
    }
    else {
      pushAndReplaceAnimatedRoute(context: context, builder: (_) => OnboardingPage());
    }
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
