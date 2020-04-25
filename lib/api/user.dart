import 'package:firebase_auth/firebase_auth.dart';

class User {
  final FirebaseUser firebaseUser;
  final String username;

  User({
    this.firebaseUser,
    this.username,
  });
}
