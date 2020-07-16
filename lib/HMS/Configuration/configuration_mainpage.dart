import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Configuration/AccountCategories/category_list_search.dart';
import 'package:horse_management/HMS/Configuration/Associations/associations_list.dart';
import 'package:horse_management/HMS/Configuration/Barns/barn_list.dart';
import 'package:horse_management/HMS/Configuration/Breeds/breeds_list.dart';
import 'package:horse_management/HMS/Configuration/Colors/colors_list.dart';
import 'package:horse_management/HMS/Configuration/CostCenters/costcenter_list.dart';
import 'package:horse_management/HMS/Configuration/Currencies/currency_list.dart';
import 'package:horse_management/HMS/Configuration/Dam/dam_list.dart';
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
import 'package:horse_management/animations/fadeAnimation.dart';
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
        body: FadeAnimation(2.0,
           Scrollbar(
             child: ListView(

                    children: <Widget>[
                      ListTile(
                        title: Text("Barn"),
                        subtitle: Text("Add Barn"),
                        leading: FaIcon(FontAwesomeIcons.houzz, color: Colors.grey.shade400, size: 30,),
                        //leading: Icon(Icons.home,size: 40,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () async{
                          SharedPreferences prefs= await SharedPreferences.getInstance();
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>barn_list(prefs.getString("token"))));
                        },
                      ),
                      ListTile(
                        title: Text("Sire"),
                        subtitle: Text("Add Sire"),
                        leading: FaIcon(FontAwesomeIcons.horseHead, color: Colors.brown.shade300, size: 30,),
                        //leading: Icon(Icons.pets,size: 40, color: Colors.greenAccent,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>sire_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Dam"),
                        subtitle: Text("Add Dam"),
                        leading: FaIcon(FontAwesomeIcons.horse, color: Colors.pink.shade200, size: 30,),
                        //leading: Icon(Icons.local_convenience_store,size: 40, color: Colors.green,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                         Navigator.push(context,MaterialPageRoute(builder: (context)=>dam_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Breeds"),
                        subtitle: Text("Add Breed"),
                        leading: FaIcon(FontAwesomeIcons.venusMars, color: Colors.purple.shade300, size: 30,),
                        //leading: Icon(Icons.all_inclusive,size: 40,color: Colors.amberAccent,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>breeds_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Colors"),
                        subtitle: Text("Add Color"),
                        leading: FaIcon(FontAwesomeIcons.palette, color: Colors.red.shade400, size: 30,),

                        //leading: Icon(Icons.local_florist,size: 40,color: Colors.redAccent,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                         Navigator.push(context,MaterialPageRoute(builder: (context)=>colors_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Markings"),
                        subtitle: Text("Add Markings"),
                        leading: FaIcon(FontAwesomeIcons.ribbon, color: Colors.blue.shade400, size: 30,),

                        // leading: Icon(Icons.flag,size: 40, color: Colors.lightGreenAccent,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context)=>marking_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Iron Brand"),
                        subtitle: Text("Add Iron Brand"),
                        leading: Icon(Icons.donut_large,size: 40, color: Colors.blueGrey,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>ironbrand_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Horse Categories"),
                        subtitle: Text("Add Horse Categories"),
                        leading: FaIcon(FontAwesomeIcons.chessKnight, color: Colors.deepOrange.shade300, size: 30,),
                        //leading: Icon(Icons.format_list_numbered,size: 40, color: Colors.deepOrange.shade300,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>horsecategory_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("General Categories"),
                        subtitle: Text("Add General Categories"),
                        leading: Icon(Icons.format_list_bulleted,size: 40, color: Colors.deepPurple.shade400,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>generalcategory_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Locations"),
                        subtitle: Text("Add Locations"),
                        leading: Icon(Icons.location_on,size: 40, color: Colors.red.shade800,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>location_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Vaccines"),
                        subtitle: Text("Add Vaccines"),
                        leading: FaIcon(FontAwesomeIcons.syringe, color: Colors.limeAccent.shade400, size: 30,),
                        //leading: Icon(Icons.enhanced_encryption,size: 40, color: Colors.green,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>vaccines_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Vaccination Types"),
                        subtitle: Text("Add Vaccination Types"),
                        leading: FaIcon(FontAwesomeIcons.vials, color: Colors.pinkAccent.shade200, size: 30,),

                        //leading: Icon(Icons.local_hospital,size: 40, color: Colors.pinkAccent,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>vaccinationtypes_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Test Types"),
                        subtitle: Text("Add Test Types"),
                        leading: Icon(Icons.assignment,size: 40, color: Colors.brown.shade500,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>testtype_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Performance Types"),
                        subtitle: Text("Add Performance Types"),
                        leading: FaIcon(FontAwesomeIcons.superpowers, color: Colors.teal.shade200, size: 40,),
                        //leading: Icon(Icons.library_books,size: 40, color: Colors.tealAccent,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>performancetype_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Associations"),
                        subtitle: Text("Add Associations"),
                        leading: FaIcon(FontAwesomeIcons.centos, color: Colors.redAccent.shade400, size: 40,),

                        //leading: Icon(Icons.shopping_basket,size: 40, color: Colors.redAccent,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>associations_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Account Categories"),
                        subtitle: Text("Add Account Categories"),
                        leading: FaIcon(FontAwesomeIcons.moneyCheck, color: Colors.teal.shade400, size: 40,),

                        //leading: Icon(Icons.category,size: 40, color: Colors.cyan,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchList(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Cost Centers"),
                        subtitle: Text("Add Cost Centers "),
                        leading: FaIcon(FontAwesomeIcons.moneyBillAlt, color: Colors.green, size: 40,),

                        //leading: Icon(Icons.polymer,size: 40, color: Colors.yellow,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>costcenter_list(token)));
                        },
                      ),
                      ListTile(
                        title: Text("Currencies"),
                        subtitle: Text("Add Currencies"),
                        leading: FaIcon(FontAwesomeIcons.coins, color: Color(0xFFd4af37), size: 40,),
                        trailing: Icon(Icons.arrow_right),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>currency_list(token)));
                        },
                      ),
//                    ListTile(
//                      title: Text("Scoring"),
//                      subtitle: Text("Add Scorings"),
//                      leading: Icon(Icons.score,size: 40, color: Colors.blueAccent,),
//                      trailing: Icon(Icons.arrow_right),
//                      onTap: (){
//                       // Navigator.push(context,MaterialPageRoute(builder: (context)=>scoring_list(token)));
//                      },
//                    ),
                    ],
                  ),
           ),
        ),
            );

  }

}