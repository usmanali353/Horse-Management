import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/CareTakers/VetVisit/VetVisitCaretaker.dart';
import 'package:horse_management/HMS/CareTakers/VetVisit/VetVisitLateReason.dart';
import 'package:horse_management/HMS/Diet/add_Diet.dart';
import 'package:horse_management/HMS/Diet/diet_services.dart';
import 'package:horse_management/HMS/Training/training_plans.dart';
import 'package:horse_management/HMS/Training/update_training.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/addVetVisits.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/veterniaryServices.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';

class vetVisit_caretaker_List extends StatefulWidget{
  String token;

  vetVisit_caretaker_List(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return vetVisit_caretaker_ListState(token);
  }

}
class vetVisit_caretaker_ListState extends State<vetVisit_caretaker_List>{
  String token;
  var vetvisits_list=[], load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;
  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vet Visits & Caretaker"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => addVetVisits(token)),);
            },
          )
//          IconButton(
//            icon: Icon(Icons.picture_as_pdf),
//           // onPressed: () => _generatePdfAndView(context),
//          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(child: Icon(Icons.arrow_back),heroTag: "btn2", onPressed: () {

                  if(load_list['hasPrevious'] == true && pagenum >= 1 ) {
                    Utils.check_connectivity().then((result){
                      if(result) {
                        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                        pd.show();
                        VetVisitCareTakerServices.vetVisit_caretaker_by_page(token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list= json.decode(response);
                            vetvisits_list = load_list['response'];
                            print(vetvisits_list);
                          });
                        });
                      }else
                        print("Network Not Available");
                    });
                  }
                  else{
                    print("Empty List");
                    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("List empty"),));
                  }
                  if(pagenum > 1){
                    pagenum = pagenum - 1;
                  }
                  print(pagenum);
                }),
                FloatingActionButton(child: Icon(Icons.arrow_forward),heroTag: "btn1", onPressed: () {
                  print(load_list['hasNext']);
                  if(load_list['hasNext'] == true && pagenum >= 1 ) {
                    Utils.check_connectivity().then((result){
                      if(result) {
                        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                        pd.show();
                        VetVisitCareTakerServices.vetVisit_caretaker_by_page(
                            token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list = json.decode(response);
                            vetvisits_list = load_list['response'];
                            print(vetvisits_list);
                          });
                        });
                      }else
                        print("Network Not Available");
                    });
                  }
                  else{
                    print("Empty List");
                    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("List empty"),));
                  }
                  if(pagenum < total_page) {
                    pagenum = pagenum + 1;
                  }
                  print(pagenum);

                })
              ]
          )
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(
//          Icons.add,
//          color: Colors.white,
//        ),
//        onPressed: (){
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>addVetVisits(token)));
//        },
//
//      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return  Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              //vieterniaryServices.getVetVisits(token).then((response){
              VetVisitCareTakerServices.get_vetVisit_caretaker(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    isvisible=true;
                    load_list=json.decode(response);
                    vetvisits_list = load_list['response'];
                    total_page=load_list['totalPages'];
                    print(total_page);
                  });

                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Vet Visits List Not Found"),
                  ));
                  setState(() {
                    isvisible=false;
                  });
                }
              });
            }else{
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Network not Available"),
              ));
            }
          });
        },
        child: Visibility(
          visible: isvisible,
          child: Scrollbar(
            child: ListView.builder(itemCount:vetvisits_list!=null?vetvisits_list.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    actions: <Widget>[
//                    IconSlideAction(
//                      icon: Icons.visibility_off,
//                      color: Colors.red,
//                      caption: 'Hide',
//                      onTap: () async {
//                        Utils.check_connectivity().then((result){
//                          if(result){
//                            ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
//                            pd.show();
//                            vieterniaryServices.changeVetVisitsVisibility(token, vetvisits_list[index]['vetVisitId']).then((response){
//                              pd.dismiss();
//                              if(response!=null){
//                                Scaffold.of(context).showSnackBar(SnackBar(
//                                  backgroundColor:Colors.green ,
//                                  content: Text('Visibility Changed'),
//                                ));
//                                setState(() {
//                                  vetvisits_list.removeAt(index);
//                                });
//                              }else{
//                                Scaffold.of(context).showSnackBar(SnackBar(
//                                  backgroundColor:Colors.red ,
//                                  content: Text('Failed'),
//                                ));
//                              }
//                            });
//                          }else{
//                            Scaffold.of(context).showSnackBar(SnackBar(
//                              content: Text("Network not Available"),
//                              backgroundColor: Colors.red,
//                            ));
//                          }
//                        });
//
//                      },
//                    ),
                      IconSlideAction(
                        icon: Icons.timer,
                        color: Colors.deepOrange,
                        caption: 'Start',
                        onTap: () async {
                          Utils.check_connectivity().then((result){
                            if(result){
                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                              pd.show();
                              VetVisitCareTakerServices.start_vetVisit(token, vetvisits_list[index]['vetVisitId']).then((response){
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
                          print(vetvisits_list[index]);
                          print(DateTime.parse(vetvisits_list[index]['date']));
                          if(DateTime.now().isAfter(DateTime.parse(vetvisits_list[index]['date'])) )
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>vetvisit_late_reason(token, vetvisits_list[index]['vetVisitId'])));
                          else{
                            Utils.check_connectivity().then((result){
                              if(result){
                                ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                                pd.show();
                                VetVisitCareTakerServices.complete_vetVisit(token, vetvisits_list[index]['vetVisitId']).then((response){
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
//                      onTap: () async {
//                        Utils.check_connectivity().then((result){
//                          if(result){
//                            ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
//                            pd.show();
//                            VetVisitCareTakerServices.complete_vetVisit(token, vetvisits_list[index]['vetVisitId']).then((response){
//                              pd.dismiss();
//                              if(response!=null){
//                                Scaffold.of(context).showSnackBar(SnackBar(
//                                  backgroundColor:Colors.green ,
//                                  content: Text('Process Complete'),
//                                ));
////                                  setState(() {
////                                    control_list.removeAt(index);
////                                  });
//                              }else{
//                                Scaffold.of(context).showSnackBar(SnackBar(
//                                  backgroundColor:Colors.red ,
//                                  content: Text('Process Failed'),
//                                ));
//                              }
//                            });
//                          }else{
//                            Scaffold.of(context).showSnackBar(SnackBar(
//                              content: Text("Network not Available"),
//                              backgroundColor: Colors.red,
//                            ));
//                          }
//                        });
//
//                      },
                      ),

//                    IconSlideAction(
//                      icon: Icons.edit,
//                      color: Colors.blue,
//                      caption: 'Update',
//                      onTap: () async {
//                        // Navigator.push(context,MaterialPageRoute(builder: (context)=>update_training(token,training_list[index])));
//                      },
//                    ),
                    ],
                    child: ListTile(
                      title: Text(vetvisits_list!=null?vetvisits_list[index]['horseName']['name']:''),
                      trailing:Text(vetvisits_list!=null?get_status_by_id(vetvisits_list[index]['status']):''),

                      //leading: Icon(Icons.local_hospital,size: 40,color: Colors.teal,),
                      onTap: (){
                      },
                    ),


                  ),
                  Divider(),
                ],

              );

            }),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  vetVisit_caretaker_ListState(this.token);

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