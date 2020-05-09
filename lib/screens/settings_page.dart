import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/All_Horses_data/Horse_Videos/video_details.dart';
import 'package:horse_management/Model/theme_notifier.dart';
import 'package:horse_management/screens/welcome_screen.dart';
import 'package:horse_management/Model/theme.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Dark Theme'),
            contentPadding: const EdgeInsets.only(left: 16.0),
            trailing: Transform.scale(
              scale: 0.4,
              child: DayNightSwitch(
                value: _darkTheme,
                onChanged: (val) {
                  setState(() {
                    _darkTheme = val;
                  });
                  onThemeChanged(val, themeNotifier);
                },
              ),
            ),
          ),
          ListTile(
            title: Text("Sign Out"),
            trailing: Icon(FontAwesomeIcons.signOutAlt),
            onTap: ()async{
              SharedPreferences prefs=await SharedPreferences.getInstance();
              prefs.remove("token");
              prefs.remove("isLogin");
              prefs.remove("role");
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()),(Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text("Visit our Website"),
            trailing: Icon(Icons.http),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>video_details("http://192.236.147.77:8085/Account/Login")));
            },
          )
        ],
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
