import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'draw.dart';
class mytabBar extends StatefulWidget {
  const mytabBar({super.key,  required this.title});
  final String title;
  @override
  State<mytabBar> createState() => _mytabBarState();

}

class _mytabBarState extends State<mytabBar> {
  bool _isBackPressed = false;
  late DateTime _currentBackPressTime;
  final List<Tab> tab = <Tab>[
    const Tab(text: '首页'),
    const Tab(text: '商城'),
    const Tab(text: '学习'),
    const Tab(text: '学习'),
    const Tab(text: '学习'),
    const Tab(text: '学习'),
    const Tab(text: '学习'),
    const Tab(text: '学习'),

  ];
  Future<bool> _onWillPop() async {
    if (_isBackPressed) {
      SystemNavigator.pop(); // 返回到桌面
      return true;
    } else {
      _isBackPressed = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back button again to exit.'),
          duration: Duration(seconds: 2),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        _isBackPressed = false;
      });
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
    child: DefaultTabController(
      length: tab.length,

      child: Scaffold(

          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(widget.title),
        leading: Builder(builder: (context) {
        return IconButton(
              icon: Icon(Icons.dashboard, color: Colors.white), //自定义图标
              onPressed: () {
              // 打开抽屉菜单
              Scaffold.of(context).openDrawer();
              },
              );
              }),
            bottom: TabBar(
              // padding: EdgeInsets.all(10),
              isScrollable: true,
              tabs: tab,
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          drawer: const MyDrawer(),
          body:
            TabBarView(
              children: tab.map((Tab tab) {
              return Center(
                child: Text(tab.text!),
              );
            }).toList(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '首页',
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: '商城',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: '学习',
                backgroundColor: Colors.purple,
              ),
            ],
            currentIndex: 0,
            selectedItemColor: Colors.amber[800],
            onTap: (index) {
              if (kDebugMode) {
                print(index);
              }
            },
          )
      ),
    ),
    );
  }
}
