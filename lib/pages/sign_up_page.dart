import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ozen_app/api/auth.dart';
import 'package:ozen_app/components/app_logo.dart';
import 'package:ozen_app/extensions.dart';
import 'package:ozen_app/pages/sign_in_page.dart';
import 'package:ozen_app/state/binding.dart';
import 'package:ozen_app/state/state.dart';
import 'package:ozen_app/utils.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

import 'main_page.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(32.0),
          child: SignUpForm(),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController phoneController;
  TextEditingController passwordController;
  TextEditingController usernameController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
  }

  signUpTask() async {
    runAsyncTask(
      context: context,
      task: () async {
        await signUp(
            context: context,
            username: usernameController.text,
            password: passwordController.text,
            phoneNumber: phoneController.text,
            successCallback: (user) {
              Navigator.of(context).popUntil((r) => r.isFirst);
              pushAndReplaceAnimatedRoute(
                context: context,
                builder: (_) => MainPage(),
              );
            },
            errorCallback: (str) {
              Navigator.of(context).popUntil((r) => r.isFirst);
              throw Exception(str);
            },
            codeSentCallback: () async {
              return await showDialog<String>(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Введите ПИН-код'),
                    content: PinEntryTextField(
                      fields: 6,
                      onSubmit: (v) {
                        Navigator.pop(context, v);
                      },
                    ),
                  );
                },
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: true,
      onChanged: () => setState(() {}),
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
          TextFormField(
            controller: usernameController,
            keyboardType: TextInputType.text,
            validator: (v) => v.length >= 6
                ? null
                : 'Имя пользователя должно быть длиннее 6 символов',
            decoration: InputDecoration(
              labelText: 'Имя пользователя',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validator: (v) =>
                RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                        .hasMatch(v)
                    ? null
                    : 'Введите номер телефона',
            decoration: InputDecoration(
              labelText: 'Номер телефона',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            validator: (v) =>
                v.length >= 8 ? null : 'Пароль должен быть длиннее 8 символов',
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
              child: Text('Зарегистрироваться'),
              color: context.theme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              onPressed: (_formKey?.currentState?.validate() ?? false)
                  ? () {
                      signUpTask();
                    }
                  : null,
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
                pushAndReplaceAnimatedRoute(
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
    );
  }
}
