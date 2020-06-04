import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:horse_management/HMS/Breeding/Flushes/embryo_retrieval_form.dart';
import 'package:horse_management/HMS/Breeding/Flushes/flushes_details.dart';
import 'package:horse_management/HMS/Breeding/Flushes/flushes_update.dart';
import 'package:horse_management/HMS/Breeding/Flushes/utils/flushes_services_json.dart';
import 'package:horse_management/HMS/CareTakers/Flushes/FlushesLateReason.dart';
import 'package:horse_management/HMS/CareTakers/Flushes/flushes_caretaker.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
//import 'embryo_retrieval_form.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
//import 'flushes_update.dart';
//import 'utils/flushes_services_json.dart';



class flushes_caretaker_list extends StatefulWidget{
  String token;
  flushes_caretaker_list(this.token);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _flushes_caretaker_list(token);
  }
}

class _flushes_caretaker_list extends State<flushes_caretaker_list>{
  String token;
  _flushes_caretaker_list(this.token);
  var temp=['','',''];
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var flushes_list, load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_flushes(token)));
//        },
//        child: Icon(Icons.add),
//      ),
      appBar: AppBar(
        title: Text("Flushes Caretaker"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_flushes(token)),);
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
                        FlushesCareTakerServices.flushes_caretaker_by_page(token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list= json.decode(response);
                            flushes_list = load_list['response'];
                            print(flushes_list);
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
                        FlushesCareTakerServices.flushes_caretaker_by_page(
                            token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list = json.decode(response);
                            flushes_list = load_list['response'];
                            print(flushes_list);
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.openBox("FlushesList").then((response){
            Utils.check_connectivity().then((result){
              if(result){
                ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                pd.show();
               // FlushesServicesJson.flusheslist(token).then((response){

                FlushesCareTakerServices.get_flushes_caretaker(token).then((response){
                  pd.dismiss();
                  if(response!=null){
                    setState(() {
                      isVisible=true;
                      load_list=json.decode(response);
                      flushes_list = load_list['response'];
                      total_page=load_list['totalPages'];
                      print(total_page);
                     // Hive.box("FlushesList").put("offline_flushes_list",flushes_list);
                    });

                  }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("List Not Available"),
                    ));
                    setState(() {
                      isVisible=false;
                    });
                  }
                });
              }else{
                setState(() {
                  isVisible=true;
                  //flushes_list=Hive.box("FlushesList").get("offline_flushes_list");
                });
//                    Scaffold.of(context).showSnackBar(SnackBar(
//                      backgroundColor: Colors.red,
//                      content: Text("Network not Available"),
//                    ));
              }
            });
          });
        },
        child: Visibility(
          visible: isVisible,
          child: Scrollbar(
            child: ListView.builder(itemCount:flushes_list!=null?flushes_list.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.20,
                      secondaryActions: <Widget>[
//                      IconSlideAction(
//                        icon: Icons.edit,
//                        color: Colors.blue,
//                        caption: 'Update',
//                        onTap: () async {
//                          Navigator.push(context,MaterialPageRoute(builder: (context)=>flushes_update(token,flushes_list[index])));
//                        },
//                      ),
                      ],
                      actions: <Widget>[
//                      IconSlideAction(
//                        icon: Icons.visibility_off,
//                        color: Colors.red,
//                        caption: 'Hide',
//                        onTap: () async {
//                          FlushesServicesJson.flushesvisibilty(token, flushes_list[index]['id']).then((response){
//                            print(response);
//                            if(response!=null){
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                backgroundColor:Colors.green ,
//                                content: Text('Visibility Changed'),
//                              ));
//                              setState(() {
//                                flushes_list.removeAt(index);
//                              });
//
//                            }else{
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                backgroundColor:Colors.red ,
//                                content: Text('Failed'),
//                              ));
//                            }
//                          });
//                        },
//                      ),
                        IconSlideAction(
                          icon: Icons.timer,
                          color: Colors.deepOrange,
                          caption: 'Start',
                          onTap: () async {
                            Utils.check_connectivity().then((result){
                              if(result){
                                ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                                pd.show();
                                FlushesCareTakerServices.start_flushes(token, flushes_list[index]['id']).then((response){
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
                            print(flushes_list[index]);
                            print(DateTime.parse(flushes_list[index]['date']));
                            if(DateTime.now().isAfter(DateTime.parse(flushes_list[index]['date'])) )
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>flushes_late_reason(token, flushes_list[index]['id'])));
                            else{
                              Utils.check_connectivity().then((result){
                                if(result){
                                  ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                                  pd.show();
                                  FlushesCareTakerServices.complete_flushes(token, flushes_list[index]['id']).then((response){
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

//                        onTap: () async {
//                          Utils.check_connectivity().then((result){
//                            if(result){
//                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
//                              pd.show();
//                              FlushesCareTakerServices.complete_flushes(token, flushes_list[index]['id']).then((response){
//                                pd.dismiss();
//                                if(response!=null){
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                    backgroundColor:Colors.green ,
//                                    content: Text('Process Complete'),
//                                  ));
////                                  setState(() {
////                                    control_list.removeAt(index);
////                                  });
//                                }else{
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                    backgroundColor:Colors.red ,
//                                    content: Text('Process Failed'),
//                                  ));
//                                }
//                              });
//                            }else{
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                content: Text("Network not Available"),
//                                backgroundColor: Colors.red,
//                              ));
//                            }
//                          });
//
//                        },
                        ),
                      ],
                      child: FadeAnimation(2.0,
                         ListTile(
                          title: Text(flushes_list!=null?flushes_list[index]['horseName']['name']:''),
                          subtitle: Text(flushes_list!=null?flushes_list[index]['vetName']['contactName']['name']:''),
                           trailing:Text(flushes_list!=null?get_status_by_id(flushes_list[index]['status']):''),

                           //trailing: Text(flushes_list!=null?flushes_list[index]['date']:''),
                          onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => flushes_details_page(flushes_list[index])));
                           // Navigator.push(context, MaterialPageRoute(builder: (context) => hypothetic_pedegree_page(flushes_list[index])));
                          },
                        ),
                      )
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