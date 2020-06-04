import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/CareTakers/Confirmation/confirmation_caretaker_list.dart';
import 'package:horse_management/HMS/CareTakers/Vaccination/vaccination_caretaker_list.dart';
import 'package:horse_management/HMS/CareTakers/VetVisit/vetVisits_caretaker_List.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/vetVisitsList.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'Confirmation/testing.dart';
class vet_category_mainpage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State();
  }

}
class _Profile_Page_State extends State<vet_category_mainpage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Veterinary Caretaker"),
//          actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.arrow_right,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => add_newHorse()),
//              );
//            },
//          )
//        ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text("Confirmation Caretaker"),
                    subtitle: Text("Add Confirmation"),
                    leading: FaIcon(FontAwesomeIcons.laptopMedical, color: Colors.grey.shade400, size: 30,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: ()async{
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>confirmation_caretaker_list(prefs.getString("token"))));
                    },
                  ),
                  ListTile(
                    title: Text("Vet Visit Caretaker"),
                    subtitle: Text("Add & Show Vet Visit"),
                    leading: FaIcon(FontAwesomeIcons.userMd, color: Colors.red.shade400, size: 30,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: ()async{
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>vetVisit_caretaker_List(prefs.getString("token"))));
                    },
                  ),
                  ListTile(
                    title: Text("Vaccination Caretaker"),
                    subtitle: Text("Add & Show Vaccinations"),
                    leading: FaIcon(FontAwesomeIcons.syringe, color: Colors.limeAccent.shade400, size: 30,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: ()async{
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>vaccination_caretaker_list(prefs.getString("token"))));
                    },
                  ),
//                  ListTile(
//                    title: Text("testing"),
//                    subtitle: Text("Add limb"),
//                    leading: Icon(Icons.speaker_notes,size: 40,),
//                    trailing: Icon(Icons.arrow_right),
//                    onTap: ()async{
//                      SharedPreferences prefs=await SharedPreferences.getInstance();
//                      Navigator.push(context,MaterialPageRoute(builder: (context)=>MyPets()));
//                    },
//                  ),

                ],
              ),
            ),
          ],
        )
    );
  }

}