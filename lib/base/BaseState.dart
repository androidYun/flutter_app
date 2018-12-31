import 'package:flutter/widgets.dart';
import 'package:flutter_app/widget/Toast.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  toash(String resultMessage) {
    Toast.toast(this.context, resultMessage);
  }
}
