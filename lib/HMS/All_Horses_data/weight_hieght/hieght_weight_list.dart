import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/lab_reports/update_lab_reports.dart';
import 'package:horse_management/HMS/All_Horses_data/services/weight_hieght_services.dart';
import 'package:horse_management/HMS/All_Horses_data/weight_hieght/add_weight_and_height.dart';
import 'package:horse_management/HMS/All_Horses_data/weight_hieght/update_hieght_weight.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class weight_hieght_list extends StatefulWidget{
  String token;


  weight_hieght_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<weight_hieght_list>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);

  String token;
  var weightlist, load_list;
  var temp=['',''];


  @override
  void initState () {
//    labtest_services.horseIdLabtest(token, id).then((response){
//      setState(() {
//        print(response);
//        specifichorselab =json.decode(response);
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
        weight_hieght_services.weight_hieght_list(token).then((response){
          pd.dismiss();
          setState(() {
            print(response);
            load_list =json.decode(response);
            weightlist = load_list['response'];

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
        appBar: AppBar(title: Text("Weight & Height"),actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_weight_and_height(token)),);
            },
          )
        ],),
        body: ListView.builder(itemCount:weightlist!=null?weightlist.length:temp.length,itemBuilder: (context,int index){
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
                      weight_hieght_services.weight_hieghtvisibilty(token, weightlist[index]['whid']).then((response){
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
                  IconSlideAction(onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_weight_and_height(weightlist[index],prefs.get('token'))));

                  },color: Colors.blue,icon: Icons.border_color,caption: 'update',)
                ],
                child: ListTile(
                enabled: weightlist[index]['isActive']!=null?weightlist[index]['isActive']:true,
                  //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                  title: Text(weightlist!=null?(weightlist[index]['horseName']['name']):''),
                  subtitle: Text(weightlist[index]['weight']!=null?"Weight: "+(weightlist[index]['weight']).toString():'weight empty'),
                  trailing: Text(weightlist[index]['height']!=null?"Height: "+(weightlist[index]['height']).toString():'hieght empty'),
                  //leading: Image.asset("Assets/horses_icon.png"),
                  onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    print((weightlist[index]));
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>update_weight_and_height(weightlist[index]['id'],prefs.get('token'),prefs.get('createdBy'))));
                  },
                ),

//               secondaryActions: <Widget>[
//
//               ],
              ),
              Divider(),
            ],

          );

        })
    );
  }

}