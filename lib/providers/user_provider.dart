import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String token;
  Map currentUser;
  void addToken({String token}) {
    this.token = token;
  }

  void setCurrentUser({Map user}) {
    this.currentUser = user;
  }

  String get() {
    return token;
  }
}
