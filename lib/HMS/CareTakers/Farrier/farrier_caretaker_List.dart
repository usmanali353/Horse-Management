import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/farrier/add_farrier.dart';
import 'package:horse_management/HMS/All_Horses_data/farrier/updateFarrier.dart';
import 'package:horse_management/HMS/All_Horses_data/lab_reports/update_lab_reports.dart';
import 'package:horse_management/HMS/All_Horses_data/services/farrier_services.dart';
import 'package:horse_management/HMS/CareTakers/Farrier/FarrierCaretaker.dart';
import 'package:horse_management/HMS/CareTakers/Farrier/FarrierLateReason.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class careTakerFarrierList extends StatefulWidget{
  String token;


  careTakerFarrierList (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<careTakerFarrierList>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);

  String token;
  var farrierlist, load_list;
  var temp=[];


  @override
  void initState () {
//    labtest_services.horseIdLabtest(token, id).then((response){
//      setState(() {
//        print(response);
//        specifichorselab =json.decode(response);
//
//      });
//
//    });
//    Add_horse_services.labdropdown(token).then((response){
//      setState((){
//        labdropDown = json.decode(response);
//      });
//    });

    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        //farrier_services.farrierlist(token).then((response) {
        FarrierCareTakerServices.get_farrier_caretaker(token).then((response) {
          pd.dismiss();
          setState(() {
            print(response);
            load_list = json.decode(response);
            farrierlist = load_list['response'];
          });
        });
      }else
        print("No Network");
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Farrier & Caretaker"),actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => add_farrier(token)),);
//            },
//          )
        ],),
        body: ListView.builder(itemCount:farrierlist!=null?farrierlist.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.20,
                actions: <Widget>[
//                  IconSlideAction(onTap: ()async{
//                    prefs = await SharedPreferences.getInstance();
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_farrier(farrierlist[index],token)));
//
//                  },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
//                  IconSlideAction(
//                    icon: Icons.visibility_off,
//                    color: Colors.red,
//                    caption: 'Hide',
//                    onTap: () async {
//                      farrier_services.weight_hieghtvisibilty(token, farrierlist[index]['id']).then((response){
//                        //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
//                        print(response);
//                        if(response!=null){
//
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            backgroundColor:Colors.green ,
//                            content: Text('Visibility Changed'),
//                          ));
//
//                        }else{
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            backgroundColor:Colors.red ,
//                            content: Text('Failed'),
//                          ));
//                        }
//                      });
//                    },
//                  ),
                  IconSlideAction(
                    icon: Icons.timer,
                    color: Colors.deepOrange,
                    caption: 'Start',
                    onTap: () async {
                      Utils.check_connectivity().then((result){
                        if(result){
                          ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                          pd.show();
                          FarrierCareTakerServices.start_farrier(token, farrierlist[index]['id']).then((response){
                            pd.dismiss();
                            if(response!=null){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.green ,
                                content: Text('Process Started'),
                              ));
//                                  setState(() {
//                                    control_list.removeAt(index);
//                                  });
                            }else{
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.red ,
                                content: Text('Process Failed'),
                              ));
                            }
                          });
                        }else{
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Network not Available"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      });

                    },
                  ),
                  IconSlideAction(
                    icon: Icons.done_all,
                    color: Colors.green,
                    caption: 'Complete',
                    onTap: () async {
                      if(DateTime.now().isAfter(DateTime.parse(farrierlist[index]['date'])) )
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>farrier_late_reason(token, farrierlist[index]['id'])));

                      else {
                        Utils.check_connectivity().then((result) {
                          if (result) {
                            ProgressDialog pd = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true);
                            pd.show();
                            FarrierCareTakerServices.complete_farrier(token, farrierlist[index]['id']).then((response) {
                              pd.dismiss();
                              if (response != null) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('Process Complete'),
                                ));
//                                  setState(() {
//                                    control_list.removeAt(index);
//                                  });
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Process Failed'),
                                ));
                              }
                            });
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Network not Available"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        });
                      }
                    },
                  ),
                ],
                child: ExpansionTile(
                  title: Text(farrierlist!=null?(farrierlist[index]['horseName']['name']):''),
                  trailing: Text(farrierlist!=null?"Status: "+(get_status_by_id(farrierlist[index]['status'])).toString():'empty'),
                  children: <Widget>[
                  ListTile(
                      title: Text("Farrier "),
                     // trailing: Text("jn"),
                      trailing: Text(farrierlist!=null?"Farrier: "+(farrierlist[index]['farrierName']['contactName']['name']):'farrier name not showing'),
                      onTap: ()async{
                            },
                      ),
                    Divider(),
                    ListTile(
                      title: Text("Amount"),
                      trailing: Text(farrierlist!=null?"Amount: "+(farrierlist[index]['amount']).toString():''),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Shoeing Type"),
                      trailing: Text(farrierlist!=null?"Amount: "+(get_ShoeingType_by_id(farrierlist[index]['shoeingType'])).toString():''),
                    ),


                  ],

                ),
                secondaryActions: <Widget>[

                ],

              ),
              Divider(),
            ],

          );

        })
    );
  }
  String get_status_by_id(int id){
    var status;

    if(id ==0){
      status= "Not started";
    }else if(id==1){
      status='Started';
    }else if(id==2){
      status="Complete";
    }
    else if(id==3){
      status="Late Complete";
    }
    else{
      status= "empty";
    }
    return status;
  }
  String get_ShoeingType_by_id(int id){
    var status;

    if(id ==1){
      status= "Complete";
    }
    else if(id==2){
      status="Front Shoeing";
    }
    else if(id==3){
      status="Back Shoeing";
    }else if(id==4){
      status="Trimming";
    }
    else{
      status= "empty";
    }
    return status;
  }
}














































