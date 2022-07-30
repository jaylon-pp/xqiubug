import 'package:flutter/material.dart';
import 'package:xqiubug/api/apis.dart';

class TestUI extends StatefulWidget {
  const TestUI({Key? key}) : super(key: key);

  @override
  State<TestUI> createState() => _TestUIState();
}

class _TestUIState extends State<TestUI> {

  int uid = 6876843497;
  dynamic result;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    child = Column(
      children: [
        Text('uid: $uid'),
        ElevatedButton(onPressed: _getUserInfo, child: Text('userInfo')),
        ElevatedButton(onPressed: _getTimeline, child: Text('timeLine')),
        Text('$result'),
      ],
    );

    child = SingleChildScrollView(
      child: child,
    );

    child = Scaffold(
      appBar: AppBar(title: Text('test'),),
      body: child,
    );

    return child;
  }

  _getUserInfo() async {
    var ret = await XqService().api.userInfo(uid);
    setState(() {
      result = ret;
    });
  }

  _getTimeline() async {
    var ret = await XqService().api.userTimeline(uid, 1).catchError((e) {
      print('e: $e');
    });
    setState(() {
      result = ret;
    });
  }
}
