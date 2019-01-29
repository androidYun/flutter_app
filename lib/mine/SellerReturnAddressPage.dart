import 'package:flutter/material.dart';
import 'package:flutter_app/base/BaseState.dart';
import 'package:flutter_app/common/resources.dart';

class SellerReturnAddressPage extends StatefulWidget {
  @override
  State createState() {
    return SellerReturnAddressState();
  }
}

class SellerReturnAddressState extends BaseState<SellerReturnAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("卖家退货地址"),
      ),
      body: Container(
        color: ColorT.gray_f5,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(16, 30, 0, 16),
              child: Text("退货地址"),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 0, 0, 0.0),
              child: Row(
                children: <Widget>[
                  Text("收货人"),
                  Flexible(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "请输入收货人姓名", border: InputBorder.none),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 0, 0, 0.0),
              child: Row(
                children: <Widget>[
                  Text("联系电话"),
                  Flexible(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "请输入联系电话", border: InputBorder.none),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 0, 0, 0.0),
              child: Row(
                children: <Widget>[
                  Text("所在地区"),
                  Flexible(
                      child: ListTile(
                    leading: Text("河南省郑州市"),
                    trailing: Icon(Icons.location_on),
                  ))
                ],
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
              child: Row(
                children: <Widget>[
                  Text("详细地址"),
                  Flexible(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0.0),
                    child: TextField(
                      maxLines: 2,
                      decoration: InputDecoration(
                          hintText: "街道门牌信息", border: InputBorder.none),
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
