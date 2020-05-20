import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/my_horses/services/labtest_services.dart';


class lab_list extends StatefulWidget{
  String token;
  var  specificlabtest;

  lab_list (this.token, this.specificlabtest);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token,specificlabtest);
  }

}
class _Profile_Page_State extends State<lab_list>{
  int id;

  _Profile_Page_State (this.token,this.specificlabtest);

  String token,title,dateOfBirth;
  var specificlabtest,labdropDown;
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
    labtest_services.labdropdown(token).then((response){
      setState((){
        labdropDown = json.decode(response);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Lab Test"),
        ),
        body: ListView.builder(itemCount:specificlabtest!=null?specificlabtest.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              ExpansionTile(
                //['categoryName']['name']

                title: Text("Test Date: "+specificlabtest[index]['date'].toString().substring(0,10),textScaleFactor: 1.1,),
//                trailing: Text(specificlabtest[index]['status'] == true ? "Yes" .toString():"No"),
                trailing: Text(specificlabtest != null ? "Status: "+get_status_by_id(specificlabtest[index]['status']):'status empty'),


                children: <Widget>[
                  ListTile(
                    title: Text("Responsible"),
                    trailing: Text(get_responsible_by_id(specificlabtest[index]['responsible']) != null? get_responsible_by_id(specificlabtest[index]['responsible']).toString():"Empty"),
                    onTap: ()async{
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Test Type"),
                    trailing: Text(get_testtype_by_id(specificlabtest[index]['typeTestId']).toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Amount"),
                    trailing: Text(specificlabtest[index]['amount'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Test Image"),
                    trailing: specificlabtest[index]['image']!=null?Image.memory(base64.decode(specificlabtest[index]['image'])):Text('empty'),
                  )

                ],


              ),
            ],

          );

        })
    );
  }
  String get_responsible_by_id(int id){
    var responsible_name;
    if(specificlabtest!=null&&labdropDown['responsibleDropDown']!=null&&id!=null){
      for(int i=0;i<labdropDown['responsibleDropDown'].length;i++){
        if(labdropDown['responsibleDropDown'][i]['id']==id){
          responsible_name=labdropDown['responsibleDropDown'][i]['name'];
        }
      }
      return responsible_name;
    }else
      return null;
  }
  String get_status_by_id(int id){
    var training_type_name;

    if(id ==0){
      training_type_name= "Bad";
    }else if(id==1){
      training_type_name='Fair';
    }else if(id==2){
      training_type_name="Good";
    }
    else{
      training_type_name= "empty";
    }
    return training_type_name;
  }
  String get_testtype_by_id(int id){
    var responsible_name;
    if(specificlabtest!=null&&labdropDown['testTypesdropDown']!=null&&id!=null){
      for(int i=0;i<labdropDown['testTypesdropDown'].length;i++){
        if(labdropDown['testTypesdropDown'][i]['id']==id){
          responsible_name=labdropDown['testTypesdropDown'][i]['name'];
        }
      }
      return responsible_name;
    }else
      return null;
  }
}















































//import 'dart:convert';
//import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:horse_management/HMS/my_horses/services/labTest_services.dart';
//import 'lab_test_form.dart';
//
//
//class lab_list extends StatefulWidget{
//  String token;
//  int id;
//
//  lab_list (this.token, this.id);
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _Profile_Page_State(token,id);
//  }
//
//}
//class _Profile_Page_State extends State<lab_list>{
//  int id;
//
//  _Profile_Page_State (this.token,this.id);
//
//  String token,title,dateOfBirth;
//  var specifichorselab,labdropDown;
//  var temp=['',''];
//
//
//  @override
//  void initState () {
//    labtest_services.horseIdLabtest(token, id).then((response){
//      setState(() {
//        print(response);
//        specifichorselab =json.decode(response);
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
//        appBar: AppBar(title: Text("Lab Test"),actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => add_labTest(token)),);
//            },
//          )
//        ],),
//        body: ListView.builder(itemCount:specifichorselab!=null?specifichorselab.length:temp.length,itemBuilder: (context,int index){
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
//          //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
//                  title: Text("abc"),
//                  subtitle: Text(""),
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