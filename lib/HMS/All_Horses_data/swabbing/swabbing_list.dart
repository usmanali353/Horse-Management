import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/competetion/add_competetion.dart';
import 'package:horse_management/HMS/All_Horses_data/competetion/update_competetion.dart';
import 'package:horse_management/HMS/All_Horses_data/services/swabbing_services.dart';
import 'package:horse_management/HMS/All_Horses_data/swabbing/update_swabbing.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class swabbing_list extends StatefulWidget{
  String token;


  swabbing_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<swabbing_list>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);

  String token;
  var swabbinglist;
  var temp=['',''];


  @override
  void initState () {


    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        swabbing_services.swabbing_list(token).then((response) {
          pd.dismiss();
          setState(() {
            print(response);
            swabbinglist = json.decode(response);
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
        body: ListView.builder(itemCount:swabbinglist!=null?swabbinglist.length:temp.length,itemBuilder: (context,int index){
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
                      swabbing_services.swabbingVisibilty(token, swabbinglist[index]['id']).then((response){
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
                  title: Text(swabbinglist!=null?(swabbinglist[index]['horseName']['name']):'Horse Name'),
                  subtitle: Text(swabbinglist!=null?(swabbinglist[index]['swabbingDate']):'performance not showing'),
                  trailing: Text(swabbinglist!=null?(swabbinglist[index]['antibiotic']):'performance not showing'),
                  onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    print((swabbinglist[index]));
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>update_labTest(lablist[index]['id'],prefs.get('token'),prefs.get('createdBy'))));
                  },
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_swabbing(swabbinglist[index],prefs.get('token'))));

                  },color: Colors.blue,icon: Icons.border_color,caption: 'update',)
                ],

              ),
              Divider(),
            ],

          );

        })
    );
  }

}