//import 'dart:convert';
//
//import 'package:circular_profile_avatar/circular_profile_avatar.dart';
//import 'package:flutter/material.dart';
//import 'package:horse_management/HMS/All_Horses_data/farrier/add_farrier.dart';
//import 'package:horse_management/HMS/All_Horses_data/services/farrier_services.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:horse_management/HMS/Training/training_detail_page.dart';
//import 'package:horse_management/Network_Operations.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//
//
//class farrier_list extends StatefulWidget{
//  var list;
//  int horseId;
//  String token;
//
//
//  farrier_list ( this.token);
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _incomeExpense_list_state(token);
//  }
//
//}
//class _incomeExpense_list_state extends State<farrier_list>{
//  var list,incomelist;
//  int horseId;String token;
//  var temp=['',''];
//  SharedPreferences prefs;
//
//  _incomeExpense_list_state (this.token);
//
//
//  @override
//  void initState () {
////    income_expense_services.horseIdincomeExpense(token,1).then((
////        response) {
////      setState(() {
////        print(response);
////        incomelist = json.decode(response);
////      });
////    });
////    Add_horse_services.labdropdown(token).then((response){
////      setState((){
////        labdropDown = json.decode(response);
////      });
////    });
//
//    farrier_services.farrierlist(token).then((
//        response) {
//      setState(() {
//        print(response);
//        list = json.decode(response);
//      });
//    });
//
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    // TODO: implement build
//    return Scaffold(
//        appBar: AppBar(title: Text("Income & Expense "),actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () async{
//              prefs= await SharedPreferences.getInstance();
//              Navigator.push(context, MaterialPageRoute(builder: (context) => add_farrier(prefs.get('token'))),);
//            },
//          )
//        ],),
//        body:ListView.builder(itemCount:list!=null?list.length:temp.length,itemBuilder: (context,int index){
//          return Column(
//            children: <Widget>[
//              ExpansionTile(
//                //['categoryName']['name']
//                title: Text(list[index]['horseName']['name']),
//                trailing: Text(list[index]['date'].toString()),
//
//                children: <Widget>[
////
////                   ListTile(
////                    title: Text((list[index]['id'].toString())),
////                    //leading: Image.asset("Assets/horses_icon.png"),
////                    onTap: (){
////                      print((list[index]['id']));
////                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>horse_detail(horse_list[index])));
////                    },
////                  ),
////                  Divider(),
//                  ListTile(
//                    title: Text("Date"),
//                    trailing: Text(list[index]['date'].toString()),
//                    onTap: ()async{
//                      //list[index]['categoryDropDown']['categoryId']['name'].toString()
////                  print(incomelist['horseDropdown'][list[0]['horseId']]==['id']);
////                  print(incomelist['horseDropdown']);
////                  print(list);
//                      print(list[index]['id']);
//                      prefs= await SharedPreferences.getInstance();
//                      //Navigator.push(context, MaterialPageRoute(builder: (context) => update_IncomeExpense(list[index]['id'],prefs.get('token'),prefs.get('createdBy'))),);
//
//                    },
//                  ),
//                  Divider(),
//                  ListTile(
//                    title: Text("Cost Center"),
//                    trailing: Text(list[index]['costCenterId'].toString()),
//                  ),
//                  Divider(),
//                  ListTile(
//                    title: Text("Amount"),
//                    trailing: Text(list[index]['amount'].toString()),
//                  )
//
//                ],
//
//
//              ),
//              Divider(),
//            ],
//
//          );
//
//        })
//
//    );
//  }
//
//}
//
//
