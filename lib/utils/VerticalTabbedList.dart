import 'package:flutter/material.dart';

class VerticalTabbedList extends StatefulWidget {
  @override
  _VerticalTabbedListState createState() => _VerticalTabbedListState();
}

class _VerticalTabbedListState extends State<VerticalTabbedList> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = ['Tab 1', 'Tab 2', 'Tab 3'];

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
                  onTap: () {
                    _tabController.animateTo(tabs.indexOf(tab));
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

void main() {
  runApp(MaterialApp(
    home: VerticalTabbedList(),
  ));
}
