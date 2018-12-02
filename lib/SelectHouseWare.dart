import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/SpUtils.dart';

class SelectHouseWare extends StatefulWidget {
  @override
  State createState() {
    return WareWidget();
  }
}

class WareWidget extends State<StatefulWidget> {
  var list = List<String>();

  var selectIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list.add("liguiyun");
    list.add("liguiyun");
    list.add("liguiyun");
    list.add("liguiyun");
    list.add("liguiyun");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("选择仓库"),
      ),
      body: Center(
          child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: list == null ? 0 : list.length,
              itemBuilder: (BuildContext context, int index) {
                return gitItemView(list[index], index);
              })),
    );
  }

  Widget gitItemView(String content, int index) {
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
              child: Container(
                alignment: Alignment.centerRight,
                child: Checkbox(
                    value: selectIndex == index ? true : false,
                    onChanged: (bool cb) {
                      setState(() {
                        selectIndex = index;
                      });
                      SpUtils.instance.setWareHouseId(200);
                      Navigator.pop(context);
                    }),
              ))
        ],
      ),
    );
  }
}
