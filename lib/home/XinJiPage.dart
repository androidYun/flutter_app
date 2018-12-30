import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class XinJiPage extends StatefulWidget {
  @override
  State createState() {
    return XinJiPageState();
  }
}

class XinJiPageState extends State<XinJiPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
          child: FlatButton(
              onPressed: () {
                jumpActivity();
              },
              child: Text("新机跳转"))),
    );
  }

  static const jumpPlugin =
      const MethodChannel("com.example.flutterapp.plugin");

  jumpActivity() async {
    Map<String, String> map = {"name": "李前进", "age": "18"};
    String result = await jumpPlugin.invokeMethod('oneAct', map);
  }
  static const counterPlugin = const EventChannel('com.example.flutterapp.plugin');

  StreamSubscription _subscription = null;


  @override
  void initState() {
    super.initState();
    //开启监听
    if(_subscription == null){
      _subscription =  counterPlugin.receiveBroadcastStream().listen(_onEvent,onError: _onError);
    }
  }

  @override
  void dispose() {
    super.dispose();
    //取消监听
    if(_subscription != null){
      _subscription.cancel();
    }
  }
  void _onEvent(Object event) {
    setState(() {
      print("ChannelPage: $event");
    });
  }

  void _onError(Object error) {
    setState(() {
      print(error);
    });
  }

}
