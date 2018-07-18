import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ryozanpark/model/databaseHelper.dart';
import 'package:ryozanpark/screens/loginScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  var db = new DatabaseHelper();
  var route = new MaterialPageRoute(
    builder: (BuildContext context) => new LoginScreen(),
  );

  @override
  void initState() {
    super.initState();
    db.getUser(1).then((user) {
      setState(() {
        this.username = user.username;
      });
    });
  }

  Future<Null> logout() async {
    await db.deleteUser(this.username);
    db.getAllUsers().then((user) => user.forEach((note) => print(note)));
    Navigator.pushAndRemoveUntil(
        context, route, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        margin: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 0.0),
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              onPressed: () => logout(),
              child: new Text("Logout"),
            ),
            new Text(
              this.username,
              style: new TextStyle(
                color: Colors.black,
                fontSize: 25.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
