import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/All_Horses_data/Horse_Notes/notes_list.dart';
import 'package:horse_management/HMS/All_Horses_data/Horse_Videos/horse_videos_list.dart';
import 'package:horse_management/HMS/All_Horses_data/Movement/movement.list.dart';
import 'package:horse_management/HMS/All_Horses_data/competetion/competetion_list.dart';
import 'package:horse_management/HMS/All_Horses_data/farrier/farrierList.dart';
import 'package:horse_management/HMS/All_Horses_data/lab_reports/lab_test_list.dart';
import 'package:horse_management/HMS/All_Horses_data/services/add_horse_services.dart';
import 'package:horse_management/HMS/All_Horses_data/swabbing/swabbing_list.dart';
import 'package:horse_management/HMS/All_Horses_data/vaccination/vaccination_list.dart';
import 'package:horse_management/HMS/All_Horses_data/weight_hieght/hieght_weight_list.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'health_record/health_record_list.dart';
import 'horse_picture/picture_list.dart';
import 'incomeExpense/income_expense_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class all_horse_data extends StatefulWidget{
  String token;


  all_horse_data (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<all_horse_data>{
  String token;
  SharedPreferences prefs;
  var parsedjson;
  _Profile_Page_State (this.token);


  @override
  void initState () {
    Add_horse_services.horselist(token).then((response){
      // print(response.length.toString());
      if(response!=null){
        setState(() {
          //var parsedjson = jsonDecode(response);
          parsedjson  = jsonDecode(response);
          print(parsedjson);
          //print(horse_list['createdBy']);
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("All Horse Data"),
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
        body: SingleChildScrollView(

          child: FadeAnimation(2.0,
             Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//              ListTile(
//                title: Text("All Horses list"),
//                //(training_list!=null?training_list[index]['targetCompetition'].toString():''
//                subtitle: Text("Add new Horse"),
//                leading: Icon(Icons.account_balance_wallet,size: 40,),
//                trailing: Icon(Icons.arrow_right),
//                onTap: ()async{
////                  print(horsedata != null?horsedata['allIncomeAndExpenses'][0]['amount'].toString():'');
////                  print(horsedata != null?horsedata['allIncomeAndExpenses'].toString():'');
//                  Navigator.push(context,MaterialPageRoute(builder: (context)=>horse_list(token)));
//                },
//              ),
                ListTile(
                  title: Text("Income & Expense"),
                  //(training_list!=null?training_list[index]['targetCompetition'].toString():''
                  subtitle: Text("Track Your Expense"),
                  leading: Icon(Icons.account_balance_wallet,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: ()async{
//                  print(horsedata != null?horsedata['allIncomeAndExpenses'][0]['amount'].toString():'');
//                  print(horsedata != null?horsedata['allIncomeAndExpenses'].toString():'');
                    prefs =await SharedPreferences.getInstance();
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>income_expense_list(token)));
                  },
                ),
                ListTile(
                  title: Text("Notes"),
                  subtitle: Text("manage note on horse"),
                  leading: Icon(FontAwesomeIcons.stickyNote,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>notes_list(token)));
                  },
                ),
                ListTile(
                  title: Text("Image"),
                  subtitle: Text("Add image on this horse"),
                  leading: Icon(FontAwesomeIcons.images,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>pictures_list(token)));
                  },
                ),
                ListTile(
                  title: Text("Videos"),
                  subtitle: Text("All Horse Videos"),
                  leading: Icon(FontAwesomeIcons.video,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>horse_videos_list(token)));
                  },
                ),
                ListTile(
                  title: Text("Lab Report"),
                  subtitle: Text("Add Report on this horse"),
                  leading: Icon(FontAwesomeIcons.notesMedical,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: ()async{
                    prefs =await SharedPreferences.getInstance();
                    //print(horsedata['horseId']);
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>lab_list(token)));
                  },
                ),
                ListTile(
                  title: Text("Health Record"),
                  subtitle: Text("Add Health Record on this horse"),
                  leading: Icon(FontAwesomeIcons.solidStickyNote,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>healthRecord_list(token)));
                  },
                ),
                ListTile(
                  title: Text("Weight & Hieght"),
                  subtitle: Text("Add & Update Weight Hieght"),
                  leading: Icon(FontAwesomeIcons.weight,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>weight_hieght_list(token)));
                  },
                ),
                ListTile(
                  title: Text("Farrier"),
                  subtitle: Text("Add & Update farrier"),
                  leading: Icon(FontAwesomeIcons.storeAlt,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>farrier_list(token)));
                  },
                ),

                ListTile(
                  title: Text("Vaccination"),
                  subtitle: Text("Add & Update Vaccination"),
                  leading: Icon(FontAwesomeIcons.clinicMedical,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>vaccination_list(token)));
                  },
                ),
                ListTile(
                  title: Text("Competetion"),
                  subtitle: Text("Add & Update Competetion"),
                  leading: Icon(FontAwesomeIcons.compactDisc,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>competetion_list(token)));
                  },
                ),
                ListTile(
                  title: Text("Swabbing"),
                  subtitle: Text("Add & Update Swabbing"),
                  leading: Icon(FontAwesomeIcons.clinicMedical,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>swabbing_list(token)));
                  },
                ),
                ListTile(
                  title: Text("MoveMent"),
                  subtitle: Text("Add & Update Movement"),
                  leading: Icon(FontAwesomeIcons.truckMoving,size: 40,),
                  trailing: Icon(Icons.arrow_right),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>movement_list(token)));
                  },
                ),
              ],
            ),
          ),
        )
    );
  }

}