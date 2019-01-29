import 'package:flutter/material.dart';
import 'package:flutter_app/HttpUtil.dart';
import 'package:flutter_app/base/BaseState.dart';

class BillPage extends StatefulWidget {
  @override
  State createState() {
    return BillState();
  }
}

class BillState extends BaseState<BillPage> {
  var billList = List();

  var data = {
    "maxAmount": null,
    "pageIndex": 0,
    "pageSize": 20,
    "statusList": null,
    "tradeTypeList": null,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Null> _onRefresh() async {
    HttpUtil.getInstance().post("sj-api/v2/transaction/query", data, (data) {
      setState(() {
        billList.add(data["data"]);
      });
    }, (resultMessage) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text("账单"), Icon(Icons.search)],
      )),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(0.0, 30, 16.0, 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[Text("交易筛选"), Icon(Icons.arrow_drop_down)],
            ),
          ),
          Flexible(
              child: RefreshIndicator(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: billList.length,
                      itemBuilder: (context, index) {
                        return _itemView(billList[index]);
                      }),
                  onRefresh: _onRefresh))
        ],
      ),
    );
  }

  Widget _itemView(dynamic data) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[_monthItemView(data["month"],data["outgoingTotal"],data["incomeTotal"])],
        )
      ],
    );
  }

  Widget _monthItemView(int month,num expend,num income) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text("$month月份"), Icon(Icons.date_range)],
          ),
          Row(
            children: <Widget>[
              Text("支出: ¥$expend 收入: ¥$income")
            ],
          )
        ],
      ),
    );
  }
}
