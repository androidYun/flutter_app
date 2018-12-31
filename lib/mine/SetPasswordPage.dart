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
    extends BaseState<SetPasswordVerificationCodePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("验证手机"),
      ),
      body: Center(
        child: Text("设置密码"),
      ),
    );
  }
}
