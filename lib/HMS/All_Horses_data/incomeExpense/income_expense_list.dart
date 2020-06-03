import 'dart:convert';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/All_Horses_data/services/incomeExpense_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'income_and_expenses.dart';
import 'update_income_expense.dart';



class income_expense_list extends StatefulWidget{
  var list;
  int horseId;
  String token;


  income_expense_list ( this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _incomeExpense_list_state(token);
  }

}
class _incomeExpense_list_state extends State<income_expense_list>{
  var list,incomelist, load_list ,pagelist,pageloadlist;

  int horseId;String token;
  var temp=['',''];
  int pagenum = 1;
  int total_page;
  SharedPreferences prefs;

  _incomeExpense_list_state (this.token);


  @override
  void initState () {
//    Add_horse_services.labdropdown(token).then((response){
//      setState((){
//        labdropDown = json.decode(response);
//      });
//    });


    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        income_expense_services.income_expenselist(token).then((
            response) {
          pd.dismiss();
          setState(() {
            print(response);
            load_list = json.decode(response);
            list = load_list['response'];
            total_page=load_list['totalPages'];
            print(total_page);
          });
        });
      }else
        print("network nahi hai");
    });



  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Income & Expense "),

          actions: <Widget>[

          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async{
              prefs= await SharedPreferences.getInstance();
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_IncomeExpense(prefs.get('token'))),);
            },
          )
        ],),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(child: Icon(Icons.arrow_back),heroTag: "btn2", onPressed: () {

                if(load_list['hasPrevious'] == true && pagenum >= 1 ) {
                 Utils.check_connectivity().then((result){
                    if(result) {
                       ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                        pd.show();
                  income_expense_services.income_expenselistbypage(token, pagenum).then((response) {
                        pd.dismiss();
                    setState(() {
                      print(response);
                      load_list= json.decode(response);
                      list = load_list['response'];
                      print(list);
                    });
                  });
                    }else
                      print("network nahi hai");
                 });
                }
                else{
                  print("list empty");
                  //Scaffold.of(context).showSnackBar(SnackBar(content: Text("List empty"),));
                }
                if(pagenum > 1){
               pagenum = pagenum - 1;
                }
                print(pagenum);
              }),
              FloatingActionButton(child: Icon(Icons.arrow_forward),heroTag: "btn1", onPressed: () {
                print(load_list['hasNext']);
                if(load_list['hasNext'] == true && pagenum >= 1 ) {
                  Utils.check_connectivity().then((result){
                    if(result) {
                      ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                      pd.show();
                      income_expense_services.income_expenselistbypage(
                          token, pagenum).then((response) {
                        pd.dismiss();
                        setState(() {
                          print(response);
                          load_list = json.decode(response);
                          list = load_list['response'];
                          print(list);
                        });
                      });
                    }else
                      print("network nahi hai");
                  });
                }
                else{
                  print("list empty");
                  //Scaffold.of(context).showSnackBar(SnackBar(content: Text("List empty"),));
                }
                if(pagenum < total_page) {
                  pagenum = pagenum + 1;
                }
                print(pagenum);

              })
            ]
            )
        ),
        body:ListView.builder(itemCount:list!=null?list.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.20,
                actions: <Widget>[
                  IconSlideAction(onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_IncomeExpense(list[index],prefs.get('token'),prefs.get('createdBy'))));

                  },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
                  IconSlideAction(
                    icon: Icons.visibility_off,
                    color: Colors.red,
                    caption: 'Hide',
                    onTap: () async {
                      income_expense_services.incomevisibilty(token, list[index]['id']).then((response){
                        //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                        print(response);
                        if(response!=null){

                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor:Colors.green ,
                            content: Text('Visibility Changed'),
                          ));

                        }else{
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor:Colors.red ,
                            content: Text('Failed'),
                          ));
                        }
                      });
                    },
                  ),
                ],
                child: ExpansionTile(
          //['categoryName']['name']
                  title: Text(list != null ? list[index]['horseName']['name']:""),
                  subtitle: Text(list != null ? "Account: "+list[index]['categoryName']['name']:""),
                  trailing: Text(list != null ? "Date: "+list[index]['date'].toString().substring(0,10):""),
                // leading: Text(list != null ? 'Amount '+list[index]['amount'].toString():""),
                  children: <Widget>[

                Divider(),

                ListTile(
                  title: Text("Amount"),
                  trailing: Text(list != null ? list[index]['amount'].toString():""),
                ),

                  ],


                ),
              ),
              Divider(),

            ],

          );

        })

    );
  }
//
//  @override
//  void initState() {
//    Add_horse_services.horselist(token).then((response){
//      // print(response.length.toString());
//      if(response!=null){
//        setState(() {
//          //var parsedjson = jsonDecode(response);
//          horse_list  = jsonDecode(response);
//          print(horse_list);
//        });
//
//      }else{
//
//      }
//    });
//
//  }

}








