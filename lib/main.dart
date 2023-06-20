import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_first_flutter_project/utils/VerticalTabbedList.dart';
import 'package:my_first_flutter_project/utils/cascadingPicker.dart';
import '/widget/selectImage.dart';

import 'TabBar.dart';
import 'login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      // home: const WaterFall(title: 'ZZ の Flutter'),
      home: VerticalTabbedList (),
      routes: {
        '/login': (context) => loginPage(),
        '/tabBar': (context) => mytabBar(title: "longin",),
      },
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // State<MyHomePage> createState() => _MyHomePageState();
  State<MyHomePage> createState(){
    print(this.toString()+'createState()');
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _counterSpeed = 1;
  Timer? _debounceTimer;
  void _refreshValue(){
    setState(() {
      _counterSpeed = 1;
      _counter = 0;
    });
  }
  void _incrementCounter() {
    setState(() {
      _counter+=_counterSpeed;
      _debounceTimer?.cancel();
      _debounceTimer = Timer(Duration(milliseconds: 500), () {
        setState(() {
          print('$_counterSpeed => 1');
          _counterSpeed = 1;
        });
      });
      _counterSpeed ++;
    });
  }
  @override
  void initState() {
    super.initState();
    print('子组件：initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('子组件：didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('子组件：didUpdateWidget');
  }

  @override
  void dispose() {
    super.dispose();
    _debounceTimer?.cancel();
    print('子组件：dispose 销毁时触发');
  }

  @override
  Widget build(BuildContext context) {
    print('子组件：build 渲染刷新时触发');
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: const FractionalOffset(0.0,1.0),
              child: FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
            Align(
              alignment: const FractionalOffset(1.0,1.0),
              child: FloatingActionButton(
                onPressed: _refreshValue,
                tooltip: 'Refresh',
                child: const Icon(Icons.refresh),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
