import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_management/MainScreens/home.dart';
import 'package:horse_management/MainScreens/main_screen.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/screens/Home_Page.dart';
import 'package:horse_management/screens/welcome_screen.dart';
import 'package:horse_management/util/theme_notifier.dart';
import 'package:horse_management/values/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]).then((_) {
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
      setState(() {
        if(response!=null)
       this.isLogin=response;
      });
    });
  }
  Widget checkLogin(){
    if(isLogin){
      return Home();
    }else
     return WelcomeScreen();
  }
}

