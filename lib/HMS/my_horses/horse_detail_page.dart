import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/my_horses/HypotheticPedegree/hypothetic_pedegree_page.dart';
import 'package:horse_management/HMS/my_horses/Marking/marking.dart';
import 'package:horse_management/HMS/my_horses/add_horse/update_horse.dart';
import 'package:horse_management/HMS/my_horses/breeding_sale/breeding_sales_specific.dart';
import 'package:horse_management/HMS/my_horses/competetion/specific_competetion.dart';
import 'package:horse_management/HMS/my_horses/diet/diet_list_dash.dart';
import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';
import 'package:horse_management/HMS/my_horses/training/tariningList_specific.dart';
import 'package:horse_management/HMS/my_horses/vaccination/vaccination_list.dart';
import 'package:horse_management/HMS/my_horses/vet/vetList.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'Marking/add_marking.dart';
import 'health_record/health_record_list.dart';
import 'incomeExpense/income_expense_list.dart';
import 'package:horse_management/HMS/my_horses/lab_reports/lab_test_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class horse_detail extends StatefulWidget {
  var horse_data;

  horse_detail(this.horse_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(horse_data);
  }
}

class _Profile_Page_State extends ResumableState<horse_detail> {
  var horsedata;
  SharedPreferences prefs;
  var list,blist;
  String token;
  _Profile_Page_State(this.horsedata);
  var getinfo;
   String gender_value;

  @override
  void onResume() {
    if(resume.data.toString() == "close"){
      Navigator.pop(context,"refresh");
    }
  }

  @override
  void initState() {
    if(horsedata != null) {
      if (horsedata['genderId'] == 1) {
        setState(() {
          gender_value = 'Male';
        });
      }
      else if (horsedata['genderId'] == 2) {
        setState(() {
          gender_value = 'Female';
        });
      }
      else if (horsedata['genderId'] == 3) {
        setState(() {
          gender_value = 'Gielding';
        });
      }
    }else{
      gender_value = 'Empty';
      print("genderlist null a");
    }
//    ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
//    pd.show();
//        Add_horse_services.horseDashBoard(token,horsedata['horseId']).then((response){
//      setState(() {
//        getinfo = jsonDecode(response);
//        print(getinfo['horseDetails']);
////        pd.dismiss();
////        _isvisible =true;
//      });
//    });
  }
  String get_colors(String color){
    String colorId;
    if(color== "red"){
      setState(() {
        colorId = "0xFFFF0000";
      });
    }
   else if(color== "orange"){
      setState(() {
        colorId = "0xFFFFA500";
      });
    }
   else if(color== "green"){
      setState(() {
        colorId = "0xFF008000";
      });
    }
    else if(color== "#DBD9D9"){
      setState(() {
        colorId = "0xFF808080";
      });
    }
    else {
      setState(() {
     colorId= "0xFF808080";
      });
    }
    return colorId;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Horse Details"),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ExpansionTile(
                leading: Image.asset("assets/horse_icon.png", fit: BoxFit.cover),
                title: Text(horsedata['name']),
                subtitle: Text(horsedata['dateOfBirth'] != null ?horsedata['dateOfBirth'].toString().substring(0,10):"date of birth empty" ),
                // leading: Image.asset("Assets/horse_icon.png",width: 50,height: 50,),
                trailing: InkWell(
                  onTap:  () async {
                    //print(horsedata['horseId']);
                    prefs = await SharedPreferences.getInstance();
                    print(horsedata);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => update_horse(prefs.get('token'), horsedata)));
                  },
                    child: Icon(FontAwesomeIcons.solidEdit)),
