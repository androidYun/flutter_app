import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/common/resources.dart';

class MinePage extends StatefulWidget {
  @override
  State createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人中心"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildMineInformation(),
            buildBuyerView(),
            buildSellerView(),
            bindWphView(),
            buildPersonService(),
          ],
        ),
      ),
    );
  }

  /**
   * 构建个人中心View
   */
  buildMineInformation() {
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
                      "任凤枝",
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
                              "187000000",
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
                          "85730.28",
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
                          "未设置",
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

  /**
   * 构建买家View
   */
  buildBuyerView() {
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

  /**
   * 构建卖家View
   */
  buildSellerView() {
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

  /**
   * 唯品会
   */
  bindWphView() {
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

  buildPersonService() {
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
}
