import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_management/Model/theme_notifier.dart';
import 'package:horse_management/screens/ContactHome.dart';
import 'package:horse_management/screens/home.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/screens/splashScreen.dart';
import 'package:horse_management/screens/welcome_screen.dart';
import 'package:horse_management/Model/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HMS/Contacts/ContactDashboard.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
//  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values)
  SystemChrome.setEnabledSystemUIOverlays((SystemUiOverlay.values)).then((_) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('darkMode') ?? true;
      runApp(
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
          child: MyApp(),
        ),
      );
    });
  });
}
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myAppState();
  }
}
class myAppState extends State<MyApp>{
  bool isLogin=false;
  String userRole='admin';
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horse Management System',
      theme: themeNotifier.getTheme(),
      home: checkLogin(),
    );
  }

  @override
  void initState() {
    Utils.isLogin().then((response){
      if(response!=null){
        setState(() {
          this.isLogin=response;
        });
        Utils.GetRole().then((role){
          if(role!=null){
            setState(() {
              this.userRole=role;
            });
          }
        });
      }
    });
  }
  Widget checkLogin(){
    if(isLogin&&userRole=='user'){
      return ContactHome();
    } if(isLogin&&userRole=='admin'){
      return Home();
    }else
      return WelcomeScreen();
  }
}

