import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ozen_app/api/user.dart';
import 'package:ozen_app/state/binding.dart';
import 'package:ozen_app/state/state.dart';

Future<bool> restoreState({BuildContext context}) async {
  final fireUser = await FirebaseAuth.instance.currentUser();

  if (fireUser != null) {
    final document =
        await Firestore.instance.document('user/${fireUser.uid}/').get();

    final user = User(
      firebaseUser: fireUser,
      username: document.data['username'],
    );

    ModelBinding.update<AppState>(
      context,
      ModelBinding.of<AppState>(context).copyWith(
        currentUser: user,
      ),
    );

    return true;
  }
  else {
    return false;
  }
}

Future<User> signIn({
  BuildContext context,
  String phoneNumber,
  String password,
}) async {
  final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: '$phoneNumber@ozen.stream', password: password);

  final document =
      await Firestore.instance.document('user/${result.user.uid}/').get();

  final user = User(
    firebaseUser: result.user,
    username: document.data['username'],
  );

  ModelBinding.update<AppState>(
    context,
    ModelBinding.of<AppState>(context).copyWith(
      currentUser: user,
    ),
  );

  return user;
}

Future<void> signUp({
  BuildContext context,
  String phoneNumber,
  String username,
  String password,
  Future<String> Function() codeSentCallback,
  void Function(User) successCallback,
  void Function(String) errorCallback,
}) async {
  try {
    final createUser = () async {
      final user = await _createAccount(
        context: context,
        password: password,
        phoneNumber: phoneNumber,
        username: username,
      );

      successCallback(user);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (credential) async {
        await createUser();
      },
      verificationFailed: (exception) {
        errorCallback(exception.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]) async {
        final code = await codeSentCallback();

        try {
          final credential = PhoneAuthProvider.getCredential(
            verificationId: verificationId,
            smsCode: code,
          );

          await FirebaseAuth.instance.signInWithCredential(credential);

          await createUser();
        } catch (e) {
          errorCallback(e.toString());
        }
      },
      codeAutoRetrievalTimeout: (err) {},
    );
  } catch (e) {
    errorCallback(e.toString());
  }
}

Future<User> _createAccount({
  BuildContext context,
  String phoneNumber,
  String username,
  String password,
}) async {
  final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: '$phoneNumber@ozen.stream',
    password: password,
  );

  await Firestore.instance
      .document('user/${result.user.uid}')
      .setData({'username': username});

  final user = User(
    firebaseUser: result.user,
    username: username,
  );

  ModelBinding.update<AppState>(
    context,
    ModelBinding.of<AppState>(context).copyWith(
      currentUser: user,
    ),
  );

  return user;
}
