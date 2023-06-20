import 'package:flutter/material.dart';

class VerticalTabbedList extends StatefulWidget {
  @override
  _VerticalTabbedListState createState() => _VerticalTabbedListState();
}

class _VerticalTabbedListState extends State<VerticalTabbedList> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;
  final List<String> tabs = ['ops', 'ops2', 'ops3'];
  final List<String> tabsView1 = ['史洋洋', '徐熠州', '吴维','丁承霄','李松'];
  final List<String> tabsView2 = ['史洋洋2', '徐熠州2', '吴维2','丁承霄2','李松2'];
  final List<String> tabsView3 = ['史洋洋3', '徐熠州3', '吴维3','丁承霄3','李松3'];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vertical Tabbed List'),
      ),
      body: Row(
        children: [
          Container(
            width: 120,
            child: ListView(
              children: tabs.map((String tab) {
                return ListTile(
                  title: Text(tab),
                  selected: tabs.indexOf(tab) == selectedIndex,
                  onTap: () {
                    setState(() {
                      selectedIndex = tabs.indexOf(tab);
                    });
                    _tabController.animateTo(
                        tabs.indexOf(tab),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabs.map((String tab) {
                return Center(
                  child: Text(tab),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('垂直导航栏'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // 处理第一个标签按钮的点击事件
            },
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.blue,
              child: Text(
                '标签按钮1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // 处理第二个标签按钮的点击事件
            },
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.green,
              child: Text(
                '标签按钮2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // 处理第三个标签按钮的点击事件
            },
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.orange,
              child: Text(
                '标签按钮3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // 其他标签按钮
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VerticalTabbedList(),
  ));
}

