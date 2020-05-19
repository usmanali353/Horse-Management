import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/farrier/add_farrier.dart';
import 'package:horse_management/HMS/All_Horses_data/farrier/updateFarrier.dart';
import 'package:horse_management/HMS/All_Horses_data/lab_reports/update_lab_reports.dart';
import 'package:horse_management/HMS/All_Horses_data/services/vaccination_services.dart';
import 'package:horse_management/HMS/All_Horses_data/vaccination/add_vaccination_form.dart';
import 'package:horse_management/HMS/All_Horses_data/vaccination/update_vaccination.dart';
import 'package:horse_management/HMS/CareTakers/Vaccination/VaccinationCaretaker.dart';
import 'package:horse_management/HMS/CareTakers/Vaccination/VaccinationLateReason.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class vaccination_caretaker_list extends StatefulWidget{
  String token;


  vaccination_caretaker_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<vaccination_caretaker_list>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);

  String token;
  var vaccinationlist, load_list;
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
        //vaccination_services.vaccination_list(token).then((response) {
          VaccinationCareTakerServices.get_vaccination_caretaker(token).then((response) {
          pd.dismiss();
          setState(() {
            print(response);
            load_list = json.decode(response);
            vaccinationlist = load_list['response'];
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
        appBar: AppBar(title: Text("Vaccination & Caretaker"),actions: <Widget>[
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
//                  IconSlideAction(onTap: ()async{
//                    prefs = await SharedPreferences.getInstance();
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_vaccination(vaccinationlist[index],prefs.get('token'),prefs.get('createdBy'))));
//
//                  },color: Colors.blue,icon: Icons.mode_edit,caption: 'update',),
//                  IconSlideAction(
//                    icon: Icons.visibility_off,
//                    color: Colors.red,
//                    caption: 'Hide',
//                    onTap: () async {
//                      vaccination_services.vaccinationVisibilty(token, vaccinationlist[index]['id']).then((response){
//                        //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
//                        print(response);
//                        if(response!=null){
//
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            backgroundColor:Colors.green ,
//                            content: Text('Visibility Changed'),
//                          ));
//                          setState(() {
//                            vaccinationlist.removeAt(index);
//                          });
//
//                        }else{
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            backgroundColor:Colors.red ,
//                            content: Text('Failed'),
//                          ));
//                        }
//                      });
//                    },
//                  ),
                  IconSlideAction(
                    icon: Icons.timer,
                    color: Colors.deepOrange,
                    caption: 'Start',
                    onTap: () async {
                      Utils.check_connectivity().then((result){
                        if(result){
                          ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                          pd.show();
                          VaccinationCareTakerServices.start_vaccination(token, vaccinationlist[index]['id']).then((response){
                            pd.dismiss();
                            if(response!=null){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.green ,
                                content: Text('Process Started'),
                              ));
//                                  setState(() {
//                                    control_list.removeAt(index);
//                                  });
                            }else{
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.red ,
                                content: Text('Process Failed'),
                              ));
                            }
                          });
                        }else{
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Network not Available"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      });

                    },
                  ),
                  IconSlideAction(
                    icon: Icons.done_all,
                    color: Colors.green,
                    caption: 'Complete',
                    onTap: () async {
                      print(vaccinationlist[index]);
                      print(DateTime.parse(vaccinationlist[index]['date']));
                      if(DateTime.now().isAfter(DateTime.parse(vaccinationlist[index]['date'])) )
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>vaccination_late_reason(token, vaccinationlist[index]['id'])));
                      else{
                        Utils.check_connectivity().then((result){
                          if(result){
                            ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                            pd.show();
                            VaccinationCareTakerServices.complete_vaccination(token, vaccinationlist[index]['id']).then((response){
                              pd.dismiss();
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.green ,
                                  content: Text('Completed'),
                                ));
                                setState(() {
                                  //  control_list.removeAt(index);
                                });
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.red ,
                                  content: Text('Process Failed'),
                                ));
                              }
                            });
                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Network not Available"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        });
                      }
                    },
//                    onTap: () async {
//                      Utils.check_connectivity().then((result){
//                        if(result){
//                          ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
//                          pd.show();
//                          VaccinationCareTakerServices.complete_vaccination(token, vaccinationlist[index]['id']).then((response){
//                            pd.dismiss();
//                            if(response!=null){
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                backgroundColor:Colors.green ,
//                                content: Text('Process Complete'),
//                              ));
////                                  setState(() {
////                                    control_list.removeAt(index);
////                                  });
//                            }else{
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                backgroundColor:Colors.red ,
//                                content: Text('Process Failed'),
//                              ));
//                            }
//                          });
//                        }else{
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            content: Text("Network not Available"),
//                            backgroundColor: Colors.red,
//                          ));
//                        }
//                      });
//
//                    },
                  ),

                ],
                child: ListTile(
                  //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                  title: Text(vaccinationlist!=null?(vaccinationlist[index]['horseName']['name']):' '),
                  subtitle: Text(vaccinationlist!=null?'Vaccine: '+(vaccinationlist[index]['vaccineName']['name']):'farrier name not showing'),
                  trailing:Text(vaccinationlist!=null?get_status_by_id(vaccinationlist[index]['status']):''),

                  //trailing: Text(vaccinationlist[index]['vetId']!=null?'Vet: '+(vaccinationlist[index]['vetName']['contactName']['name']):'Vet name empty'),
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
  String get_status_by_id(int id){
    var status;

    if(id ==0){
      status= "Not started";
    }else if(id==1){
      status='Started';
    }else if(id==2){
      status="Complete";
    }
    else if(id==3){
      status="Late Complete";
    }
    else{
      status= "empty";
    }
    return status;
  }
}
