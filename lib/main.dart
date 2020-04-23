import 'package:flutter/material.dart';
import 'package:ozen_app/pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF2BAAE2),
        canvasColor: Colors.black,
        cardColor: Color(0xFF2B2B2B),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: MainPage(),
    );
  }
}