//                onTap: () async {
//                  print(horsedata['horseId']);
//                  prefs = await SharedPreferences.getInstance();
//                  print(horsedata);
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => update_horse(prefs.get('token'), horsedata)));
//                },
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 12),
                  child: ListTile(
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Training Status"),
                        Text("Breeding"),
                        Text("Health Record"),
                        Text("Vaccination"),

                      ],
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Tooltip(message: horsedata['horseStatus']['trainingStatus'] !=null ? horsedata['horseStatus']['trainingStatus']: 'empty',child: CircleAvatar(radius: 25.0,backgroundColor: Color(int.parse(get_colors(horsedata['horseStatus']['trainingColor']))),)),
                        Tooltip(message: horsedata['horseStatus']['breedingStatus'] != null ?horsedata['horseStatus']['breedingStatus']:'empty',child: CircleAvatar(radius: 25.0,backgroundColor: Color(int.parse(get_colors(horsedata['horseStatus']['breedingColor']))),)),
                        Tooltip(message: horsedata['horseStatus']['healthRecordStatus']!= null ?horsedata['horseStatus']['healthRecordStatus']:'empty',child: CircleAvatar(radius: 25.0,backgroundColor: Color(int.parse(get_colors(horsedata['horseStatus']['healthRecordColor']))),)),
                        Tooltip(message: horsedata['horseStatus']['vaccinationStatus']!= null? horsedata['horseStatus']['vaccinationStatus']:'empty',child: CircleAvatar(radius: 25.0,backgroundColor: Color(int.parse(get_colors(horsedata['horseStatus']['vaccinationColor']))),
//                          child: Text(horsedata['horseStatus']['vaccinationStatus']!= null ? horsedata['horseStatus']['vaccinationStatus']:''),
                        )),
                      ],
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12),
                  child: ListTile(
                    title: Text("Gender"),
                    trailing: Text(gender_value != null ? gender_value:""),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12),
                  child: ListTile(
                    title: Text("Breed"),
                    trailing: Text(horsedata['breedId'] != null ? horsedata['breedName']['name']:'') ,
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12),
                  child: ListTile(
                    title: Text("Color"),
                    trailing: Text(horsedata['colorId'] != null ? horsedata['colorName']['name']:''),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12),
                  child: ListTile(
                    title: Text("Sire"),
                    trailing: Text(horsedata['sireId'] != null ? horsedata['sireName']['name']:''),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12),
                  child: ListTile(
                    title: Text("Dam"),
                    trailing: Text(horsedata['damId'] != null ? horsedata['damName']['name']:''),
                  ),
                ),

              ],
              ),
              Divider(),
