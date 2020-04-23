import 'package:flutter/material.dart';
import 'package:ozen_app/pages/intro_page.dart';
import 'package:ozen_app/pages/main_page.dart';
import 'package:ozen_app/pages/onboarding_page.dart';
import 'package:ozen_app/pages/sign_in_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'õzen',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF2BAAE2),
        canvasColor: Colors.black,
        cardColor: Color(0xFF2B2B2B),
        accentColor: Color(0xFF2BAAE2),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Color(0xFFF7F7F7),
        accentColor: Color(0xFF2BAAE2),
      ),
      home: IntroPage(),
      routes: {
        '/intro': (_) => IntroPage(),
        '/onboarding': (_) => OnboardingPage(),
        '/main': (_) => MainPage(),
        '/signIn': (_) => SignInPage(),
        '/signUp': (_) => SignInPage(),
      },
    );
  }
}
