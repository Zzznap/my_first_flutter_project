import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'TabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}
class _loginPageState extends State<loginPage>{
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  @override
  void initState() {
    super.initState();
    loadLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登陆'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: TextEditingController(text: _email),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: '账号'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '输入账号';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                controller: TextEditingController(text: _password),

                obscureText: true,
                decoration: const InputDecoration(labelText: '密码'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '请输入密码';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 16.0),
              RememberPassword(),
              LoginButton(),

            ],
          ),
        ),
      ),
    );
  }
  Widget RememberPassword(){
    return Row(
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: (value) {
            setState(() {
              rememberMe = value!;
            });
          },
        ),
        Text('记住密码'),
      ],
    );
  }
  Widget LoginButton(){
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState?.save();
          // 这里可以编写处理登录逻辑的代码
          saveLoginInfo();
          Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder:  (context, animation, secondaryAnimation) => const mytabBar(title: '主界面',),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  }
              )
          );
          print('账号: $_email');
          print('密码: $_password');
        }
      },
      child: Text('登陆'),
    );

  }
  // 读取SharedPreferences中保存的登录信息
  void loadLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMeValue = prefs.getBool('rememberMe') ?? false;
    setState(() {
      rememberMe = rememberMeValue;
    });
    print("--------loadLoginInfo--------");
    print(rememberMe);

    if(rememberMeValue){
      String emailValue = prefs.getString('email') ?? '';
      String passwordValue = prefs.getString('password') ?? '';
      setState(() {
        _email = emailValue;
        _password = passwordValue;
        print(_email);
        print(_password);
      });
    }
  }
  void saveLoginInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', rememberMe);
    print("--------saveLoginInfo--------");
    print(rememberMe);
    print(_email);
    print(_password);
    if(rememberMe) {
      prefs.setString('email', _email);
      prefs.setString('password', _password);
    }
  }
}