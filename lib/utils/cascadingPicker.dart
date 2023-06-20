import 'package:flutter/material.dart';

class CascadingDropdown extends StatefulWidget {
  @override
  _CascadingDropdownState createState() => _CascadingDropdownState();
}

class _CascadingDropdownState extends State<CascadingDropdown>  with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  void _toggleVisibility() {
    addWeight();
    setState(() {
      _isVisible = !_isVisible;
      //
      // if (_isVisible) {
      //   _animationController.forward();
      // } else {
      //   _animationController.reverse();
      // }
    });
  }
  void addWeight() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        var date = DateTime.now();
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(16.0),
          child: Column(
              children: [
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("选择水印"),
                      ElevatedButton(onPressed: (){

                        },
                          child: Text("确定") ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2, // 你的项数
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text('Item $index'),
                                );
                              },
                            ),
                          ),

                        ),
                      ),
                      Expanded(
                        child: Container(
                            color: Color.fromRGBO(248,248,250, 1),
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 2, // 你的项数
                                itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text('Item $index'),
                                  );
                                },
                              ),
                            ),
                        ),
                      ),
                    ],
                ),
                ),
              ],
          )

        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('级联选择器'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: addWeight,
              child: Text('选择水印'),
            ),
          ),
        ],
      ),
    );
    }

}
