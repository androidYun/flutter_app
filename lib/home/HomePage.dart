import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "flutterDemo",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                Image.asset(
                  "images/icon_buyer_menu.png",
                  width: 30,
                  height: 34,
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: buildBarView(),
                  height: 160,
                ),
                buildMessageView(),
                buildReserveView(),
                buildSpecialView("普通专场", "价格不公开，更多捡漏可能", "每天一场货量过万"),
                buildSpecialView("优品专场", "价格不公开，更多捡漏可能", "每天一场货量过万"),
                buildSpecialView("统货专场", "价格不公开，更多捡漏可能", "每天一场货量过万")
              ],
            )));
  }

  buildBarView() {
    return PageView.builder(
      itemCount: list.length,
      controller: controller,
      reverse: false,
      onPageChanged: (index) {
        setState(() {
          flagPosition = index;
        });
      },
      itemBuilder: (BuildContext context, int index) =>
          _buildBarItemView(index, list[index]),
      scrollDirection: Axis.horizontal,
    );
  }

  /*绑定通知消息
   *
   */
  buildMessageView() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/img_new_flash_icon.png",
            height: 20,
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text("业务新模式上线"),
          )
        ],
      ),
    );
  }

  /*
   * 绑定订购按钮
   */
  buildReserveView() {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
              "https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg",
              width: MediaQuery.of(context).size.width,
              height: 40,
              fit: BoxFit.cover),
        ));
  }

  var specialList = ["普通专场", "优品专场", "统货专场"];

  /*
   * 绑定专场View
   */
  buildSpecialView(
      String specialName, String specialTip, String specialContent) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    specialName,
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  )),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(specialTip),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "3",
                    style: TextStyle(color: Colors.red),
                  ),
                  Text("场已抢"),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 26,
                  )
                ],
              )
            ],
          ),
          Container(
            height: 100,
            child: PageView.builder(
                itemCount: specialList.length,
                scrollDirection: Axis.horizontal,
                controller: PageController(viewportFraction: 0.8),
                itemBuilder: (BuildContext context, int index) =>
                    _buildSpecialView(specialList[index])),
          )
        ],
      ),
    );
  }

  /*
   * bar  数据源和绑定
   */
  var list = [
    "https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg",
    "https://ws1.sinaimg.cn/large/0065oQSqly1fw0vdlg6xcj30j60mzdk7.jpg",
    "https://ws1.sinaimg.cn/large/0065oQSqly1fw8wzdua6rj30sg0yc7gp.jpg",
    "https://ws1.sinaimg.cn/large/0065oQSqly1fuo54a6p0uj30sg0zdqnf.jpg"
  ];
  var flagPosition = 0;
  var controller = PageController(
    keepPage: true,
    initialPage: 0,
    viewportFraction: 1,
  );

  Widget _buildBarItemView(int index, String imageUrl) {
    return Container(
        child: Stack(
      fit: StackFit.loose,
      overflow: Overflow.clip,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment(0.8, 0.8),
          child:
              Text("$index", style: TextStyle(color: _getSelectColor(index))),
        )
      ],
    ));
  }

  /*
   * 获取选中的颜色
   */
  _getSelectColor(int index) {
    if (flagPosition == index)
      return Colors.red;
    else
      return Colors.black;
  }

  /*
  *绑定专场内容
   */
  _buildSpecialView(String specialContent) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                list[0],
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(30))),
              padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
              child: Text(
                "距结束104:46:55",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
