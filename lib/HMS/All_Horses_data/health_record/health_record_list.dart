import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  String token;
  var specifichorsehealthRecord,healthlist;
  var temp=['',''];
 // MainPageState _mainPageState;

  @override
  void initState () {
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
        body: ListView.builder(itemCount:healthlist!=null?healthlist.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              Slidable(

                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.20,
                secondaryActions: <Widget>[
                  IconSlideAction(onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_health(healthlist[index]['id'],prefs.get('token'),prefs.get('createdBy'))));

                  },color: Colors.blue,icon: Icons.border_color,caption: 'update',)
                ],
                actions: <Widget>[
                  IconSlideAction(
                    icon: Icons.visibility_off,
                    color: Colors.red,
                    caption: 'Hide',
//                    onTap: () async {
//                      Add_horse_services.horsevisibilty(token, horse_list[index]['horseId']).then((response){
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
                  ),
                ],
                child: ListTile(
                  //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                  title: Text(healthlist!=null?healthlist[index]['horseId'].toString():'responsible name not show'),
                  subtitle: Text(healthlist!=null?healthlist[index]['id'].toString():'date not showing'),
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

        })
    );
  }
}





