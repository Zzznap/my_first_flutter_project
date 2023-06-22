import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';



///程序入口
void main() => runApp(RootApp());

class RootApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RottAppState();
  }

}

class RottAppState extends State<RootApp>{

  ///根布局的初始化
  @override
  void initState() {
    super.initState();
    ///创建 JPush
    JPush jpush = new JPush();
    ///配置应用 Key
    jpush.setup(
      appKey: "替换成你自己的 appKey",
      channel: "theChannel",
      production: false,
      /// 设置是否打印 debug 日志
      debug: true,
    );
  }
  @override
  Widget build(BuildContext context) {

    ///来构建
    return MaterialApp(
      ///应用程序默认显示的页面
      home: RootApp(),
    );
  }

}