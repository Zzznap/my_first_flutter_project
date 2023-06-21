import 'package:flutter/material.dart';

import 'login.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return createDraw(context);
  }
  Widget createDraw(BuildContext context){
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image(
                        image:
                        NetworkImage(
                          "https://img.paulzzh.tech/touhou/random",
                        ),
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children:  <Widget>[
                ListTile(
                  leading: const Icon(Icons.power_settings_new),
                  title: Text("退出登录"),
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text("提示"),
                            content: const Text("确定退出吗？"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("取消"),
                              ),
                              TextButton(
                                onPressed: () => {
                                  Navigator.pop(context),
                                  Navigator.pushAndRemoveUntil (context,
                                      MaterialPageRoute(builder: (context) {
                                        return loginPage();
                                      })
                                      , (route) => true)
                                },
                                child: const Text("确定"),
                              ),
                            ],
                          );
                        }).then((value) {
                      },
                    );
                  },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}