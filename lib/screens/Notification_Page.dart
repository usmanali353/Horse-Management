import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginScreen.dart';

class Notification_Page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _Notification_Page_State();
  }

}
class _Notification_Page_State extends State<Notification_Page>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Notifications"),
        actions: <Widget>[
          InkWell(
            onTap: () async{
              SharedPreferences prefs=await SharedPreferences.getInstance();
              prefs.remove("token");
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),(Route<dynamic> route) => false);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ListTile(
            title: Text("Notification Title"),
            subtitle: Text("Date"),
            leading: Icon(FontAwesomeIcons.bell,size: 50,),
            onTap: (){

            },
          ),
          ListTile(
            title: Text("Notification Title"),
            subtitle: Text("Date"),
            leading: Icon(FontAwesomeIcons.bell,size: 50,),
            onTap: (){
            },
          ),
          ListTile(
            title: Text("Notification Title"),
            subtitle: Text("Date"),
            leading: Icon(FontAwesomeIcons.bell,size: 50,),
            onTap: (){

            },
          ),
        ],
      ),
    );
  }
}