import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/CareTakers/BreedingControl/breeding_control_caretaker_list.dart';
import 'package:horse_management/HMS/CareTakers/BreedingSales/breeding_sales_caretaker_list.dart';
import 'package:horse_management/HMS/CareTakers/Flushes/flushes_caretaker_list.dart';
import 'package:horse_management/HMS/CareTakers/SemenCollection/semen_collection_caretaker_list.dart';
import 'package:horse_management/HMS/Configuration/AccountCategories/accountcategories_list.dart';
import 'package:horse_management/HMS/Configuration/Associations/associations_list.dart';
import 'package:horse_management/HMS/Configuration/Barns/barn_list.dart';
import 'package:horse_management/HMS/Configuration/Breeds/breeds_list.dart';
import 'package:horse_management/HMS/Configuration/Colors/colors_list.dart';
import 'package:horse_management/HMS/Configuration/CostCenters/costcenter_list.dart';
import 'package:horse_management/HMS/Configuration/Currencies/currency_list.dart';
import 'package:horse_management/HMS/Configuration/GeneralCategories/generalcategories_list.dart';
import 'package:horse_management/HMS/Configuration/HorseCategories/horsecategory_list.dart';
import 'package:horse_management/HMS/Configuration/IronBrand/ironbrand_list.dart';
import 'package:horse_management/HMS/Configuration/Locations/location_list.dart';
import 'package:horse_management/HMS/Configuration/Markings/marking_list.dart';
import 'package:horse_management/HMS/Configuration/PerformanceType/performancetype_list.dart';
import 'package:horse_management/HMS/Configuration/Sire/sire_list.dart';
import 'package:horse_management/HMS/Configuration/TestTypes/testtype_list.dart';
import 'package:horse_management/HMS/Configuration/VaccinationTypes/vaccinationtypes_list.dart';
import 'package:horse_management/HMS/Configuration/Vaccines/add_vaccines.dart';
import 'package:horse_management/HMS/Configuration/Vaccines/vaccines_list.dart';
import 'package:horse_management/HMS/OperationNotes/add_new_operation_note.dart';
import 'package:horse_management/HMS/OperationNotes/operation_notes.dart';
import 'package:horse_management/HMS/Tanks/tanks.dart';
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
                      leading: Icon(Icons.settings,size: 40,),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () async{
                        SharedPreferences prefs= await SharedPreferences.getInstance();
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>breeding_control_caretaker_list(prefs.getString("token"))));
                      },
                    ),
                    ListTile(
                      title: Text("Breeding Sale"),
                      subtitle: Text("Sales"),
                      leading: Icon(Icons.attach_money,size: 40, color: Colors.green,),
                      trailing: Icon(Icons.arrow_right),
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>breeding_sales_caretaker_list(token)));
                      },
                    ),
                    ListTile(
                      title: Text("Flushes"),
                      subtitle: Text("Add Flushes"),
                      leading: Icon(Icons.flag,size: 40, color: Colors.lightGreenAccent,),
                      trailing: Icon(Icons.arrow_right),
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>flushes_caretaker_list(token)));
                      },
                    ),
                    ListTile(
                      title: Text("Semen Collection"),
                      subtitle: Text("Semen Collection"),
                      leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
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