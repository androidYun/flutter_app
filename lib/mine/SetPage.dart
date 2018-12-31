import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/mine/SetPasswordPage.dart';

class SetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SetState();
  }
}

class SetState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Column(
        children: <Widget>[
          _buildItemView("设置"),
          Divider(
            indent: 16,
            color: Colors.grey,
          ),
          _buildItemView("卖家退货地址"),
          Divider(
            indent: 16,
            color: Colors.grey,
          ),
          _buildItemView("买家退货地址"),
          Divider(
            indent: 16,
            color: Colors.grey,
          ),
          _buildItemView("经营地址"),
          _buildItemFiveDivider(),
          _buildItemView("清除缓存"),
          _buildItemFiveDivider(),
          _buildItemView("意见反馈"),
          Divider(
            indent: 16,
            color: Colors.grey,
          ),
          _buildItemView("关于我们"),
          _buildItemDivider()
        ],
      ),
    );
  }

  _buildItemView(String itemName) {
    return GestureDetector(
        onTap: () {
          switch (itemName) {
            case "设置":
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SetPasswordVerificationCodePage();
              }));
              break;
          }
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(itemName),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ));
  }

  _buildItemDivider() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: Divider(
        color: Colors.grey,
      ),
    );
  }

  _buildItemFiveDivider() {
    return Divider(
      height: 50.0,
      color: Colors.black,
    );
  }
}
