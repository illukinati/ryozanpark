import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ryozanpark/screens/mainScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = '';
  String _password = '';

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode usernameFocus = FocusNode();

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "http://puskesmasdampit.com/rzp/service_login.php?username=$_username&password=$_password"),
        headers: {"Accept": "application/json"});

    var resBody = JSON.decode(response.body);
    print(resBody[0]["username"]);
    if (resBody[0]["id"] != "0") {
      var route = new MaterialPageRoute(
        builder: (BuildContext context) => new MainScreen(
              name: resBody[0]["username"],
            ),
      );
      Navigator.pushAndRemoveUntil(context, route, (Route<dynamic> route) => false);
    } else {
      usernameController.text = "";
      passwordController.text = "";
      FocusScope.of(context).requestFocus(usernameFocus);
    }
    return 'Success!!';
  }

  void onChanged(String value, String part) {
    setState(() {
      if (part == "username")
        _username = value;
      else if (part == "password") _password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              flex: 3,
              child: new Hero(
                tag: 'logo-ryozan',
                child: new Container(
                  width: 200.0,
                  child: new Image.asset("assets/images/logo.gif"),
                ),
              ),
            ),
            new Expanded(
              flex: 4,
              child: new Column(
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 10.0),
                    child: new TextField(
                      focusNode: usernameFocus,
                      controller: usernameController,
                      onChanged: (String value) {
                        onChanged(value, "username");
                      },
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        labelText: "Enter Username",
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 20.0),
                    child: new TextField(
                      controller: passwordController,
                      onChanged: (String value) {
                        onChanged(value, "password");
                      },
                      style: new TextStyle(color: Colors.black),
                      decoration: new InputDecoration(
                        labelText: "Enter Password",
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                  ),
                  new Hero(
                    tag: 'btn-login',
                    child: new Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: new Material(
                        borderRadius: BorderRadius.circular(30.0),
                        shadowColor: Colors.blue.shade100,
                        elevation: 5.0,
                        child: new MaterialButton(
                          minWidth: 200.0,
                          height: 42.0,
                          onPressed: () {
                            getData();
                          },
                          color: Colors.blue,
                          child: new Text(
                            'Login',
                            style: new TextStyle(
                                color: Colors.white, fontFamily: 'Avenir'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
