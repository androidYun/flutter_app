import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/Home.dart';
import 'package:flutter_app/HttpUtil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "home": (BuildContext context) => new Home(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class TipView extends StatelessWidget {
  final String content;

  TipView(this.content);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  TextEditingController userNameController = new TextEditingController();
  TextEditingController passWordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 100.0, 0.0, 100.0),
              child: Center(
                child: Text(
                  "仓储系统PDA",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 15.0),
              child: TextField(
                controller: userNameController,
                style: new TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0.0, 0.0),
                  labelText: "请输入手机号",
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 0.0),
                child: TextField(
                  controller: passWordController,
                  style: new TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: "请输入密码",
                    contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0.0, 0.0),
                  ),
                  obscureText: true,
                )),
            Container(
              color: Colors.blue,
              margin: EdgeInsets.fromLTRB(26.0, 60, 26.0, 0.0),
              child: FlatButton(
                onPressed: _login,
                child: Text("登陆", style: TextStyle()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void jumpHome() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new Home();
        }));
  }

  void _login() {
    var userName = userNameController.text;
    var passWord = passWordController.text;
    if (userName.isEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              Dialog(
                child: new TipView("密码不能为空"),
              ));
      return;
    }
    debugger();
    //判断密码
    if (passWord.isEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              Dialog(
                child: new TipView("密码不能为空"),
              ));
      return;
    }
    var loginReq = {"username": userName, "password": passWord};
    HttpUtil.getInstance().get("pda/login", loginReq, (data) {
      jumpHome();
    }, (errorMsg) {
      showDialog(
          context: context,
          builder: (context) =>
              Dialog(
                child: new TipView(errorMsg),
              ));
    });
  }
}
