import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/farrier/add_farrier.dart';
import 'package:horse_management/HMS/All_Horses_data/farrier/updateFarrier.dart';
import 'package:horse_management/HMS/All_Horses_data/lab_reports/update_lab_reports.dart';
import 'package:horse_management/HMS/All_Horses_data/services/farrier_services.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class farrier_list extends StatefulWidget{
  String token;


  farrier_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<farrier_list>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);

  String token;
  var farrierlist;
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
        farrier_services.farrierlist(token).then((response) {
          pd.dismiss();
          setState(() {
            print(response);
            farrierlist = json.decode(response);
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
        appBar: AppBar(title: Text("Farrier"),actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_farrier(token)),);
            },
          )
        ],),
        body: ListView.builder(itemCount:farrierlist!=null?farrierlist.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.20,
                actions: <Widget>[
                  IconSlideAction(
                    icon: Icons.visibility_off,
                    color: Colors.red,
                    caption: 'Hide',
                    onTap: () async {
                      farrier_services.weight_hieghtvisibilty(token, farrierlist[index]['id']).then((response){
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
                  IconSlideAction(onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_farrier(farrierlist[index],token)));

                  },color: Colors.blue,icon: Icons.border_color,caption: 'update',)
                ],
                child: ListTile(
                  //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                  title: Text(farrierlist!=null?(farrierlist[index]['horseName']['name']):''),
                  subtitle: Text(farrierlist!=null?"Farrier: "+(farrierlist[index]['farrierName']['contactName']['name']):'farrier name not showing'),
                  trailing: Text(farrierlist!=null?"Amount: "+(farrierlist[index]['amount']).toString():''),
                  //leading: Image.asset("Assets/horses_icon.png"),
                  onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    print((farrierlist[index]));
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>update_labTest(lablist[index]['id'],prefs.get('token'),prefs.get('createdBy'))));
                  },
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
