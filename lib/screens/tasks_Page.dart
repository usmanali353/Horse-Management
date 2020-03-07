
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/screens/loginScreen.dart';
import 'package:horse_management/screens/todays_tasks.dart';
import 'package:horse_management/screens/upcoming_tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tasks_Page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _tasks_Page_State();
  }

}
class _tasks_Page_State extends State<tasks_Page> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          actions: <Widget>[
            InkWell(
              onTap: () async{
                SharedPreferences prefs=await SharedPreferences.getInstance();
                prefs.remove("token");
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),(Route<dynamic> route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  FontAwesomeIcons.signOutAlt,
                  color: Colors.white,
                ),
              ),
            )
          ],
          title: Text("Tasks"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Todays Tasks"),
              Tab(text: "Upcoming Tasks",),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            todays_tasks(),
            upcoming_tasks()
          ],
        ),
      ),
    );

  }
}