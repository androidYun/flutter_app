import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectHouseWare extends StatefulWidget {
  @override
  State createState() {
    return WareWidget();
  }
}

class WareWidget extends State<StatefulWidget> {
  var list = List<String>();

  @override
  Widget build(BuildContext context) {
    setState(() {
      list.add("liguiyun");
      list.add("liguiyun");
      list.add("liguiyun");
      list.add("liguiyun");
      list.add("liguiyun");
    });
    return new Scaffold(
      appBar: new AppBar(
        title: Text("选择仓库"),
      ),
      body: Center(
          child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: list == null ? 0 : list.length,
              itemBuilder: (BuildContext context, int index) {
                return gitItemView(list[index]);
              })),
    );
  }

  Widget gitItemView(String content) {
    return Container(
      padding: EdgeInsets.fromLTRB(26.0, 0, 26.0, 0),
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 1.0),
      height: 60.0,
      alignment: Alignment.center,
      color: Colors.blue,
      child: Row(
        children: <Widget>[
          Text(content),
          Expanded(
              child:Container(
                alignment: Alignment.centerRight,
                child:  Checkbox(value: false, onChanged: (bool cb) {
                  setState(() {
                    list[1]="离前进";
                  });
                }),
              ))
        ],
      ),
    );
  }
}
