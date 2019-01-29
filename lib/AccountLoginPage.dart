import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/HttpUtil.dart';
import 'package:flutter_app/common/SpUtils.dart';
import 'package:flutter_app/common/resources.dart';
import 'package:flutter_app/home/HomePage.dart';
import 'package:flutter_app/MainApp.dart';
import 'package:flutter_app/home/MinePage.dart';
import 'package:flutter_app/resp/LoginResp.dart';

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
      appBar: new AppBar(
        title: Text("账号登陆"),
      ),
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
                keyboardType: TextInputType.text,
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
                margin: EdgeInsets.fromLTRB(0.0, 30, 0.0, 0.0),
                decoration: BoxDecoration(
                    color: loginBtnColor,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                    onPressed: () {
                      _login();
                    },
                    child: new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "登陆",
                        style: TextStyle(color: loginBtnTextColor),
                      ),
                    ))),
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
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return MinePage();
                    }));
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
          builder: (context) => Dialog(
                child: new TipView("密码不能为空"),
              ));
      return;
    }
    //判断密码
    if (passWord.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: new TipView("密码不能为空"),
              ));
      return;
    }
    var loginReq = {"userName": userName, "passWord": passWord};
    HttpUtil.getInstance().post("sj-api/auth/login", loginReq, (data) {
      var loginResp = LoginResp.fromJson(data);
      SpUtils.instance.setAccessToken(loginResp.data.accessToken);
      HttpUtil.getInstance().updateToken(loginResp.data.accessToken);
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return MainApp();
      }));
    }, (errorMsg) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
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
