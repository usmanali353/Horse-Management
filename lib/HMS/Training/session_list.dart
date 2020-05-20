import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Breeding/BreedingControl/breeding_control_details.dart';
import 'package:horse_management/HMS/Breeding/BreedingControl/breeding_control_form.dart';
import 'package:horse_management/HMS/Breeding/BreedingControl/next_breeding_check.dart';
import 'package:horse_management/HMS/Breeding/BreedingControl/update_breeding_control.dart';
import 'package:horse_management/HMS/Training/add_training_session.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';


class training_session_list extends StatefulWidget{
  String token;
  var specslist;

  training_session_list(this.token,this.specslist);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _training_session_list(token,specslist);
  }

}
class _training_session_list extends State< training_session_list>{
  String token;
  var specslist;
  _training_session_list(this.token,this.specslist);
  bool isVisible=false;
  var temp=['',''];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var control_list, load_list;

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
      appBar: AppBar(
        title: Text("Breeding Control & Caretaker"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_training_session(token,specslist)),);
            },
          )
//          IconButton(
//            icon: Icon(Icons.picture_as_pdf),
//           // onPressed: () => _generatePdfAndView(context),
//          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              network_operations.training_session_list(token,specslist['trainingId']).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    load_list=json.decode(response);
                    control_list = load_list['response'];
                    isVisible=true;
                  });

                }else{
                  setState(() {
                    isVisible=false;
                  });
                }
              });
            }else{
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Network Not Available"),
              ));
            }
          });
        },
        child: Visibility(
          visible: isVisible,
          child: ListView.builder(itemCount:control_list!=null?control_list.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        icon: Icons.edit,
                        color: Colors.blue,
                        caption: 'Update',
                        onTap: () async {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_breeding_control(token,control_list[index])));
                        },
                      ),
                      IconSlideAction(
                        icon: Icons.access_time,
                        color: Colors.deepPurple,
                        caption: 'Next Check',
                        onTap: () async {
                          print(control_list[index]);
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>next_breeding_check(token, control_list[index]['breedingControlId'])));
                        },
                      ),
                    ],
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.pinkAccent,
                        caption: 'Hide',
                        onTap: () async {
                          Utils.check_connectivity().then((result){
                            if(result){
                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                              pd.show();
                              network_operations.session_visibility(token, control_list[index]['id']).then((response){
                                pd.dismiss();
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Visibility Changed'),
                                  ));
                                  setState(() {
                                    control_list.removeAt(index);
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
                        icon: Icons.delete_forever,
                        color: Colors.red,
                        caption: 'Delete',
                        onTap: () async {
                          Utils.check_connectivity().then((result){
                            if(result){
                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                              pd.show();
                              network_operations.session_deletion(token, control_list[index]['id']).then((response){
                                pd.dismiss();
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('session deleted'),
                                  ));
                                  setState(() {
                                    control_list.removeAt(index);
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

                    ],
                    child: FadeAnimation(2.0,
                      ListTile(
                        enabled: control_list[index]['isActive']!=null?control_list[index]['isActive']:true,
                      //title: Text("Anc"),
                        trailing:Text(control_list!=null?control_list[index]['date'].toString().substring(0,10):''),
                        title: Text(control_list[index]['trainerId']!=null?control_list[index]['trainerName']['contactName']['name']:''),
                        subtitle: Text(control_list[index]['comments']!=null?'Comments: '+control_list[index]['comments']:'empty'),
                        //leading: Icon(Icons.pets,size: 40,color: Colors.teal,),
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => breeding_control_details_page(control_list[index], get_check_method_by_id(control_list[index]['check_Method']))));
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
    );
  }

  String get_check_method_by_id(int id){
    var check_method;
    if(control_list!=null&&id!=null){
      if(id==1){
        check_method="Palpation";
      }else if(id==2){
        check_method="Ultrasound";
      }else if(id==3){
        check_method="Visual Observation";
      }else{
        check_method="Blood Test";
      }
    }
    return check_method;
  }
}