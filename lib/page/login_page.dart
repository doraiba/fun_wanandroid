import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (_) => Container(
          alignment: Alignment.center,
          color: Colors.blueAccent,
          child: Text("Login Page"),
        ),
      ),
    );
  }
}
