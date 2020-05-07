import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/HMS/Training/training_plans.dart';
import 'package:horse_management/HMS/Training/update_training.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Utils.dart';
import 'Add_training.dart';
class trainingPlanList extends StatefulWidget{
  String token;

  trainingPlanList(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return trainingPlanListState(token);
  }

}
class trainingPlanListState extends State<trainingPlanList>{
  String token;
  var horse_list;
  var training_list=[], load_list;
  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Training Plans")),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>training_plan()));
        },

      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return  Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              network_operations.getTrainingPlans(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    isvisible=true;
                    load_list=json.decode(response);
                    training_list = load_list['response'];

                    // print('Training list Length'+training_list.length.toString());
                  });

                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Training Plans List Not Found"),
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
          child: ListView.builder(itemCount:training_list!=null?training_list.length:temp.length,itemBuilder: (context,int index){
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
                            network_operations.changeTrainingPlanVisibility(token, training_list[index]['planId']).then((response){
                              pd.dismiss();
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.green ,
                                  content: Text('Visibility Changed'),
                                ));
                                setState(() {
                                  training_list.removeAt(index);
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
                      icon: Icons.edit,
                      color: Colors.blue,
                      caption: 'Update',
                      onTap: () async {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>update_training(token,training_list[index])));
                      },
                    ),
                  ],
                  child: ListTile(
                    title: Text(training_list!=null?training_list[index]['name']:''),
                    //trailing: Text(training_list!=null?training_list[index]['startDate'].toString().replaceAll("T00:00:00",''):''),
                   // subtitle: Text(training_list!=null?get_training_type_by_id(training_list[index]['trainingType']):''),
                    leading: Icon(Icons.fitness_center,size: 40,color: Colors.teal,),
                    onTap: (){
                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>training_details_page(training_list[index],get_training_type_by_id(training_list[index]['trainingType']))));
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

  trainingPlanListState(this.token);

}