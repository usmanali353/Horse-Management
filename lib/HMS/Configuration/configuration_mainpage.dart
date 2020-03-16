import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
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
import 'package:horse_management/HMS/Configuration/Vaccines/vaccines_list.dart';
import 'package:shared_preferences/shared_preferences.dart';


class configuration_Category extends StatefulWidget{
  String token;
  configuration_Category(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _configuration_Category(token);
  }
}


class _configuration_Category extends State<configuration_Category>{
  String token;
  _configuration_Category(this.token);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Configuration"),

        ),
        body: ListView(

                children: <Widget>[
                  ListTile(
                    title: Text("Barn"),
                    subtitle: Text("Add Barn"),
                    leading: Icon(Icons.settings,size: 40,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () async{
                      SharedPreferences prefs= await SharedPreferences.getInstance();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>barn_list(prefs.getString("token"))));
                    },
                  ),
                  ListTile(
                    title: Text("Sire"),
                    subtitle: Text("Add Sire"),
                    leading: Icon(Icons.build,size: 40, color: Colors.black,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>sire_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Dam"),
                    subtitle: Text("Add Dam"),
                    leading: Icon(Icons.attach_money,size: 40, color: Colors.green,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                     //Navigator.push(context,MaterialPageRoute(builder: (context)=>ironbrand_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Breeds"),
                    subtitle: Text("Add Breed"),
                    leading: Icon(Icons.all_inclusive,size: 40,color: Colors.amberAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>breeds_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Colors"),
                    subtitle: Text("Add Color"),
                    leading: Icon(Icons.local_florist,size: 40,color: Colors.redAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                     Navigator.push(context,MaterialPageRoute(builder: (context)=>colors_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Markings"),
                    subtitle: Text("Add Markings"),
                    leading: Icon(Icons.flag,size: 40, color: Colors.lightGreenAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                   Navigator.push(context,MaterialPageRoute(builder: (context)=>marking_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Iron Brand"),
                    subtitle: Text("Add Iron Brand"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>ironbrand_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Horse Categories"),
                    subtitle: Text("Add Horse Categories"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>horsecategory_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("General Categories"),
                    subtitle: Text("Add General Categories"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>generalcategory_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Locations"),
                    subtitle: Text("Add Locations"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>location_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Vaccines"),
                    subtitle: Text("Add Vaccines"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>vaccines_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Vaccination Types"),
                    subtitle: Text("Add Vaccination Types"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>vaccinationtypes_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Test Types"),
                    subtitle: Text("Add Test Types"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>testtype_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Performance Types"),
                    subtitle: Text("Add Performance Types"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>performancetype_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Associations"),
                    subtitle: Text("Add Associations"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>associations_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Account Categories"),
                    subtitle: Text("Add Account Categories"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>accountcategories_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Cost Centers"),
                    subtitle: Text("Add Cost Centers "),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>costcenter_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Currencies"),
                    subtitle: Text("Add Currencies"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>currency_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Scoring"),
                    subtitle: Text("Add Scoring"),
                    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                     // Navigator.push(context,MaterialPageRoute(builder: (context)=>scoring_list(token)));
                    },
                  ),
                ],
              ),
            );

  }

}