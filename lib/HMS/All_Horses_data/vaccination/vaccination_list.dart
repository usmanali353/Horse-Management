import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/farrier/add_farrier.dart';
import 'package:horse_management/HMS/All_Horses_data/farrier/updateFarrier.dart';
import 'package:horse_management/HMS/All_Horses_data/lab_reports/update_lab_reports.dart';
import 'package:horse_management/HMS/All_Horses_data/services/vaccination_services.dart';
import 'package:horse_management/HMS/All_Horses_data/vaccination/add_vaccination_form.dart';
import 'package:horse_management/HMS/All_Horses_data/vaccination/update_vaccination.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class vaccination_list extends StatefulWidget{
  String token;


  vaccination_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<vaccination_list>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);

  String token;
  var vaccinationlist;
  var temp=[];


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
        vaccination_services.vaccination_list(token).then((response) {
          pd.dismiss();
          setState(() {
            print(response);
            vaccinationlist = json.decode(response);
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
        appBar: AppBar(title: Text("Vaccination"),actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_vaccination(token)),);
            },
          )
        ],),
        body: ListView.builder(itemCount:vaccinationlist!=null?vaccinationlist.length:temp.length,itemBuilder: (context,int index){
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
                      vaccination_services.vaccinationVisibilty(token, vaccinationlist[index]['id']).then((response){
                        //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                        print(response);
                        if(response!=null){

                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor:Colors.green ,
                            content: Text('Visibility Changed'),
                          ));
                          setState(() {
                            vaccinationlist.removeAt(index);
                          });

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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_vaccination(vaccinationlist[index],prefs.get('token'),prefs.get('createdBy'))));

                  },color: Colors.blue,icon: Icons.mode_edit,caption: 'update',)
                ],
                child: ListTile(
                  //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                  title: Text(vaccinationlist!=null?(vaccinationlist[index]['horseName']['name']):' '),
                  subtitle: Text(vaccinationlist!=null?'Vaccine'+(vaccinationlist[index]['vaccineName']['name']):'farrier name not showing'),
                  trailing: Text(vaccinationlist!=null?'Vet'+(vaccinationlist[index]['vetName']['contactName']['name']):'Vet name empty'),
                  onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    print((vaccinationlist[index]));
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
