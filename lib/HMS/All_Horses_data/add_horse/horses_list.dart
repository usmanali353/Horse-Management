import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/All_Horses_data/add_horse/add_horse_new.dart';
import 'package:horse_management/HMS/All_Horses_data/add_horse/update_horse.dart';
import 'package:horse_management/HMS/All_Horses_data/services/add_horse_services.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/Network_Operations.dart';




class horse_list extends StatefulWidget{
  String token;

  horse_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _training_list_state(token);
  }

}
class _training_list_state extends State<horse_list>{
  String token;
  String createdBy;
  _training_list_state (this.token);
  SharedPreferences prefs;
  var horse_list;
  var temp=['',''];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
//    setState(() {
//      String createdBy = horse_list['createdBy'];
//      print(horse_list);
//    });
    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        Add_horse_services.horselist(token).then((response){
          pd.dismiss();
          // print(response.length.toString());
          if(response!=null){
            setState(() {
              //var parsedjson = jsonDecode(response);
              horse_list  = jsonDecode(response);
              print(horse_list);
              //print(horse_list['createdBy']);
            });

          }else{
             Scaffold.of(context).showSnackBar(SnackBar(content: Text("hoser list empty"),backgroundColor: Colors.red,));
          }
        });
      }else
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Network Error")
        ));
    });


  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("All Horses "),actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.5,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_newHorse(token)),);
            },
          )
        ],),
        body:RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: (){
            return Utils.check_connectivity().then((result){
              if(result){
                Add_horse_services.horselist(token).then((response){
                  // print(response.length.toString());
                  if(response!=null){
                    setState(() {
                      //var parsedjson = jsonDecode(response);
                      horse_list  = jsonDecode(response);
                      print(horse_list);
                      //print(horse_list['createdBy']);
                    });
                  }
                });
              }else{
                print("network not available");
              }
            });
          },
          child: ListView.builder(itemCount:horse_list!=null?horse_list.length:temp.length,itemBuilder: (context,int index){
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
                        Add_horse_services.horsevisibilty(token, horse_list[index]['horseId']).then((response){
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
                    title: Text(horse_list!=null?(horse_list[index]['name']):''),
                    subtitle: Text(horse_list!=null?horse_list[index]['dateOfBirth'].toString():''),
                    //leading: Image.asset("Assets/horses_icon.png"),
                    onTap: ()async{
                      setState(() {
                         createdBy=horse_list[index]['createdBy'];
                      });
                      prefs = await SharedPreferences.getInstance();

                    },
                  ),

                 secondaryActions: <Widget>[
                   IconSlideAction(onTap: ()async{
                     prefs = await SharedPreferences.getInstance();
                     Navigator.push(context, MaterialPageRoute(builder: (context) => update_horse(prefs.get('token'),horse_list[index])),);
                   },color: Colors.blue,icon: Icons.border_color,caption: 'update',)
                 ],
                ),
                Divider(),
              ],

            );

          }),
        )

    );
  }



  }








//class horse_list extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _Profile_Page_State();
//  }
//}
//
//class _Profile_Page_State extends State<horse_list> {
//  String title, dateOfBirth;
//  var horselist;
//  List<String> horse = [];
//  var token;
//
//  @override
//  void initState() {
//    Add_horse_services.horselist(token).then((response) {
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        horselist = jsonDecode(response);
//        print(horselist);
//        horse.add(horselist);
//
//        for (int i = 0; i < horselist.length; i++)
//          horse.add(horselist[i]['name']);
//        print(horse.length.toString());
//      });
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("My Horses"),
//        actions: <Widget>[
//          Center(
//              child: Text(
//            "Add New",
//            textScaleFactor: 1.5,
//          )),
//          IconButton(
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () async {
//              SharedPreferences prefs = await SharedPreferences.getInstance();
//              token = await prefs.getString("token");
//
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => add_newHorse(token)),
//              );
//            },
//          )
//        ],
//      ),
//      body: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.all(20.0),
//            child: ListView(
//              shrinkWrap: true,
//              children: <Widget>[
//                ListTile(
//                  title: Text("mkk"),
//                  subtitle: Text("Horse Date of Birth"),
//                  trailing: Icon(Icons.arrow_right),
//                  leading: Image.asset("Assets/horse_icon.png",width: 50,height: 50,),
//                  onTap: (){
//                    Navigator.push(context,MaterialPageRoute(builder: (context)=>horse_detail()));
//                  },
//                ),
//                ListTile(
//                  title: Text("kj"),
//                  subtitle: Text("20/12/2018"),
//                  leading: Image.asset("Assets/horse_icon.png",width: 50,height: 50,),
//                  trailing: Icon(Icons.arrow_right),
//                  onTap: (){
//                    Navigator.push(context,MaterialPageRoute(builder: (context)=>horse_detail()));
//                  },
//                ),
//
//              ],
//            ),
//          ),
//        ],
//      )
//    );
//  }
//}
