import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/my_horses/services/health_services.dart';
import 'health_record_form.dart';


class healthRecord_list extends StatefulWidget{
  String token;
  var  specificHealthRecord;

  healthRecord_list (this.token, this.specificHealthRecord);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token,specificHealthRecord);
  }

}
class _Profile_Page_State extends State<healthRecord_list>{
  int id;

  _Profile_Page_State (this.token,this.specificHealthRecord);

  String token,title,dateOfBirth;
  var specificHealthRecord,healthdropDown;
  var temp=['',''];


  @override
  void initState () {
//    healthServices.horseIdhealthRecord(token, id).then((response){
//      setState(() {
//        print(response);
//        specificHealthRecord =json.decode(response);
//
//      });
//
//    });
//    Add_horse_services.labdropdown(token).then((response){
//      setState((){
//        labdropDown = json.decode(response);
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Health Record"),
//          actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => health_record_form(token)),);
//            },
//          )
//        ],
        ),
        body: ListView.builder(itemCount:specificHealthRecord!=null?specificHealthRecord.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              ExpansionTile(
                //['categoryName']['name']
                title: Text(specificHealthRecord[index]['date']),
                trailing: Text(specificHealthRecord[index]['status'].toString()),

                children: <Widget>[
                  ListTile(
                    title: Text("Product"),
                    trailing: Text(specificHealthRecord != null ? specificHealthRecord[index]['product'].toString(): 'product null'),
                    onTap: ()async{
                      //list[index]['categoryDropDown']['categoryId']['name'].toString()
//                      print(specificHealthRecord['horseDropdown'][specificHealthRecord[0]['horseId']]==['id']);
//                      print(specificHealthRecord['horseDropdown']);
//                      print(specificHealthRecord);
//                      print(specificHealthRecord[0]['horseId']);
//                      prefs= await SharedPreferences.getInstance();
//                      Navigator.push(context, MaterialPageRoute(builder: (context) => (list[index]['allIncomeAndExpenses'],prefs.get('token'),prefs.get('createdBy'))),);

                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Quantity"),
                    trailing: Text(specificHealthRecord != null ?specificHealthRecord[index]['quantity'].toString():'quantity empty'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Amount"),
                    trailing: Text(specificHealthRecord[index]['amount'].toString()),
                  )

                ],


              ),
            ],

          );

        })
    );
  }

}











































//import 'dart:convert';
//import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:horse_management/HMS/my_horses/services/health_services.dart';
//import 'health_record_form.dart';
//
//
//class healthRecord_list extends StatefulWidget{
//  String token;
//  int id;
//
//  healthRecord_list (this.token, this.id);
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _Profile_Page_State(token,id);
//  }
//
//}
//class _Profile_Page_State extends State<healthRecord_list>{
//  int id;
//
//  _Profile_Page_State (this.token,this.id);
//
//  String token,title,dateOfBirth;
//  var specifichorsehealthRecord,healthdropDown;
//  var temp=['',''];
//
//
//  @override
//  void initState () {
//    healthServices.horseIdhealthRecord(token, id).then((response){
//      setState(() {
//        print(response);
//        specifichorsehealthRecord =json.decode(response);
//
//      });
//
//    });
////    Add_horse_services.labdropdown(token).then((response){
////      setState((){
////        labdropDown = json.decode(response);
////      });
////    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//        appBar: AppBar(title: Text("Health Record"),actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => health_record_form(token)),);
//            },
//          )
//        ],),
//        body: ListView.builder(itemCount:specifichorsehealthRecord!=null?specifichorsehealthRecord.length:temp.length,itemBuilder: (context,int index){
//          return Column(
//            children: <Widget>[
//              Slidable(
//                actionPane: SlidableDrawerActionPane(),
//                actionExtentRatio: 0.20,
//                actions: <Widget>[
//                  IconSlideAction(
//                    icon: Icons.visibility_off,
//                    color: Colors.red,
//                    caption: 'Hide',
////                    onTap: () async {
////                      Add_horse_services.horsevisibilty(token, horse_list[index]['horseId']).then((response){
////                        //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
////                        print(response);
////                        if(response!=null){
////
////                          Scaffold.of(context).showSnackBar(SnackBar(
////                            backgroundColor:Colors.green ,
////                            content: Text('Visibility Changed'),
////                          ));
////
////                        }else{
////                          Scaffold.of(context).showSnackBar(SnackBar(
////                            backgroundColor:Colors.red ,
////                            content: Text('Failed'),
////                          ));
////                        }
////                      });
////                    },
//                  ),
//                ],
//                child: ListTile(
//                  //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
//                  title: Text(specifichorsehealthRecord!=null?(specifichorsehealthRecord[index]['responsibleDropDown']['responsibleId']['name']):'responsible name not show'),
//                  subtitle: Text("abc"),
//                  //leading: Image.asset("Assets/horses_icon.png"),
////                  onTap: (){
////                    print((horse_list[index]));
////                    Navigator.push(context, MaterialPageRoute(builder: (context)=>horse_detail(horse_list[index])));
////                  },
//                ),
//
//
//              ),
//              Divider(),
//            ],
//
//          );
//
//        })
//    );
//  }
//
//}