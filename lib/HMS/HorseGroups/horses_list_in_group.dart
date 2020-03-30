import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/All_Horses_data/add_horse/update_horse.dart';
import 'package:horse_management/HMS/All_Horses_data/services/add_horse_services.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'add_horseGroup.dart';
import 'add_horse_to_group.dart';
import 'horsegroup_services.dart';


class HorseListInGroup extends StatefulWidget{
  String token;
  var groupid;

  HorseListInGroup(this.token,this.groupid);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _training_list_state(token,groupid);
  }

}
class _training_list_state extends State<HorseListInGroup>{
  String token;
  var groupid;
  _training_list_state (this.token,this.groupid);
  SharedPreferences prefs;
  var horse_list;
  bool isdynamic=true;
  var temp=[];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    if(groupid['isDynamic'] == true){
      setState(() {
        isdynamic = false;
      });
    }

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
        Add_horsegroup_services.gethorselistOfGroup(token,groupid['id']).then((response){
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
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(" empty"),backgroundColor: Colors.red,));
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
        appBar: AppBar(title: Text(" Horses in Group"),actions: <Widget>[
         // Center(child: Text("Add New",textScaleFactor: 1.3,)),
          Visibility(
            visible: isdynamic,
            child: IconButton(

              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => add_HorseToGroup(token,groupid['id'])));
              },
            ),
          )
        ],),
        body:RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: (){
            return Utils.check_connectivity().then((result){
              if(result){
                Add_horsegroup_services.gethorselistOfGroup(token,groupid['id']).then((response){
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
                    IconSlideAction(onTap: ()async{
                      prefs = await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => update_horse(prefs.get('token'),horse_list[index])));
                    },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
                    IconSlideAction(
                      icon: Icons.delete,
                      color: Colors.red,
                      caption: 'Hide',
                      onTap: () async {
                        Add_horsegroup_services.deleteHorseInGroup(token, horse_list[index]['id']).then((response){
                          //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                          print(response);
                          if(response!=null){

                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.green ,
                              content: Text('Deleted'),
                            ));

                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.red ,
                              content: Text('Failed to Delete'),
                            ));
                          }
                        });
                      },
                    ),
                  ],
                  child: ListTile(
                    //leading: Image.asset("assets/horse_icon.png", fit: BoxFit.cover),
                    title: Text(horse_list!=null?(horse_list[index]['horseName']['name']):''),
                    subtitle: Text(horse_list[index]['horseName']['dateOfBirth']!=null?horse_list[index]['horseName']['dateOfBirth'].toString().substring(0,10):'empty'),
                    //leading: Image.asset("Assets/horses_icon.png"),
                    //trailing: Text(horse_list[index]['isDynamic'] == true ?"Yes":"No"),

                  ),

                  secondaryActions: <Widget>[

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