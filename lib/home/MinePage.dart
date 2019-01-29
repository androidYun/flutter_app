import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/BillPage.dart';
import 'package:flutter_app/HttpUtil.dart';
import 'package:flutter_app/base/BaseState.dart';
import 'package:flutter_app/common/HttpApi.dart';
import 'package:flutter_app/common/resources.dart';
import 'package:flutter_app/mine/SetPage.dart';

class MinePage extends StatefulWidget {
  @override
  State createState() {
    return _MinePageState();
  }
}

class _MinePageState extends BaseState<MinePage> {
  var userInformation = UserInformation("", "", 0.0, 0.0);

  var buyerCountModel = BuyerCountModel();

  //卖出的订单数量
  var supplierOrdersCount = SupplierOrdersCount();

  var supplierProductCount = SupplierProductCount();

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("个人中心"),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SetPage();
                  }));
                },
                icon: Icon(Icons.settings),
              )
            ],
          ),
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
        userInformation.name = account["roleName"];
        userInformation.phone = account["mobile"];
        userInformation.accountAmount = account["amount"];
        userInformation.foOuAmount = account["frozenAmount"];
      });
    }, (resultMessage) {
      toash(resultMessage);
    });
    HttpUtil.getInstance().get(HttpApi.Buyer_Order_Count, {}, (data) {
      setState(() {
        var buyCountData = data["data"];
        for (var intue in buyCountData) {
          switch (intue["status"]) {
            //订购
            case 0:
              buyerCountModel.reserveCount = intue["quotationCount"];
              break;
            //待收货
            case 1:
              buyerCountModel.waitReceiptCount = intue["quotationCount"];
              break;
            //待付款
            case 3:
              buyerCountModel.waitPaymentCount = intue["quotationCount"];
              break;
            //待发货
            case 4:
              buyerCountModel.waitDeliverCount = intue["quotationCount"];
              break;
            //竞拍中
            case 20:
              buyerCountModel.acutionCount = intue["quotationCount"];
              break;
          }
        }
      });
    }, (resultMessage) {});

    HttpUtil.getInstance().get(HttpApi.Seller_Order_Count, {}, (data) {
      setState(() {
        var orderCount = data["data"]["supplierOrdersNums"];
        supplierOrdersCount.needConfirmNum = orderCount["needConfirmNum"];
        supplierOrdersCount.pendingDeliveryNum =
            orderCount["pendingDeliveryNum"];
        supplierOrdersCount.pendingReceiveNum = orderCount["pendingReceiveNum"];
        supplierOrdersCount.tradingNum = orderCount["tradingNum"];
        var productCount = data["data"]["supplierProductsNums"];
        supplierProductCount.needConfirmNum = productCount["needConfirmNum"];
        supplierProductCount.inspectedNum = productCount["inspectedNum"];
        supplierProductCount.returningNum = productCount["returningNum"];
        supplierProductCount.unsoldNum = productCount["unsoldNum"];
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return BillPage();
                      }));
                    },
                    child: Text(
                      "交易明细",
                      style: TextStyle(color: Colors.white),
                    ),
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
                buildItemView(buyerCountModel.acutionCount, "竞拍中", 0),
                buildItemView(buyerCountModel.waitPaymentCount, "待付款", 0),
                buildItemView(buyerCountModel.waitDeliverCount, "待发货", 0),
                buildItemView(buyerCountModel.waitReceiptCount, "待收货", 0),
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
                  buildItemView(
                      supplierOrdersCount.pendingDeliveryNum, "待发货", 0),
                  buildItemView(
                      supplierOrdersCount.pendingReceiveNum, "待收货", 0),
                  buildItemView(supplierOrdersCount.needConfirmNum, "待确认", 0),
                  buildItemView(supplierOrdersCount.tradingNum, "未售出", 0),
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
                  buildItemView(supplierProductCount.needConfirmNum, "待确认", 0),
                  buildItemView(supplierProductCount.inspectedNum, "已验货", 0),
                  buildItemView(supplierProductCount.returningNum, "退货中", 0),
                  buildItemView(supplierProductCount.unsoldNum, "未售出", 0),
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

class BuyerCountModel {
  //竞拍中
  int acutionCount = 0;

//我的订购
  int reserveCount = 0;

//待付款
  int waitPaymentCount = 0;

//待发货
  int waitDeliverCount = 0;

  //待收货
  int waitReceiptCount = 0;
}

class SupplierOrdersCount {
  int pendingDeliveryNum = 0;
  int pendingReceiveNum = 0;
  int needConfirmNum = 0;
  int tradingNum = 0;
}

class SupplierProductCount {
  int needConfirmNum = 0;
  int inspectedNum = 0;
  int returningNum = 0;
  int unsoldNum = 0;
}
