import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectHouseWare extends StatefulWidget {
  @override
  State createState() {
    return WareWidget();
  }
}

class WareWidget extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("选择仓库"),
      ),

    );
  }
}
