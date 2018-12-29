import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/HttpUtil.dart';
import 'package:flutter_app/common/resources.dart';

class MinePage extends StatefulWidget {
  @override
  State createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  var userInformation = UserInformation("", "", 0.0, 0.0);

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("个人中心"),
        ),
        body: RefreshIndicator(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                buildMineInformation(),
                buildBuyerView(),
                buildSellerView(),
                bindWphView(),
                buildPersonService(),
              ],
            ),
            onRefresh: _onRefresh));
  }

  /// 下拉啥刷新方法
  Future<Null> _onRefresh() async {
    HttpUtil.getInstance().get("sj-api/account/detail", {}, (data) {
      setState(() {
        var account = data['data']["account"];
        var accountPayment = data['data']["accountPayment"];
        userInformation.name = accountPayment["accountName"];
        userInformation.phone = account["accountNo"];
        userInformation.accountAmount = account["amount"];
        userInformation.foOuAmount = account["frozenAmount"];
      });
    }, (resultMessage) {});
  }

  ///构建个人中心View

  Widget buildMineInformation() {
    return Container(
        decoration: BoxDecoration(
            color: ColorT.theme_color,
            borderRadius: BorderRadius.circular(8.0)),
        margin: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userInformation.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.phone_android,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            Text(
                              userInformation.phone,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                  ],
                ),
                Image.asset(
                  "images/ic_mine_header_image_holder.png",
                  width: 40.0,
                  height: 40.0,
                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "交易明细",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 26.0,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${userInformation.accountAmount}",
                          style: TextStyle(color: Colors.white, fontSize: 24.0),
                        ),
                        Text(
                          "账户余额",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          _getFuOuString(userInformation.foOuAmount),
                          style: TextStyle(color: Colors.white, fontSize: 34.0),
                        ),
                        Text(
                          "富有账管家",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ));
  }

  ///构建买家View
  Widget buildBuyerView() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "我买到的",
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  Image.asset(
                    "images/arrow_right.png",
                    width: 16,
                    height: 16,
                  )
                ],
              )),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildItemView(60, "竞拍中", 0),
                buildItemView(60, "待付款", 0),
                buildItemView(60, "待发货", 0),
                buildItemView(60, "待收货", 0),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///构建卖家View
  Widget buildSellerView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "我卖出的",
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  Image.asset(
                    "images/arrow_right.png",
                    width: 16,
                    height: 16,
                  )
                ],
              )),
          Container(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buildItemView(60, "待发货", 0),
                  buildItemView(60, "待收货", 0),
                  buildItemView(60, "待确认", 0),
                  buildItemView(60, "未售出", 0),
                  Container(
                    color: Colors.black,
                    height: 50,
                    width: 1,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: Image.asset(
                            "images/arrow_right.png",
                            width: 16,
                            height: 16,
                          )),
                      Text(
                        "全部订单",
                        style: goodTipStyle,
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buildItemView(60, "待确认", 0),
                  buildItemView(60, "已验货", 0),
                  buildItemView(60, "退货中", 0),
                  buildItemView(60, "未售出", 0),
                  Container(
                    color: Colors.black,
                    height: 50,
                    width: 1,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: Image.asset(
                            "images/arrow_right.png",
                            width: 16,
                            height: 16,
                          )),
                      Text(
                        "全部订单",
                        style: goodTipStyle,
                      )
                    ],
                  )
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }

  ///唯品会
  Widget bindWphView() {
    return Container(
      color: Colors.blue,
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "唯品会",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10, 0.0, 0.0),
                child: Text(
                  "拍机堂新交易所",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text("查看详情", style: TextStyle(color: Colors.white)),
              Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 26.0,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildPersonService() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildMineServiceItem("个人资料", "mine_01.png"),
              buildMineServiceItem("电子合同", "mine_01.png"),
              buildMineServiceItem("在线客服", "mine_01.png"),
              buildMineServiceItem("我的红包", "mine_01.png"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildMineServiceItem("卖家权益", "mine_01.png"),
              buildMineServiceItem("IMEI查询", "mine_01.png"),
              buildMineServiceItem("卖家积分", "mine_01.png"),
              Container()
            ],
          )
        ],
      ),
    );
  }

  var goodNumberStyle = TextStyle(color: Colors.black, fontSize: 20);
  var goodTipStyle = TextStyle(color: Colors.grey, fontSize: 16);

  buildItemView(int count, String tipContent, int status) {
    return GestureDetector(
      onTap: () {
        bindOnclick(status);
      },
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Text(
              "$count",
              style: goodNumberStyle,
            ),
          ),
          Text(
            tipContent,
            style: goodTipStyle,
          )
        ],
      ),
    );
  }

  buildMineServiceItem(String tipContent, String imageRes) {
    return Column(
      children: <Widget>[
        Image.asset(
          "images/$imageRes",
          width: 30,
          height: 36,
        ),
        Text(tipContent)
      ],
    );
  }

  bindOnclick(int status) {
    switch (status) {
      case 0:
        {
          print("执行绑定状态");
        }
    }
  }

  String _getFuOuString(double amount) {
    if (amount != null && amount >= 0) {
      return "$amount";
    } else {
      return "未设置";
    }
  }
}

class UserInformation {
  String name = "";
  String phone = "";
  double accountAmount = 0.0;
  double foOuAmount = 0.0;

  UserInformation(this.name, this.phone, this.accountAmount, this.foOuAmount);
}
