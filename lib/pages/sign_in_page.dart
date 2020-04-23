import 'package:flutter/material.dart';
import 'package:ozen_app/extensions.dart';
import 'package:ozen_app/utils.dart';

import 'main_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Джон пососи.'),
            SizedBox(height: 8.0),
            Text(
              'или',
              style: context.textTheme.caption,
            ),
            SizedBox(
              width: double.infinity,
              child: FlatButton(
                child: Text('Слушать музыку прямо сейчас'),
                onPressed: () {
                  pushAnimatedRoute(
                    context: context,
                    builder: (_) => MainPage(),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
