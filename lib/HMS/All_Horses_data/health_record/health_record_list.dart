import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/All_Horses_data/health_record/update_health_record.dart';
import 'package:horse_management/HMS/All_Horses_data/services/health_services.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'health_record_form.dart';


class healthRecord_list extends StatefulWidget{
  String token;


  healthRecord_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<healthRecord_list>{
  int id;SharedPreferences prefs;

  _Profile_Page_State (this.token);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  String token;
  var specifichorsehealthRecord,healthlist;
  var temp=['',''];
  bool isVisible = false;
 // MainPageState _mainPageState;

  @override
  void initState () {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
   // _mainPageState = MainPageState();
//    healthServices.horseIdhealthRecord(token, id).then((response){
//      setState(() {
//        print(response);
//        specifichorsehealthRecord =json.decode(response);
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
        healthServices.healthRecordTestlist(token).then((response) {
          pd.dismiss();
          isVisible = true;
          setState(() {

            healthlist = json.decode(response);


            print(healthlist);
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
        appBar: AppBar(title: Text("Health Record"),actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => health_record_form(token)),);
            },
          )
        ],),
        body: Visibility(
          visible: isVisible,
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: (){
              return Utils.check_connectivity().then((result){
                if(result){
                  healthServices.healthRecordTestlist(token).then((response){
                    // print(response.length.toString());
                    if(response!=null){
                      setState(() {
                        //var parsedjson = jsonDecode(response);
                        healthlist  = jsonDecode(response);
                        print(healthlist);
                        //print(horse_list['createdBy']);
                      });
                    }
                  });
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor:Colors.red ,
                    content: Text('Network Error'),
                  ));
                }
              });
            },
            child: ListView.builder(itemCount:healthlist!=null?healthlist.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  Slidable(

                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.10,
                     closeOnScroll: true,
                    secondaryActions: <Widget>[
                      IconSlideAction(onTap: ()async{
                        healthServices.healthstatus(token, healthlist[index]['id'],0).then((response){
                          //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                          print(response);
                          if(response!=null){

                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.green ,
                              content: Text('Status Changed'),
                            ));

                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.red ,
                              content: Text('Failed'),
                            ));
                          }
                        });
                      },iconWidget: CircleAvatar(radius: 40.0,backgroundColor: Colors.red,),caption: 'Bad',),
                      IconSlideAction(onTap: ()async{
                        healthServices.healthstatus(token, healthlist[index]['id'],1).then((response){
                          //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                          print(response);
                          if(response!=null){

                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.green ,
                              content: Text('Status Changed'),
                            ));

                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.red ,
                              content: Text('Failed'),
                            ));
                          }
                        });

                      },iconWidget: CircleAvatar(radius: 40.0,backgroundColor: Colors.yellow,),caption: 'Fair',),
                      IconSlideAction(onTap: ()async{
                        healthServices.healthstatus(token, healthlist[index]['id'],2).then((response){
                          //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                          print(response);
                          if(response!=null){

                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.green ,
                              content: Text('Status Changed to good'),
                            ));

                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.red ,
                              content: Text('Failed'),
                            ));
                          }
                        });
                      },iconWidget: CircleAvatar(radius: 40.0,backgroundColor: Colors.green,),caption: 'Good',),
                    ],
                    actions: <Widget>[
                      IconSlideAction(onTap: ()async{

                        Navigator.push(context, MaterialPageRoute(builder: (context) => update_health(healthlist[index]['id'],token,prefs.get('createdBy'))),);

                      },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          healthServices.healthvisibilty(token, healthlist[index]['id']).then((response){
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
                    child: ListTile(
                      //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                      title: Text(healthlist!=null?healthlist[index]['horseName']['name'].toString():'name not show'),
                      subtitle: Text(healthlist!=null? "Responsible: "+healthlist[index]['responsibleName']['contactName']['name'].toString():'responsible empty'),
                      trailing: Text(healthlist[index]['status'] != null ? "Status: "+get_status_by_id(healthlist[index]['status']):"empty"),
                      //trailing: healthlist != null ? CircleAvatar(backgroundColor: get_status_by_id(healthlist[index]['status'])):"empty",
                      //leading: Image.asset("Assets/horses_icon.png"),
                      onTap: ()async{
                        print(healthlist[index]['id']);
                        prefs= await SharedPreferences.getInstance();
//                    Scaffold.of(context).showSnackBar(SnackBar(
//                      backgroundColor: Colors.green,
//                      content: Text("Training Updated Sucessfully"),
//                    ));
//                    Utils.createSnackBar("qwerty",context);
                      },
                    ),


                  ),
                  Divider(),
                ],

              );

            }),
          ),
        )
    );
  }
  String get_status_by_id(int id){
    var status;
    if(healthlist!=null && id!=null){
      if(id == 2)
        status = "Good";
      else if(id == 1)
           status = "Fair";
      else if(id == 0)
        status = "Bad";
      return status;
    }else
      return null;
  }

}





