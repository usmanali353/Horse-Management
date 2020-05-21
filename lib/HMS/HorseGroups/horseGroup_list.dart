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
import 'horses_list_in_group.dart';


class horseGroup_list extends StatefulWidget{
  String token;

  horseGroup_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _training_list_state(token);
  }

}
class _training_list_state extends State<horseGroup_list>{
  String token;
  _training_list_state (this.token);
  SharedPreferences prefs;
  var group_list, load_list;
  var temp=['',''];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
//    setState(() {
//      String createdBy = group_list['createdBy'];
//      print(group_list);
//    });
    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        Add_horsegroup_services.horsegrouplist(token).then((respons){
          pd.dismiss();
          // print(response.length.toString());
          if(respons!=null){
            setState(() {
              //var parsedjson = jsonDecode(response);
              print(respons);
              print("object");
              load_list  = jsonDecode(respons);
              group_list = load_list['response'];
              print(group_list);
              //print(group_list['createdBy']);
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
        appBar: AppBar(title: Text(" Horses Group"),
          actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_HorseGroup(token)),);
            },
          )
        ],
        ),
        body:RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: (){
            return Utils.check_connectivity().then((result){
              if(result){
                Add_horsegroup_services.horsegrouplist(token).then((respons){
                  // print(response.length.toString());
                  if(respons!=null){
                    setState(() {
                      //var parsedjson = jsonDecode(response);
                      load_list  = jsonDecode(respons);
                      group_list = load_list['response'];
                      //print(group_list['createdBy']);
                    });
                  }
                });
              }else{
                print("network not available");
              }
            });
          },
          child: ListView.builder(itemCount:group_list!=null?group_list.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.20,
                  actions: <Widget>[
                    IconSlideAction(onTap: ()async{
                      prefs = await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => update_horse(prefs.get('token'),group_list[index])));
                    },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
                    IconSlideAction(
                      icon: Icons.visibility_off,
                      color: Colors.red,
                      caption: 'Hide',
                      onTap: () async {
                        Add_horsegroup_services.horsegroupvisibilty(token, group_list[index]['id']).then((response){
                          //replytile.removeWhere((item) => item.id == group_list[index]['horseId']);
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
                    //title: Text("abc"),
                    //leading: Image.asset("assets/horse_icon.png", fit: BoxFit.cover),
                    title: Text(group_list!=null?group_list[index]['name']:'Empty'),
                    subtitle: Text(group_list!=null?"Comment: "+group_list[index]['comments'].toString():''),
                    //leading: Image.asset("Assets/horses_icon.png"),
                   trailing: Text(group_list[index]['isDynamic'] == true ?"Dynamic: "+"Yes":"No"),
                    onTap: (){
                      print(group_list[index]);
//                      print(group_list[index]['isActive']);
//                      print(group_list[index]['isDynamic']);
                      //prefs = await SharedPreferences.getInstance();
                      if(group_list[index]['isActive'] == true) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HorseListInGroup(token, group_list[index])));
                      }
                    },
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