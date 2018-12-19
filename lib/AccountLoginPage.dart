import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/HttpUtil.dart';
import 'package:flutter_app/MinePage.dart';
import 'package:flutter_app/common/resources.dart';

class AccountLoginPage extends StatefulWidget {
  @override
  State createState() {
    return _AccountLoginState();
  }
}

class _AccountLoginState extends State<AccountLoginPage> {
  var loginBtnColor = ColorT.gray_66;

  var loginBtnTextColor = ColorT.gray_33;

  var isPassword = true; //是否显示密码

  var isShowCancelBtn = false; //是否显示删除站好的按钮

  TextEditingController userNameController = new TextEditingController();

  TextEditingController passWordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 0.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/ic_login_logo.png",
              alignment: Alignment.center,
              width: 166.0,
              height: 75,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              alignment: Alignment.center,
              child: TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  hintText: "请输入账号",
                  suffixIcon: Offstage(
                      offstage: isShowCancelBtn,
                      child: IconButton(
                        icon: Icon(Icons.cancel),
                        color: Colors.black12,
                        onPressed: () {
                          userNameController.text = "";
                        },
                      )),
                ),
                onChanged: (userName) {
                  setState(() {
                    if (userNameController.text.isEmpty ||
                        passWordController.text.isEmpty) {
                      loginBtnColor = ColorT.gray_66;
                      loginBtnTextColor = ColorT.gray_33;
                    } else {
                      loginBtnColor = ColorT.theme_color;
                      loginBtnTextColor = Colors.white;
                    }
                    if (userNameController.text.isEmpty) {
                      isShowCancelBtn = true;
                    } else {
                      isShowCancelBtn = false;
                    }
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              alignment: Alignment.center,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: isPassword,
                controller: passWordController,
                onChanged: (userName) {
                  if (userName.isEmpty || userNameController.text.isEmpty) {
                    setState(() {
                      loginBtnColor = ColorT.gray_66;
                      loginBtnTextColor = ColorT.gray_33;
                    });
                  } else {
                    setState(() {
                      loginBtnColor = ColorT.theme_color;
                      loginBtnTextColor = Colors.white;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: "请输入密码",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    color: Colors.black12,
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
              alignment: Alignment.center,
              color: loginBtnColor,
              child: GestureDetector(
                onTap: () {
                  _login();
                },
                child: Text(
                  "登陆",
                  style: TextStyle(color: loginBtnTextColor),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: null,
                  child: Text(
                    "忘记密码？",
                    style: TextStyle(color: ColorT.theme_color),
                    textAlign: TextAlign.left,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    _login();
//                    Navigator.push(context,
//                        new MaterialPageRoute(builder: (BuildContext context) {
//                      return MinePage();
//                    }
//                    ));
                  },
                  child: Text("快捷登陆？"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  void _login() {
    var userName = userNameController.text;
    var passWord = passWordController.text;
    if (userName.isEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              Dialog(
                child: new TipView("密码不能为空"),
              ));
      return;
    }
    //判断密码
    if (passWord.isEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              Dialog(
                child: new TipView("密码不能为空"),
              ));
      return;
    }
    var loginReq = {"username": userName, "password": passWord};
    HttpUtil.getInstance().post("http://47.96.53.33/wms-api/pda/login", loginReq, (data) {
    }, (errorMsg) {
      showDialog(
          context: context,
          builder: (context) =>
              Dialog(
                child: new TipView(errorMsg),
              ));
    });
  }
}
class TipView extends StatelessWidget {
  final String content;

  TipView(this.content);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
      ),
    );
  }
}
