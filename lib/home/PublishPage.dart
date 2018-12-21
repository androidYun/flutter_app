import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PublishPage extends StatefulWidget {
  @override
  State createState() {
    return PublishPageState();
  }
}

class PublishPageState extends State<PublishPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Text("发布"),
      ),
    );
  }
}
