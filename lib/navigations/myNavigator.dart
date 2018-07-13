import 'package:flutter/material.dart';
import 'package:ryozanpark/screens/loginScreen.dart';

class MyNavigator {
  static final routes = <String, WidgetBuilder>{
    '/login': (BuildContext context) => LoginScreen(),
  };

  static void goToWelcome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/welcome', (Route<dynamic> route) => false);
  }

  static void goToLogin(BuildContext context){
    Navigator.of(context).pushNamed('/login');
  }
}