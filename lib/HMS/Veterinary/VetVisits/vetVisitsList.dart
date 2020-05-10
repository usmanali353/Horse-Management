import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/CareTakers/VetVisit/VetVisitCaretaker.dart';
import 'package:horse_management/HMS/Diet/add_Diet.dart';
import 'package:horse_management/HMS/Diet/diet_services.dart';
import 'package:horse_management/HMS/Training/training_plans.dart';
import 'package:horse_management/HMS/Training/update_training.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/addVetVisits.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/veterniaryServices.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';

class vetVisitList extends StatefulWidget{
  String token;

  vetVisitList(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return vetVisitListState(token);
  }

}
class vetVisitListState extends State<vetVisitList>{
  String token;
  var vetvisits_list=[], load_list;
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
        ],),

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
          child: ListView.builder(itemCount:vetvisits_list!=null?vetvisits_list.length:temp.length,itemBuilder: (context,int index){
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
                        Utils.check_connectivity().then((result){
                          if(result){
                            ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                            pd.show();
                            vieterniaryServices.changeVetVisitsVisibility(token, vetvisits_list[index]['vetVisitId']).then((response){
                              pd.dismiss();
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.green ,
                                  content: Text('Visibility Changed'),
                                ));
                                setState(() {
                                  vetvisits_list.removeAt(index);
                                });
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.red ,
                                  content: Text('Failed'),
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
                        Utils.check_connectivity().then((result){
                          if(result){
                            ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                            pd.show();
                            VetVisitCareTakerServices.complete_vetVisit(token, vetvisits_list[index]['vetVisitId']).then((response){
                              pd.dismiss();
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.green ,
                                  content: Text('Process Complete'),
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
                      icon: Icons.edit,
                      color: Colors.blue,
                      caption: 'Update',
                      onTap: () async {
                        // Navigator.push(context,MaterialPageRoute(builder: (context)=>update_training(token,training_list[index])));
                      },
                    ),
                  ],
                  child: ListTile(
                    title: Text(vetvisits_list!=null?vetvisits_list[index]['horseName']['name']:''),
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
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  vetVisitListState(this.token);

}