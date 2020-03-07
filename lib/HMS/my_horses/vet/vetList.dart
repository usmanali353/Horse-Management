//import 'dart:convert';
//import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:horse_management/HMS/my_horses/services/labtest_services.dart';
//
//
//class vet_list extends StatefulWidget{
//  String token;
//  var  specificvetvisit;
//
//  vet_list (this.token, this.specificvetvisit);
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _Profile_Page_State(token,specificvetvisit);
//  }
//
//}
//class _Profile_Page_State extends State<vet_list>{
//  int id;
//
//  _Profile_Page_State (this.token,this.specificvetvisit);
//
//  String token,title,dateOfBirth;
//  var specificvetvisit,vetdropDown;
//  var temp=['',''];
//
//
//  @override
//  void initState () {
////    healthServices.horseIdhealthRecord(token, id).then((response){
////      setState(() {
////        print(response);
////        specificHealthRecord =json.decode(response);
////
////      });
////
////    });
//    vet_services.labdropdown(token).then((response){
//      setState((){
//        vetdropDown = json.decode(response);
//      });
//    });
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//        appBar: AppBar(title: Text("Vet Visit"),
//        ),
//        body: ListView.builder(itemCount:specificvetvisit!=null?specificvetvisit.length:temp.length,itemBuilder: (context,int index){
//          return Column(
//            children: <Widget>[
//              ExpansionTile(
//                //['categoryName']['name']
//
//                title: Text(specificvetvisit[index]['visitDate'],textScaleFactor: 1.3,),
//                //trailing: Text(specificlabtest[index]['isPositive'] == true ? "Yes" .toString():"No"),
//
//                children: <Widget>[
//                  ListTile(
//                    title: Text("Vet"),
//                    trailing: Text(get_responsible_by_id(specificvetvisit[index]['vetId']).toString()),
//                    onTap: ()async{
//                    },
//                  ),
//                  Divider(),
//                  ListTile(
//                    title: Text("Test Type"),
//                    trailing: Text(get_testtype_by_id(specificvetvisit[index]['typeTestId']).toString()),
//                  ),
//                  Divider(),
//                  ListTile(
//                    title: Text("Amount"),
//                    trailing: Text(specificvetvisit[index]['amount'].toString()),
//                  )
//
//                ],
//
//
//              ),
//            ],
//
//          );
//
//        })
//    );
//  }
//  String get_responsible_by_id(int id){
//    var responsible_name;
//    if(specificvetvisit!=null&&vetdropDown['responsibleDropDown']!=null&&id!=null){
//      for(int i=0;i<vetdropDown['responsibleDropDown'].length;i++){
//        if(vetdropDown['responsibleDropDown'][i]['id']==id){
//          responsible_name=vetdropDown['responsibleDropDown'][i]['name'];
//        }
//      }
//      return responsible_name;
//    }else
//      return null;
//  }
//  String get_vet_by_id(int id){
//    var responsible_name;
//    if(specificvetvisit!=null&&vetdropDown['vetDropDown']!=null&&id!=null){
//      for(int i=0;i<vetdropDown['vetDropDown'].length;i++){
//        if(vetdropDown['vetDropDown'][i]['id']==id){
//          responsible_name=vetdropDown['vetDropDown'][i]['name'];
//        }
//      }
//      return responsible_name;
//    }else
//      return null;
//  }
//}
