import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/CareTakers/BreedingControl/breeding_control_caretaker_list.dart';
import 'package:horse_management/HMS/CareTakers/BreedingSales/breeding_sales_caretaker_list.dart';
import 'package:horse_management/HMS/CareTakers/Flushes/flushes_caretaker_list.dart';
import 'package:horse_management/HMS/CareTakers/SemenCollection/semen_collection_caretaker_list.dart';

import 'package:horse_management/animations/fadeAnimation.dart';

import 'package:shared_preferences/shared_preferences.dart';



class breeding_caretaker_Category extends StatefulWidget{
  String token;
  breeding_caretaker_Category(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _breeding_caretaker_Category(token);
  }
}


class _breeding_caretaker_Category extends State<breeding_caretaker_Category>{
  String token;
  _breeding_caretaker_Category(this.token);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Breeding Caretaker"),

        ),
        body: FadeAnimation(2.4,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: Text("Breeding Control"),
                      subtitle: Text("Control services"),
                      leading: FaIcon(FontAwesomeIcons.whmcs, color: Colors.grey.shade500, size: 40,),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () async{
                        SharedPreferences prefs= await SharedPreferences.getInstance();
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>breeding_control_caretaker_list(prefs.getString("token"))));
                      },
                    ),
                    ListTile(
                      title: Text("Breeding Sale"),
                      subtitle: Text("Sales"),
                      leading: FaIcon(FontAwesomeIcons.handHoldingUsd, color: Colors.green, size: 40,),
                      trailing: Icon(Icons.arrow_right),
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>breeding_sales_caretaker_list(token)));
                      },
                    ),
                    ListTile(
                      title: Text("Flushes"),
                      subtitle: Text("Add Flushes"),
                      leading: FaIcon(FontAwesomeIcons.seedling, color: Colors.lightGreenAccent, size: 30,),
                      trailing: Icon(Icons.arrow_right),
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>flushes_caretaker_list(token)));
                      },
                    ),
                    ListTile(
                      title: Text("Semen Collection"),
                      subtitle: Text("Semen Collection"),
                      leading: FaIcon(FontAwesomeIcons.warehouse, color: Colors.lightBlueAccent, size: 30,),
                      trailing: Icon(Icons.arrow_right),
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>semen_collection_caretaker_list(token)));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

}