import 'package:flutter/material.dart';
import 'package:ryozanpark/navigations/myNavigator.dart';
import 'package:ryozanpark/screens/loginScreen.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new LoginScreen(),
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue[200],
        fontFamily: 'Pier'
      ),
      routes: MyNavigator.routes,
    );
  }
}