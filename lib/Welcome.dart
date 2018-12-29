import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/AccountLoginPage.dart';
import 'package:flutter_app/MainApp.dart';

void main() => runApp(Welcome());

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new AccountLoginPage(),
      routes: {"login": (BuildContext context) => AccountLoginPage()},
    );
  }
}
