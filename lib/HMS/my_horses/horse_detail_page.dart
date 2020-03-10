import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/my_horses/add_horse/update_horse.dart';
import 'package:horse_management/HMS/my_horses/training/tariningList_specific.dart';
import 'package:horse_management/HMS/my_horses/vaccination/vaccination_list.dart';
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

class _Profile_Page_State extends State<horse_detail> {
  var horsedata;
  SharedPreferences prefs;

  _Profile_Page_State(this.horsedata);

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
              ListTile(
                leading: Image.asset("Assets/horse_icon.png", fit: BoxFit.cover),
                title: Text(horsedata['name']),
                subtitle: Text(horsedata['dateOfBirth'] != null ?horsedata['dateOfBirth'].toString().substring(0,10):"date of birth empty" ),
                // leading: Image.asset("Assets/horse_icon.png",width: 50,height: 50,),
                trailing: Icon(FontAwesomeIcons.solidEdit),
                onTap: () async {
                  print(horsedata['horseId']);
                  prefs = await SharedPreferences.getInstance();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => update_horse(prefs.get('token'), horsedata)));
                },
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
                leading: Icon(
                  Icons.receipt,
                  size: 40,
                ),
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
                leading: Icon(
                  Icons.receipt,
                  size: 40,
                ),
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
                leading: Icon(
                  Icons.receipt,
                  size: 40,
                ),
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
                leading: Icon(
                  Icons.receipt,
                  size: 40,
                ),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => healthRecord_list(prefs.get('token'), horsedata['allHealthRecords'])));
                },
              ),
              ListTile(
                title: Text("Income & Expense"),
                //(training_list!=null?training_list[index]['targetCompetition'].toString():''
                subtitle: Text("Track Your Expense"),
                leading: Icon(
                  Icons.account_balance_wallet,
                  size: 40,
                ),
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
                title: Text("Diet"),
                subtitle: Text("Diet for this horse"),
                leading: Icon(
                  Icons.receipt,
                  size: 40,
                ),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
//                  Navigator.push(context, MaterialPageRoute(
//                      builder: (context) => specificTraining_list(horsedata != null ? horsedata['allTrainings'] : '')));
                },
              ),
              ListTile(
                title: Text("Vet Visit"),
                subtitle: Text("All vet visit on this horse"),
                leading: Icon(
                  Icons.receipt,
                  size: 40,
                ),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => specificTraining_list(horsedata != null ? horsedata['allVetVisits'] : '')));
                },
              ),
              ListTile(
                title: Text("Breeding Sale"),
                subtitle: Text("All breeding sale Detail on this horse"),
                leading: Icon(
                  Icons.receipt,
                  size: 40,
                ),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => specificTraining_list(horsedata != null ? horsedata['allBreedingSales'] : '')));
                },
              ),
//              ListTile(
//                title: Text("Notes"),
//                subtitle: Text("manage note on horse"),
//                leading: Icon(
//                  Icons.speaker_notes,
//                  size: 40,
//                ),
//                trailing: Icon(Icons.arrow_right),
//                onTap: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => add_new_note()));
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