//import 'dart:convert';
//
//import 'package:circular_profile_avatar/circular_profile_avatar.dart';
//import 'package:flutter/material.dart';
//import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//
//import 'dart:convert';
//
//import 'package:circular_profile_avatar/circular_profile_avatar.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:horse_management/HMS/Training/training_detail_page.dart';
//import 'package:horse_management/Network_Operations.dart';
//
//import 'income_and_expenses.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//
//
//
//
//class income_expense_list extends StatefulWidget{
//  var list;
//
//
//  income_expense_list ( this.list);
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _incomeExpense_list_state(list);
//  }
//
//}
//class _incomeExpense_list_state extends State<income_expense_list>{
//  var list;
//  SharedPreferences prefs;
//
//
//  _incomeExpense_list_state (this.list);
//
//  var temp=['',''];
//  @override
//  Widget build(BuildContext context) {
//
//    // TODO: implement build
//    return Scaffold(
//        appBar: AppBar(title: Text("All Horses "),actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.5,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () async{
//              prefs= await SharedPreferences.getInstance();
//              Navigator.push(context, MaterialPageRoute(builder: (context) => add_IncomeExpense(prefs.get('token'))),);
//            },
//          )
//        ],),
//        body:ListView.builder(itemCount:list!=null?list.length:temp.length,itemBuilder: (context,int index){
//          return Column(
//            children: <Widget>[
////              ListTile(
////                title: Text(list!=null?(list[index]['name']):''),
////                subtitle: Text(list!=null?list[index]['dateOfBirth'].toString():''),
////                //leading: Image.asset("Assets/horses_icon.png"),
////                onTap: (){
////                  print((list[index]));
////                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>horse_detail(horse_list[index])));
////                },
////              ),
////              Divider(),
//              ListTile(
//                title: Text("Date"),
//                trailing: Text(list[0]['date'].toString()),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Cost Center"),
//                trailing: Text(list[0]['costCenterId'].toString()),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Amount"),
//                trailing: Text(list[0]['amount'].toString()),
//              ),
//            ],
//
//          );
//
//        })
//
//    );
//  }
//
////  @override
////  void initState() {
////    Add_horse_services.horselist(token).then((response){
////      // print(response.length.toString());
////      if(response!=null){
////        setState(() {
////          //var parsedjson = jsonDecode(response);
////          horse_list  = jsonDecode(response);
////          print(horse_list);
////        });
////
////      }else{
////
////      }
////    });
////
////  }
//
//}
//
//
//
//
//
//
//
//
////class horse_list extends StatefulWidget {
////  @override
////  State<StatefulWidget> createState() {
////    // TODO: implement createState
////    return _Profile_Page_State();
////  }
////}
////
////class _Profile_Page_State extends State<horse_list> {
////  String title, dateOfBirth;
////  var horselist;
////  List<String> horse = [];
////  var token;
////
////  @override
////  void initState() {
////    Add_horse_services.horselist(token).then((response) {
////      // print(response.length.toString());
////      setState(() {
////        //var parsedjson = jsonDecode(response);
////        horselist = jsonDecode(response);
////        print(horselist);
////        horse.add(horselist);
////
////        for (int i = 0; i < horselist.length; i++)
////          horse.add(horselist[i]['name']);
////        print(horse.length.toString());
////      });
////    });
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    // TODO: implement build
////    return Scaffold(
////      appBar: AppBar(
////        title: Text("My Horses"),
////        actions: <Widget>[
////          Center(
////              child: Text(
////            "Add New",
////            textScaleFactor: 1.5,
////          )),
////          IconButton(
////            icon: Icon(
////              Icons.add,
////              color: Colors.white,
////            ),
////            onPressed: () async {
////              SharedPreferences prefs = await SharedPreferences.getInstance();
////              token = await prefs.getString("token");
////
////              Navigator.push(
////                context,
////                MaterialPageRoute(builder: (context) => add_newHorse(token)),
////              );
////            },
////          )
////        ],
////      ),
////      body: Column(
////        crossAxisAlignment: CrossAxisAlignment.center,
////        children: <Widget>[
////          Padding(
////            padding: EdgeInsets.all(20.0),
////            child: ListView(
////              shrinkWrap: true,
////              children: <Widget>[
////                ListTile(
////                  title: Text("mkk"),
////                  subtitle: Text("Horse Date of Birth"),
////                  trailing: Icon(Icons.arrow_right),
////                  leading: Image.asset("Assets/horse_icon.png",width: 50,height: 50,),
////                  onTap: (){
////                    Navigator.push(context,MaterialPageRoute(builder: (context)=>horse_detail()));
////                  },
////                ),
////                ListTile(
////                  title: Text("kj"),
////                  subtitle: Text("20/12/2018"),
////                  leading: Image.asset("Assets/horse_icon.png",width: 50,height: 50,),
////                  trailing: Icon(Icons.arrow_right),
////                  onTap: (){
////                    Navigator.push(context,MaterialPageRoute(builder: (context)=>horse_detail()));
////                  },
////                ),
////
////              ],
////            ),
////          ),
////        ],
////      )
////    );
////  }
////}

