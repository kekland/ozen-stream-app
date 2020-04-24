import 'package:flutter/material.dart';
import 'package:ozen_app/components/app_logo.dart';
import 'package:ozen_app/extensions.dart';
import 'package:ozen_app/pages/sign_in_page.dart';
import 'package:ozen_app/utils.dart';

import 'main_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppLogo(),
              SizedBox(height: 24.0),
              Text(
                'Регистрация',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Имя пользователя',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Номер телефона',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('Зарегистрироваться'),
                  color: context.theme.primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () {
                    pushAnimatedRoute(
                      context: context,
                      builder: (_) => MainPage(),
                    );
                  },
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Уже есть аккаунт?',
                style: context.textTheme.caption,
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  child: Text('Войти'),
                  onPressed: () {
                    pushAnimatedRoute(
                      context: context,
                      duration: Duration(milliseconds: 750),
                      builder: (_) => SignInPage(),
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
      ),
    );
  }
}
