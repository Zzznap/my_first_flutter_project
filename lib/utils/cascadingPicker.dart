import 'package:flutter/material.dart';
import 'package:my_first_flutter_project/utils/VerticalTabbedList.dart';

class CascadingDropdown extends StatefulWidget {
  final  callback;

  const CascadingDropdown({this.callback});

  @override
  _CascadingDropdownState createState() => _CascadingDropdownState();
}

class _CascadingDropdownState extends State<CascadingDropdown>  with SingleTickerProviderStateMixin{

  int selectedIndex = 0;
  late TabController _tabController;
  final List<String> tabs = ['ops', 'ops2', 'ops3'];
  final List<Map<String,bool>> tabsView= [];
  final List<String> selected=[];
  bool _isVisible = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    tabsView.add({'史洋洋':false, '徐熠州':false, '吴维':false,'丁承霄':false,'李松':false} );
    tabsView.add({'史洋洋2':false, '徐熠州2':false, '吴维2':false,'丁承霄2':false,'李松2':false} );
    tabsView.add({'史洋洋3':false, '徐熠州3':false, '吴维3':false,'丁承霄3':false,'李松3':false} );

  }
  void changeSelect(String tab,String name){
    setState(() {
      if (selected.contains(name))
        selected.remove(name);
      else
        selected.add(name);
      tabsView[tabs.indexOf(tab)][name] = !tabsView[tabs.indexOf(tab)][name]!;
      widget.callback(selected);
    });
    print(selected);
  }
  Widget getTabsView(String tab, StateSetter state){
    return ListView(
      children: tabsView[tabs.indexOf(tab)].keys.map((String name) {
        return ListTile(
          title: Text(name),
          selected: tabsView[tabs.indexOf(tab)][name]!,
          onTap: () {
            state(() {
              changeSelect(tab,name);
            });
          },
        );
      }).toList(),
    );
  }
  @override
  void dispose() {
    _tabController.dispose();
    // _animationController.dispose();
    super.dispose();
  }
  void changeSelectedIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  Widget tabSMainView(StateSetter state){
    return Row(
      children: [
        Expanded(
          child: ListView(
            children: tabs.map((String tab) {
              return ListTile(
                title: Text(tab),
                selected: tabs.indexOf(tab) == selectedIndex,
                onTap: () {
                  state(() {
                    changeSelectedIndex(tabs.indexOf(tab));
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
              return getTabsView(tab,state);
            }).toList(),
          ),
        ),
      ],
    );

  }

  void addWeight() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) => StatefulBuilder(
      builder: (context,setState) {
        var date = DateTime.now();
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(16.0),
          child: Column(
              children: [
                Expanded(

                  child: Container(
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: ListView(
                        children: [
                          Text("选择水印文字:",style: TextStyle(fontSize: 20),),
                          Text(selected.join(',')),
                        ],
                      )),
                      Expanded(
                        child: ElevatedButton(onPressed: (){

                              },
                          child: Text("确定") ),),
                    ],
                  ),)
                ),
                Expanded(
                    child: tabSMainView(setState),
                )

              ],
          )

        );
      },)
    );
  }
  Widget? addTabList(BuildContext context){
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: addWeight,
      child: Text('选择水印'),
    );
    }

}
// void main() {
//   runApp(MaterialApp(
//     home: CascadingDropdown(selected: [], updateSelectedWaterMark: (List<String> ) {  },),
//   ));
// }
