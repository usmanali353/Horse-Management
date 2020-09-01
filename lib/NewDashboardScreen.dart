import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/All_Horses_data/all_horse_data_add.dart';
import 'package:horse_management/HMS/Contacts/contacts_list.dart';
import 'package:horse_management/HMS/HorseGroups/horseGroup_list.dart';
import 'package:horse_management/HMS/OperationNotes/operation_notes.dart';
import 'package:horse_management/HMS/Paddock/paddocks.dart';
import 'package:horse_management/HMS/Tanks/tanks.dart';
import 'package:horse_management/NewHomeScreen.dart';
import 'package:horse_management/screens/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';


class NewDashboardScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewDashboardScreen_State();
  }

}

class _NewDashboardScreen_State extends State<NewDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
//        appBar: AppBar(
//          title: Text("RetroPortal Studio"),
//          backgroundColor: Colors.deepOrangeAccent,
//        ),
        //Adding SpinCircleBottomBarHolder to body of Scaffold
        body: SpinCircleBottomBarHolder(
          bottomNavigationBar: SCBottomBarDetails(
              circleColors: [Colors.transparent, Colors.transparent, Colors.white10],

              iconTheme: IconThemeData(color: Colors.black),
              activeIconTheme: IconThemeData(color: Colors.teal.shade700, size: 35),
              backgroundColor: Colors.white,
              titleStyle: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold),
              activeTitleStyle: TextStyle(color: Colors.teal.shade700,fontSize: 15,fontWeight: FontWeight.bold),
              actionButtonDetails: SCActionButtonDetails(

                  color: Colors.teal.shade700,
                  icon: Icon(
                    Icons.expand_less,
                    color: Colors.white,
                  ),
                  //elevation: 2
              ),
             // elevation: 1.0,
              items: [
                // Suggested count : 4
                SCBottomBarItem(icon: FontAwesomeIcons.horseHead, title: "Horses", onPressed: () async {
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> all_horse_data(prefs.getString("token")) ));
                }),
                SCBottomBarItem(icon: FontAwesomeIcons.monument, title: "Tanks", onPressed: () async {
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> tanks_list(prefs.getString('token')) ));
                }),
                SCBottomBarItem(icon: FontAwesomeIcons.phoneAlt, title: "Contacts", onPressed: () async {
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> contacts_list(prefs.getString('token')) ));

                }),
                SCBottomBarItem(icon: FontAwesomeIcons.tools, title: "Settings", onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
                }
                  ),
              ],
              circleItems: [
                //Suggested Count: 3
                SCItem(icon: Icon(FontAwesomeIcons.objectGroup, color: Colors.teal), onPressed: () async {
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> horseGroup_list(prefs.getString('token')) ));
                }),
                SCItem(icon: Icon(FontAwesomeIcons.solidStickyNote, color: Colors.teal), onPressed: () async {
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> operational_noteList(prefs.getString('token')) ));
                }),

                SCItem(icon: Icon(FontAwesomeIcons.landmark, color: Colors.teal), onPressed: () async {
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> paddocks_list(prefs.getString('token')) ));
                }),
              ],
              bnbHeight: 80 // Suggested Height 80
          ),
          child: Container(
            child: NewHomeScreen(),
          ),
        ),
      ),
    );
  }
}