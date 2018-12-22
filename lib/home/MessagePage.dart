import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/resources.dart';

class MessagePage extends StatefulWidget {
  @override
  State createState() {
    return MessagePageState();
  }
}

class MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("消息中心"),
        ),
        body: Container(
          color: ColorT.bg,
          child: Column(
            children: <Widget>[
              buildItemView("交易消息", "icon_transaction_new.png"),
              buildItemView("通知消息", "ic_notification_message.png"),
              buildItemView("商家聊天", "ic_merchant_chat.png")
            ],
          ),
        ));
  }

  buildItemView(String content, String imgRes) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Image.asset(
            "images/$imgRes",
            width: 50,
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
            child: Text(content),
          )
        ],
      ),
    );
  }
}
