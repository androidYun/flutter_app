import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/base/BaseState.dart';

class SetPasswordVerificationCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SetPasswordVerificationCodeState();
  }
}

class SetPasswordVerificationCodeState
    extends State<SetPasswordVerificationCodePage> {
  TextEditingController versionCodeController = new TextEditingController();

  int time = 0;

  String versionText = "获取验证码";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("验证手机"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Text("1399264430225", textAlign: TextAlign.left),
          ),
          const Divider(height: 1.0),
          Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      onChanged: (versionCode) {},
                      controller: TextEditingController(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "请输入短信验证码",
                      ),
                    ),
                  ),
                  FlatButton(
                      color: Colors.red,
                      onPressed: () {
                        _getVersionCode();
                      },
                      child: Text(
                        versionText,
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              )),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey,
            ),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: FlatButton(
                onPressed: () {
                  print('输入');
                },
                child: Text("下一步")),
          )
        ],
      ),
    );
  }

  Timer timer;

  @override
  void dispose() {
    if (time == null) {
      timer.cancel();
    }
    super.dispose();
  }

  _getVersionCode() {
    if (timer!=null&&timer.isActive) {
      return;
    }
    time = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (time == 0) {
        timer.cancel();
        timer = null;
      }
      setState(() {
        versionText = _getVersionText();
      });
      time--;
    });
  }

  String _getVersionText() {
    if (time == 0) {
      return "获取验证码";
    } else {
      return "$time重新获取";
    }
  }
}
