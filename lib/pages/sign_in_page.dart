import 'package:flutter/material.dart';
import 'package:ozen_app/api/auth.dart';
import 'package:ozen_app/components/app_logo.dart';
import 'package:ozen_app/extensions.dart';
import 'package:ozen_app/pages/sign_up_page.dart';
import 'package:ozen_app/state/binding.dart';
import 'package:ozen_app/state/state.dart';
import 'package:ozen_app/utils.dart';

import 'main_page.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(32.0),
          child: SignInForm(),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController phoneController;
  TextEditingController passwordController;

  initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  signInTask() async {
    runAsyncTask(
      context: context,
      task: () async {
        final user = await signIn(
          context: context,
          phoneNumber: phoneController.text,
          password: passwordController.text,
        );

        Navigator.of(context).popUntil((r) => r.isFirst);
        pushAndReplaceAnimatedRoute(
          context: context,
          builder: (_) => MainPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppLogo(),
        SizedBox(height: 24.0),
        Text(
          'Вход',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 24.0),
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Номер телефона',
            hintText: '+7-123-456-78-90',
            prefixIcon: Icon(Icons.phone),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          controller: passwordController,
          obscureText: true,
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
            child: Text('Войти'),
            color: context.theme.primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            onPressed: () {
              signInTask();
            },
          ),
        ),
        SizedBox(height: 12.0),
        SizedBox(
          width: double.infinity,
          child: FlatButton(
            child: Text('Создать аккаунт'),
            onPressed: () {
              pushAndReplaceAnimatedRoute(
                context: context,
                builder: (_) => SignUpPage(),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        Text(
          'или',
          style: context.textTheme.caption,
        ),
        SizedBox(
          width: double.infinity,
          child: FlatButton(
            child: Text('Слушать музыку без регистрации'),
            onPressed: () {
              pushAndReplaceAnimatedRoute(
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
    );
  }
}
