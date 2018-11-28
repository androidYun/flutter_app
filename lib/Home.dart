import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "PDA",
      home: HomePage(title: "我爱我家"),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State createState() => HomeState();
}

class HomeState extends State<HomePage> {
  String name = "张松";

  String houseWare = "测试维修仓库";

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Text(name),
                ),
                Text(
                  houseWare,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0.0, 50, 0.0, 100.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      HomeItemView("images/ic_main_shelf.png", "上架"),
                      HomeItemView("images/ic_main_shelf.png", "移库"),
                      HomeItemView("images/ic_main_shelf.png", "捡货"),
                      HomeItemView("images/ic_main_shelf.png", "盘点"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      HomeItemView("images/ic_main_shelf.png", "切换仓库"),
                      HomeItemView("images/ic_main_shelf.png", "设置"),
                      Expanded(
                        flex: 1,
                        child: Text(""),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(""),
                      )
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class HomeItemView extends StatelessWidget {
  final String content;
  final String imgAsset;

  HomeItemView(this.imgAsset, this.content);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            _jumpItem(content);
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset(imgAsset, width: 80.0, height: 60.0),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 20.0),
                ),
              )
            ],
          ),
        ));
  }

  void _jumpItem(String item) {
    switch (item) {
      case "上架":
        {

        }
    }
  }
}