//              Text(
//                "Managed By",
//                textAlign: TextAlign.start,
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 30, top: 12),
//                child: Container(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: <Widget>[
//                      CircleAvatar(
//                        backgroundImage: NetworkImage(
//                            "https://avatars0.githubusercontent.com/u/8264639?s=460&v=4"),
//                        radius: 40,
//                      ),
//                      SizedBox(
//                        width: 7,
//                      ),
//                      CircleAvatar(
//                        backgroundImage: NetworkImage(
//                            "https://avatars0.githubusercontent.com/u/8264639?s=460&v=4"),
//                        radius: 40,
//                      ),
//                    ],
//                  ),
//                ),
//
              SizedBox(height: 10,width: 10,),


              ListTile(
                title: Text("Training"),
                subtitle: Text("Add Training on this horse"),
                leading: FaIcon(FontAwesomeIcons.hatCowboy, color: Colors.brown.shade300, size: 35,),
                trailing: Icon(Icons.arrow_right),
                onTap: () async{
                  prefs = await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(
                          builder: (context) => specificTraining_list(prefs.get('token'),horsedata['allTrainings'] != null ? horsedata['allTrainings']: 'A')));
                },
              ),


              ListTile(
                title: Text("Vaccination"),
                subtitle: Text("Vaccination Detail on this Horse"),
                leading: FaIcon(FontAwesomeIcons.syringe, color: Colors.yellowAccent.shade200, size: 35,),
                trailing: Icon(Icons.arrow_right),
                onTap: () async{
                  print(horsedata['allVaccinations'] != null ? horsedata['allVaccinations']:"Abc");
                  prefs = await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => vaccinationList(prefs.get("token"),horsedata != null ? horsedata['allVaccinations']: '')));
                },
              ),
              ListTile(
                title: Text("Lab Report"),
                subtitle: Text("Add Report on this horse"),
                leading: FaIcon(FontAwesomeIcons.fileMedicalAlt, color: Colors.blue.shade400, size: 35,),

                trailing: Icon(Icons.arrow_right),
                onTap: () async {
                  prefs = await SharedPreferences.getInstance();
                  print(horsedata['horseId']);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => lab_list(prefs.get('token'), horsedata['allLabTests'])));
                },
              ),
              ListTile(
                title: Text("Health Record"),
                subtitle: Text("Add Health Record on this horse"),
                leading: FaIcon(FontAwesomeIcons.bookMedical, color: Colors.redAccent.shade100, size: 35,),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => healthRecord_list(prefs.get('token'), horsedata['allHealthRecords'])));
                },
              ),
              ListTile(
                title: Text("Income & Expense"),
                //(training_list!=null?training_list[index]['targetCompetition'].toString():''
                subtitle: Text("Track Your Expense"),
                leading: FaIcon(FontAwesomeIcons.wallet, color: Colors.brown.shade500, size: 35,),
                trailing: Icon(Icons.arrow_right),
                onTap: () async {
                 // print(horsedata != null ? horsedata['allIncomeAndExpenses'][1]['amount'].toString() : '');
                  print(horsedata != null ? horsedata['allIncomeAndExpenses'].toString() : '');
                  prefs = await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => income_expense_list(
                              prefs.get('token'), horsedata != null ? horsedata['allIncomeAndExpenses'] : '')));
                },
              ),
              ListTile(
                title: Text("Competetion"),
                subtitle: Text("View All competetion"),
                leading: FaIcon(FontAwesomeIcons.flagCheckered, color: Colors.white, size: 35,),

                trailing: Icon(Icons.arrow_right),
                onTap: ()async {
                  prefs = await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => competetion_list(prefs.get('token'),horsedata != null ? horsedata['allCompetitions'] : '')));
                },
              ),
              ListTile(
                title: Text("Vet Visit"),
                subtitle: Text("All vet visit on this horse"),
                leading: FaIcon(FontAwesomeIcons.userMd, color: Colors.redAccent, size: 35,),
                trailing: Icon(Icons.arrow_right),
                onTap: () async{
                  prefs = await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => vet_list(prefs.get('token'),horsedata != null ? horsedata['allVetVisits'] : '')));
                },
              ),
              ListTile(
                title: Text("Breeding Sale"),
                subtitle: Text("All breeding sale Detail on this horse"),
                leading: FaIcon(FontAwesomeIcons.handHoldingUsd, color: Colors.green, size: 35,),

                trailing: Icon(Icons.arrow_right),
                onTap: () async{
                  print(horsedata['horseId'].toString());
                  prefs = await SharedPreferences.getInstance();
                  setState(() {
                    token = prefs.get('token');
                  });

                  Navigator.push(context, MaterialPageRoute(builder: (context) => breedingSale_list(prefs.get('token'),horsedata != null ? horsedata['horseId'] : '')));
                },
              ),
              ListTile(
                title: Text("Hypothetical Pedigree"),
                subtitle: Text("View ancesstors of the horse"),
                leading: FaIcon(FontAwesomeIcons.projectDiagram, color:Colors.pink.shade100, size: 35,),

                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  print(horsedata);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => hypothetic_pedegree_page(horsedata)));
                },
              ),
              ListTile(
                title: Text("Marking"),
                subtitle: Text("Add Marking"),
                leading: FaIcon(FontAwesomeIcons.marker, color: Color(0xFFd4af37), size: 35,),

                trailing: Icon(Icons.arrow_right),
                onTap: (){
                 push(context,MaterialPageRoute(builder: (context)=>marking(horsedata)));
                },
              ),
//              ListTile(
//                title: Text("Diet"),
//                subtitle: Text("See the Horse diet"),
//                leading: Icon(
//                  Icons.speaker_notes,
//                  size: 40,
//                ),
//                trailing: Icon(Icons.arrow_right),
//                onTap: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => diet_listspecific(token,horsedata != null ? horsedata['allDiets']:null)));
//                },
//              ),
//              ListTile(
//                title: Text("Image"),
//                subtitle: Text("Add image on this horse"),
//                leading: Icon(
//                  Icons.image,
//                  size: 40,
//                ),
//                trailing: Icon(Icons.arrow_right),
//                onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => picture_list(horsedata != null ? horsedata['allPictures'] : '')));
//                },
//              ),
            ],
          ),
        ));
  }
}
