import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/mine/SellerReturnAddressPage.dart';
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
          const Divider(height: 1.0),
          _buildItemView("卖家退货地址"),
          const Divider(height: 1.0),
          _buildItemView("买家退货地址"),
          const Divider(height: 1.0),
          _buildItemView("经营地址"),
          const Divider(height: 5.0),
          _buildItemView("清除缓存"),
          const Divider(height: 5.0),
          _buildItemView("意见反馈"),
          const Divider(height: 1.0),
          _buildItemView("关于我们"),
        ],
      ),
    );
  }

  _buildItemView(String itemName) {
    return Container(
      child: ListTile(
        title: Text(itemName),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          switch (itemName) {
            case "设置":
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SetPasswordVerificationCodePage();
              }));
              break;
            case "卖家退货地址":
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SellerReturnAddressPage();
              }));
          }
        },
      ),
    );
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
