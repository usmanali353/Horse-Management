import 'package:flutter/material.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/screens/Home_Page.dart';
import 'package:horse_management/screens/welcome_screen.dart';




void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myAppState();
  }
}
class myAppState extends State<MyApp>{
  bool isLogin=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horse Management System',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
      ),
      home: checkLogin(),
    );
  }

  @override
  void initState() {
    Utils.isLogin().then((response){
      setState(() {
        if(response!=null)
       this.isLogin=response;
      });
    });
  }
  Widget checkLogin(){
    if(isLogin){
      return Home_Page();
    }else
     return WelcomeScreen();
  }
}

