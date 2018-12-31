import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/HttpUtil.dart';
import 'package:flutter_app/common/HttpApi.dart';

class XinJiPage extends StatefulWidget {
  @override
  State createState() {
    return XinJiPageState();
  }
}

class XinJiPageState extends State<XinJiPage> {
  var picturePathList = List();
  var brandList = List();

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: RefreshIndicator(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                _buildBannerView(),
                _buildBrandTitle(),
                _buildBrandView(),
                //_buildTabView()
              ],
            ),
            onRefresh: _onRefresh));
  }

  Future<Null> _onRefresh() async {
    HttpUtil.getInstance().get(HttpApi.Home_Brand_api, "", (data) {
      setState(() {
        picturePathList = data['data']['picturePathList'];
        brandList = data['data']['brandApiModelList'];
      });
    }, (errorMessage) {});
  }

  var bannerList = [
    "https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg",
    "https://ws1.sinaimg.cn/large/0065oQSqly1fw0vdlg6xcj30j60mzdk7.jpg",
    "https://ws1.sinaimg.cn/large/0065oQSqly1fw8wzdua6rj30sg0yc7gp.jpg",
    "https://ws1.sinaimg.cn/large/0065oQSqly1fuo54a6p0uj30sg0zdqnf.jpg"
  ];

  Widget _buildBannerView() {
    return Container(
        height: 160,
        child: Stack(
          children: <Widget>[
            PageView.builder(
                controller: PageController(viewportFraction: 1.0),
                reverse: false,
                itemCount: picturePathList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) =>
                    _buildBannerImage(index)),
            Positioned(
              left: 16,
              right: 16,
              top: 30,
              child: _buildBannerTextFiled(),
            ),
            Align(
              alignment: Alignment(0.8, 0.8),
              child: Text("数字"),
            ),
          ],
        ));
  }

  Widget _buildBannerImage(int index) {
    return Image.network(
      picturePathList[index]['url'],
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }

  ///加载搜索框
  Widget _buildBannerTextFiled() {
    return Container(
        child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  Text("搜索")
                ],
              ),
            )),
        Expanded(
          child: Text(
            "我的\n新机",
            textAlign: TextAlign.right,
          ),
          flex: 1,
        )
      ],
    ));
  }

  ///加载品牌头部
  Widget _buildBrandTitle() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "热卖品牌",
                style: TextStyle(fontSize: 30),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text("大家都在买"),
              ),
            ],
          ),
          Container(
              width: 80,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: Text("更多"))
        ],
      ),
    );
  }

  ///品牌编写
  _buildBrandView() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: brandList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (BuildContext context, int index) =>
              _buildBranItemView(index)),
    );
  }

  ///每一个品牌栏目的布局
  _buildBranItemView(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(
          brandList[index]['brandImage'],
          width: 30,
          height: 30,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text(brandList[index]['brandName']),
        )
      ],
    );
  }

  _buildTabView() {
    return DefaultTabController(
      length: brandList.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              tabs: brandList.map((dynamic any) {
            return Tab(
              child: _buildTabBarView(any["brandName"]),
            );
          }).toList()),
        ),
        body: new TabBarView(
            children: brandList.map((dynamic any) {
          return XinjiWidget();
        }).toList()),
      ),
    );
  }

  _buildTabBarView(String brandName) {
    return Text("$brandName");
  }
}

class XinjiWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class XinjiState extends State<XinjiWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("新机");
  }
}
