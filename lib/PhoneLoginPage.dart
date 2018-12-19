import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/AccountLoginPage.dart';
import 'package:flutter_app/HttpUtil.dart';
import 'package:flutter_app/MinePage.dart';
import 'package:flutter_app/common/resources.dart';

class PhoneLoginPage extends StatefulWidget {
  @override
  State createState() {
    return _PhoneLoginState();
  }
}

class _PhoneLoginState extends State<PhoneLoginPage> {
  var loginBtnColor = ColorT.gray_66;

  var loginBtnTextColor = ColorT.gray_33;

  var isPassword = true; //是否显示密码

  var isShowCancelBtn = false; //是否显示删除站好的按钮

  TextEditingController userNameController = new TextEditingController();

  TextEditingController passWordController = new TextEditingController();

  FocusNode _focusNode = new FocusNode(); // 初始化一个FocusNode控件;

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    _focusNode.addListener(_focusNodeListener); // 初始化一个listener
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener); // 页面消失时必须取消这个listener！！
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    // 用async的方式实现这个listener
  }

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
                focusNode: _focusNode,
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
                  suffixIcon: Container(
                    padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    height: 45.0,
                    child: FlatButton(
                      onPressed: () {},
                      color: ColorT.theme_color,
                      child: Text(
                        "获取验证码",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                      return MinePage();
                    }));
                  },
                  child: Text("密码登陆"),
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
    if (userName.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              Dialog(
                child: new TipView("密码不能为空"),
              ));
      return;
    }
    //判断密码
    if (passWord.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              Dialog(
                child: new TipView("密码不能为空"),
              ));
      return;
    }
    var loginReq = {"username": userName, "password": passWord};
    HttpUtil.getInstance().get("pda/login", loginReq, (data) {
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

