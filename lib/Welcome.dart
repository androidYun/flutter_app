import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/AccountLoginPage.dart';

void main() => runApp(Welcome());

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    Navigator.push(context,
//        new MaterialPageRoute(builder: (BuildContext context) {
//      return AccountLogin();
//    }));
    return MaterialApp(
      home: new AccountLoginPage(),
      routes: {"login": (BuildContext context) => AccountLoginPage()},
    );
  }
}
