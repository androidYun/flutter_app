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
            Container(
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
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.0),
                                ),
                                Text(
                                  "账户余额",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 34.0),
                                ),
                                Text(
                                  "富有账管家",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
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
                )),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            ),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              width: 200.0,
              height: 100.0,
            )
          ],
        ),
      ),
    );
  }
}
