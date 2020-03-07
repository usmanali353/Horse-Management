import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Operation%20Notes/add_new_operation_note.dart';
import 'package:horse_management/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class operational_noteList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _paddocks_State();
  }
}

class _paddocks_State extends State<operational_noteList>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Operation Notes"),
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
      ),
      body: Center(

        child: Column(

          children: <Widget>[

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         // Navigator.push(context,MaterialPageRoute(builder: (context)=>add_new_opertation_note()));
        },
        tooltip: 'Add New Operation Notes',
        child: Icon(Icons.add),
      ), // This trailing comma mak
    );
  }
}

