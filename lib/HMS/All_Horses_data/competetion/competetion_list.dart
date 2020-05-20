import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/competetion/add_competetion.dart';
import 'package:horse_management/HMS/All_Horses_data/competetion/update_competetion.dart';
import 'package:horse_management/HMS/All_Horses_data/services/competetion_services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils.dart';


class competetion_list extends StatefulWidget{
  String token;


  competetion_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<competetion_list>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);

  String token;
  var competetionlist, load_list;
  var temp=['',''];


  @override
  void initState () {



    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        competetion_services.competetion_list(token).then((response) {
          pd.dismiss();
          setState(() {
            print(response);
            load_list = json.decode(response);
            competetionlist = load_list['response'];
          });
        });
      }else
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("network error"),
        ));
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Competetion"),actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_competetion(token)),);
            },
          )
        ],),
        body: ListView.builder(itemCount:competetionlist!=null?competetionlist.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.20,
                actions: <Widget>[
                  IconSlideAction(onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_competetion(competetionlist[index],prefs.get('token'))));

                  },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
                  IconSlideAction(
                    icon: Icons.visibility_off,
                    color: Colors.red,
                    caption: 'Hide',
                    onTap: () async {
                      competetion_services.competetionVisibilty(token, competetionlist[index]['id']).then((response){
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
                  enabled: competetionlist[index]['isActive']!= null ? competetionlist[index]['isActive']:true,
                  //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                  title: Text(competetionlist!=null?(competetionlist[index]['horseName']['name']):'Horse Name'),
                  trailing: Text(competetionlist!=null?'Performance :'+(competetionlist[index]['performanceTypeName']['name']):'performance not showing'),
                  subtitle: Text(competetionlist[index]['date'] != null ? competetionlist[index]['date'].toString().substring(0,10):""),
                  //leading: Image.asset("Assets/horses_icon.png"),
                  onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    print((competetionlist[index]));
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
