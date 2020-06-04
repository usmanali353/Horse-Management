import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/vetVisitsList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Confirmation/add_confirmation_form.dart';
import 'Confirmation/confirmation.dart';
//import 'Confirmation/testing.dart';
class vet_category extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State();
  }

}
class _Profile_Page_State extends State<vet_category>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Veterinary"),
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
                    title: Text("Confirmation List"),
                    subtitle: Text("Add Confirmation"),
                    leading: FaIcon(FontAwesomeIcons.laptopMedical, color: Colors.grey.shade400, size: 30,),
                    //leading: Icon(Icons.account_balance_wallet,size: 40,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: ()async{
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>confirmation_list(prefs.getString("token"))));
                    },
                  ),
                  ListTile(
                    title: Text("Vet Visit"),
                    subtitle: Text("Add Vet Visit"),
                    leading: FaIcon(FontAwesomeIcons.userMd, color: Colors.red.shade400, size: 30,),
                    //leading: Icon(Icons.speaker_notes,size: 40,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: ()async{
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>vetVisitList(prefs.getString("token"))));
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