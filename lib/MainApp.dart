import 'package:flutter/material.dart';
import 'package:flutter_app/Home.dart';
import 'package:flutter_app/home/HomePage.dart';
import 'package:flutter_app/home/MessagePage.dart';
import 'package:flutter_app/home/MinePage.dart';
import 'package:flutter_app/home/PublishPage.dart';
import 'package:flutter_app/home/XinJiPage.dart';


class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPageWidget(title: 'Flutter Demo Home Page'),
      routes: {
        "home": (BuildContext context) => new Home(),
      },
    );
  }
}

class MainPageWidget extends StatefulWidget {
  MainPageWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPageWidget>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new TabBarView(controller: controller, children: [
        new HomePage(),
        new XinJiPage(),
        new PublishPage(),
        new MessagePage(),
        new MinePage()
      ]),
      bottomNavigationBar: new Material(
        color: Colors.blue,
        child: new TabBar(controller: controller, tabs: [
          Tab(
            text: "二手",
            icon: Icon(Icons.home),
          ),
          Tab(
            text: "新机",
            icon: Icon(Icons.new_releases),
          ),
          Tab(
            text: "发布",
            icon: Icon(Icons.publish),
          ),
          Tab(
            text: "消息",
            icon: Icon(Icons.message),
          ),
          Tab(
            text: "我的",
            icon: Icon(Icons.center_focus_weak),
          )
        ]),
      ),
    );
  }
}
